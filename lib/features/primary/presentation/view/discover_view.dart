import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story_stack/core/common/appbar/appbar.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({super.key});

  @override
  _DiscoverViewState createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  // late String _selectedCategory = 'Fiction';
  late String _selectedCategory = 'fiction';
  late String _selectedCategoryS = '16'; // Default category

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context, 'Discover Content'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            _buildTabs(),
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

  int _selectedTabIndex = 1;

  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildTabButton(0, 'Books', Icons.book),
        _buildTabButton(1, 'Series', Icons.playlist_play),
        _selectedTabIndex == 0
            ? DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: <String>[
                  'Fiction',
                  'Fantasy',
                  'Horror',
                  'Romance',
                  'Scifi'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value.toLowerCase(),
                    child: Text(value[0].toUpperCase() + value.substring(1)),
                  );
                }).toList(),
              )
            : FutureBuilder<List<dynamic>>(
                future: fetchGenres(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Error loading genres: ${snapshot.error}'));
                  } else {
                    final genres = snapshot.data;
                    return DropdownButton<String>(
                      value: _selectedCategoryS,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategoryS = newValue!;
                        });
                      },
                      items: genres!.map<DropdownMenuItem<String>>((genre) {
                        return DropdownMenuItem<String>(
                          value: genre['id'].toString(),
                          child: Text(genre['name']),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
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
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(icon,
              color: _selectedTabIndex == index
                  ? const Color(0xFF0B2B3D)
                  : Colors.black),
          const SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              color: _selectedTabIndex == index
                  ? const Color(0xFF0B2B3D)
                  : Colors.black,
              fontSize: 16,
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
              print('response book: ${books[index]}');
              final book = books[index];
              final List<dynamic> authors = book['volumeInfo']['authors'] ?? [];
              final String authorNames =
                  authors.isNotEmpty ? authors.join(', ') : 'Unknown Author';

              return Card(
                child: Row(
                  children: [
                    Image.network(
                      book['volumeInfo']['imageLinks']['thumbnail'],
                      width: 80,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book['volumeInfo']['title'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            authorNames,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            (book['volumeInfo']['description'] ?? '')
                                .split('\n')
                                .take(2)
                                .join('\n'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
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
              print('response series: ${series[index]}');
              final seriesItem = series[index];
              final String overview = seriesItem['overview'] ?? '';
              final List<String> words = overview.split(' ');
              final String shortOverview = words.length > 6
                  ? '${words.sublist(0, 6).join(' ')}...'
                  : overview;
              return Card(
                child: Row(
                  children: [
                    Image.network(
                      "https://image.tmdb.org/t/p/w200${seriesItem['poster_path']}",
                      width: 80,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            seriesItem['name'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            shortOverview,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  // buildsearch smaller height
  Widget _buildSearch() {
    return SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> fetchGenres() async {
    const apiKey = '9f826ae924a66091d91917977bece3a0';
    const url =
        'https://api.themoviedb.org/3/genre/tv/list?api_key=$apiKey&language=en-US';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> genres = json.decode(response.body)['genres'];
        // Filter out the desired genres
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
      print('Error fetching genres: $e');
      // Retry after a short delay
      await Future.delayed(const Duration(seconds: 5));
      return fetchGenres(); // Retry the request
    }
  }
}
