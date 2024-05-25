import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story_stack/core/common/appbar/appbar.dart';
import 'package:story_stack/view/book_details_view.dart';
import 'package:story_stack/view/series_details_view.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  late String _selectedCategory = 'fiction';
  late String _selectedCategoryS = '16';
  int _selectedTabIndex = 0;

  Future<List<dynamic>> fetchBooks(String category) async {
    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=subject:$category'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['items'] ?? [];
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<dynamic>> fetchSeries(String genreId) async {
    const apiKey = '9f826ae924a66091d91917977bece3a0';
    final url =
        'https://api.themoviedb.org/3/discover/tv?api_key=$apiKey&with_genres=$genreId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body)['results'];
      } else {
        throw Exception('Failed to load series (${response.statusCode})');
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 5));
      return fetchSeries(genreId);
    }
  }

  Future<List<dynamic>> fetchGenres() async {
    const apiKey = '9f826ae924a66091d91917977bece3a0';
    const url =
        'https://api.themoviedb.org/3/genre/tv/list?api_key=$apiKey&language=en-US';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> genres = json.decode(response.body)['genres'];
        final List<String> desiredGenres = [
          'Animation',
          'Comedy',
          'Crime',
          'Drama',
          'Family',
          'Kids',
          'Mystery',
          'Reality',
          'Soap'
        ];
        return genres
            .where((genre) => desiredGenres.contains(genre['name']))
            .toList();
      } else {
        throw Exception('Failed to load genres (${response.statusCode})');
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 5));
      return fetchGenres();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            _buildTabs(),
            const SizedBox(height: 10),
            Expanded(
              child: IndexedStack(
                index: _selectedTabIndex,
                children: [
                  _buildBooksTab(),
                  _buildSeriesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTabButton(0, 'Books', Icons.book),
        _buildTabButton(1, 'Series', Icons.playlist_play),
        _buildDropdown(),
        // const SizedBox(width: 1)
      ],
    );
  }

  Widget _buildTabButton(int index, String title, IconData icon) {
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(_selectedTabIndex == index
            ? const Color(0xFFE0F7FA)
            : Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: _selectedTabIndex == index
                ? const Color(0xFF0B2B3D)
                : Colors.black,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              color: _selectedTabIndex == index
                  ? const Color(0xFF0B2B3D)
                  : Colors.black,
              fontSize: 18,
              decoration: _selectedTabIndex == index
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksTab() {
    return FutureBuilder<List<dynamic>>(
      future: fetchBooks(_selectedCategory),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final books = snapshot.data;
          return ListView.builder(
            itemCount: books!.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return _buildBookCard(book);
            },
          );
        }
      },
    );
  }

  Widget _buildSeriesTab() {
    return FutureBuilder<List<dynamic>>(
      future: fetchSeries(_selectedCategoryS),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final series = snapshot.data;
          return ListView.builder(
            itemCount: series!.length,
            itemBuilder: (context, index) {
              final seriesItem = series[index];
              return _buildSeriesCard(seriesItem);
            },
          );
        }
      },
    );
  }

  Widget _buildBookCard(dynamic book) {
    final List<dynamic> authors = book['volumeInfo']['authors'] ?? [];
    final String authorNames =
        authors.isNotEmpty ? authors.join(', ') : 'Unknown Author';

    final double rating =
        (book['volumeInfo']['averageRating'] ?? 3.5).toDouble();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          final image = book['volumeInfo']['imageLinks']['thumbnail'];
          final title = book['volumeInfo']['title'];
          final description = book['volumeInfo']['description'] ?? '';
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BookDetailsView(
              title: title,
              image: image,
              author: authorNames,
              description: description,
              rating: rating,
            ),
          ));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                book['volumeInfo']['imageLinks']['thumbnail'],
                width: 120,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book['volumeInfo']['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'By $authorNames',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      (book['volumeInfo']['description'] ?? '')
                          .split('\n')
                          .take(2)
                          .join('\n'),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // TODO: Add book to list
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeriesCard(dynamic seriesItem) {
    final String overview = seriesItem['overview'] ?? '';
    final List<dynamic> genresInt = seriesItem['genre_ids'];
    final String language = seriesItem['original_language'];
    final String aired = seriesItem['first_air_date'];

    final List<String> words = overview.split(' ');
    final String shortOverview =
        words.length > 40 ? '${words.sublist(0, 40).join(' ')}...' : overview;
    double rating = ((seriesItem['vote_average'] ?? 7) / 2).toDouble();
    rating = double.parse(rating.toStringAsFixed(1));

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          final title = seriesItem['name'];
          final image =
              "https://image.tmdb.org/t/p/w200${seriesItem['poster_path']}";
          final description = shortOverview;
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SeriesDetailsView(
              title: title,
              image: image,
              description: description,
              rating: rating,
              genres: genresInt,
              language: language,
              airedOn: aired,
            ),
          ));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://image.tmdb.org/t/p/w200${seriesItem['poster_path']}",
                width: 120,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      seriesItem['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      shortOverview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text(
                          rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // TODO: Add series to list
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return FutureBuilder<List<dynamic>>(
      future: fetchGenres(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading genres: ${snapshot.error}'));
        } else {
          final genres = snapshot.data;
          return _buildDropdownMenu(genres!);
        }
      },
    );
  }

  Widget _buildDropdownMenu(List<dynamic> genres) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.grey[100],
        // menuMaxHeight: 500,
        // itemHeight: 2,
        borderRadius: BorderRadius.circular(15.0),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        iconSize: 30,
        elevation: 16,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        underline: const SizedBox(),
        value: _selectedTabIndex == 0 ? _selectedCategory : _selectedCategoryS,
        onChanged: (String? newValue) {
          setState(() {
            if (_selectedTabIndex == 0) {
              _selectedCategory = newValue!;
            } else {
              _selectedCategoryS = newValue!;
            }
          });
        },
        items: _selectedTabIndex == 0
            ? <String>['Fiction', 'Fantasy', 'Horror', 'Romance', 'Scifi']
                .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value.toLowerCase(),
                  child: Text(
                    value[0].toUpperCase() + value.substring(1),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList()
            : genres.map<DropdownMenuItem<String>>((dynamic item) {
                return DropdownMenuItem<String>(
                  value: item['id'].toString(),
                  child: Text(
                    item['name'],
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
      ),
    );
  }
}
