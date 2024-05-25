import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';

class BookDetailsView extends StatefulWidget {
  final String title;
  final String author;
  final String description;
  final String image;
  final double rating;

  const BookDetailsView({
    super.key,
    required this.title,
    required this.author,
    required this.description,
    required this.image,
    required this.rating,
    // required publisher,
  });

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: internalAppBar(context, widget.title),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // const SizedBox(
              //   height: 20,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: ,
                children: [
                  Image.network(
                    widget.image,
                    width: 150,
                    // height: 180,
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
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
