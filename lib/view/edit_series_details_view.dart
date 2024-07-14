import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';

class EditSeriesDetailsView extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String image;
  final String language;
  final List<dynamic> genres;
  final String airedOn;
  final double rating;
  final List<Map<String, dynamic>>? casts;
  final int season;
  final int episode;
  final int? fetchedseason;
  final int? fetchedepisode;

  const EditSeriesDetailsView({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.rating,
    required this.genres,
    required this.language,
    required this.airedOn,
    this.casts,
    required this.season,
    required this.episode,
    this.fetchedseason,
    this.fetchedepisode,
  });

  @override
  State<EditSeriesDetailsView> createState() => _EditSeriesDetailsViewState();
}

class _EditSeriesDetailsViewState extends State<EditSeriesDetailsView> {
  int? selectedSeason;
  int? selectedEpisode;

  Future<void> updateList() async {
    if (selectedSeason == null || selectedEpisode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both season and episode'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String? token;
    var data = await UserSharedPrefs().getUserToken();
    data.fold((l) => token = null, (r) => token = r!);

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    const String url = 'http://localhost:5500/api/list/update';
    final Map<String, dynamic> body = {
      'seriesId': widget.id,
      'season': selectedSeason,
      'episode': selectedEpisode,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Success: $responseData');
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Updated list successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('Error: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update list'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedSeason = widget.fetchedseason;
    selectedEpisode = widget.fetchedepisode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: internalAppBar(context, 'Series Details'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.image,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (v) {},
                          starCount: 5,
                          rating: widget.rating,
                          size: 25.0,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half_outlined,
                          color: Colors.yellow[900],
                          borderColor: Colors.yellow[900],
                          spacing: 0.0,
                        ),
                        Text(
                          '${widget.rating} rated by viewers.',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Aired On: ${widget.airedOn}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Cast',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (widget.casts != null && widget.casts!.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.casts!.map((cast) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              cast['castImageUrl'],
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ),
                            const SizedBox(height: 5),
                            Text(cast['name']),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              if (widget.casts == null || widget.casts!.isEmpty)
                const Text('No cast information available.'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (v) {},
                          starCount: 5,
                          rating: widget.rating,
                          size: 25.0,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half_outlined,
                          color: Colors.yellow[900],
                          borderColor: Colors.yellow[900],
                          spacing: 0.0,
                        ),
                        Text(
                          '${widget.rating} rated by viewers.',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Language: ${widget.language}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Seasons',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(widget.season, (index) {
                              bool isSelected = selectedSeason == index + 1;
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setModalState(() {
                                      selectedSeason =
                                          isSelected ? null : index + 1;
                                      selectedEpisode = null;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        isSelected ? Colors.white : null,
                                    backgroundColor:
                                        isSelected ? Colors.teal : null,
                                  ),
                                  child: Text('${index + 1}'),
                                ),
                              );
                            }),
                          ),
                        ),
                        if (selectedSeason != null) ...[
                          const SizedBox(height: 20),
                          const Text(
                            'Episodes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(widget.episode, (index) {
                                bool isSelected = selectedEpisode == index + 1;
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setModalState(() {
                                        selectedEpisode =
                                            isSelected ? null : index + 1;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor:
                                          isSelected ? Colors.white : null,
                                      backgroundColor:
                                          isSelected ? Colors.teal : null,
                                    ),
                                    child: Text('${index + 1}'),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.teal,
                              )),
                          onPressed: () async {
                            await updateList();
                            print(
                                'Selected Season: $selectedSeason, Selected Episode: $selectedEpisode');
                            Navigator.of(context).pop();
                          },
                          child: const Text('Update'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
