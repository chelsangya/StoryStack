import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';

class SeriesDetailsView extends StatefulWidget {
  final String title;
  final String description;
  final String image;

  final String language;
  final List<dynamic> genres;

  final String airedOn;
  final double rating;

  const SeriesDetailsView({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.rating,
    required this.genres,
    required this.language,
    required this.airedOn,
  });

  @override
  State<SeriesDetailsView> createState() => _SeriesDetailsViewState();
}

class _SeriesDetailsViewState extends State<SeriesDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: internalAppBar(context, widget.title),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        '${widget.rating} rated by readers.',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                      Text(
                        'Language: ${widget.language}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Genres: ${widget.genres}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                // textAlign: TextAlign.justify,
                widget.description,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ));
  }
}
