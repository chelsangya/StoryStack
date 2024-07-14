import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:story_stack/core/common/appbar/appbar.dart';
import 'package:story_stack/view/book_details_view.dart';
import 'package:story_stack/view/series_details_view.dart';

class UpcomingView extends ConsumerStatefulWidget {
  const UpcomingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpcomingViewState();
}

class _UpcomingViewState extends ConsumerState<UpcomingView> {
  int _selectedTabIndex = 0;

  Future<List<dynamic>> fetchUpcoming() async {
    const url = 'http://localhost:5500/api/upcoming/all';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('upcoming data: $data');
      return data['upcoming'];
    } else {
      throw Exception('Failed to load upcoming data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
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
      future: fetchUpcoming(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final upcomingData = snapshot.data;
          final books =
              upcomingData!.where((item) => item['book'] != null).toList();
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index]['book'];
              return _buildBookCard(book);
            },
          );
        }
      },
    );
  }

  Widget _buildSeriesTab() {
    return FutureBuilder<List<dynamic>>(
      future: fetchUpcoming(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final upcomingData = snapshot.data;
          final series =
              upcomingData!.where((item) => item['series'] != null).toList();
          return ListView.builder(
            itemCount: series.length,
            itemBuilder: (context, index) {
              final seriesItem = series[index]['series'];
              return _buildSeriesCard(seriesItem);
            },
          );
        }
      },
    );
  }

  Widget _buildBookCard(dynamic book) {
    final String id = book['_id'] ?? '';
    final String author = book['author'] ?? 'Unknown Author';
    final String title = book['name'] ?? 'Untitled';
    final String image =
        book['bookImageUrl'] ?? 'https://via.placeholder.com/150';
    final String description = book['description'] ?? '';
    final double rating = book['rating']?.toDouble() ?? 0.0;
    final String genre = book['genre'] ?? 'Unknown Genre';
    final String language = book['language'] ?? 'Unknown Language';
    final totalChapter = book['totalChapter'] ?? 0;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BookDetailsView(
              id: id,
              title: title,
              image: image,
              author: author,
              description: description,
              rating: rating,
              genre: genre,
              language: language,
              totalChapter: totalChapter,
            ),
          ));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image,
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
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'By $author',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
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
    final String id = seriesItem['_id'] ?? '';
    final String title = seriesItem['name'] ?? 'Untitled';
    final String image =
        seriesItem['seriesImageUrl'] ?? 'https://via.placeholder.com/150';
    final String description = seriesItem['description'] ?? '';
    final double rating = seriesItem['rating']?.toDouble() ?? 0.0;
    final DateTime createdAt = DateTime.parse(seriesItem['createdAt']);
    final String formattedDate = DateFormat('yyyy-MMM-dd').format(createdAt);
    final int season = seriesItem['season'] ?? '';
    final int episode = seriesItem['episode'] ?? '';

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SeriesDetailsView(
              id: id,
              title: title,
              image: image,
              description: description,
              rating: rating,
              genres: seriesItem['genres']?.cast<int>() ?? [],
              language: seriesItem['language'] ?? '',
              airedOn: formattedDate,
              season: season,
              episode: episode,
              casts: (seriesItem['casts'] as List<dynamic>?)
                  ?.map((cast) => cast as Map<String, dynamic>)
                  .toList(),
            ),
          ));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image,
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
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(Icons.timelapse, color: Colors.amber),
                        const SizedBox(width: 5),
                        Text(
                          formattedDate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
