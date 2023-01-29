import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/rating_view.dart';

class MovieView extends StatelessWidget {
  final Function onTapMovie;

  MovieView(this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              onTapMovie();
            },
            child: Image.network(
              "https://www.pixelstalk.net/wp-content/uploads/images6/Wolverine-Wallpaper-Desktop.jpg",
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          const Text(
            "West World",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: [
              const Text(
                "8.9",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: MARGIN_MEDIUM,
              ),
              RatingView()
            ],
          )
        ],
      ),
    );
  }
}
