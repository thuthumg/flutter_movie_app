import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
class MovieView extends StatelessWidget {
 // final Function onTapMovie;
  final MovieVO? mMovie;

  MovieView({
   // required this.onTapMovie,
    required this.mMovie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            height: 200,
            child: Center(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: '$IMAGE_BASE_URL${mMovie?.posterPath ?? ""}',
                placeholder: (context, url) => const SizedBox(
                    width: 35,
                    height: 35,
                    child: CircularProgressIndicator(),),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),

          // Image.network(
          //   "$IMAGE_BASE_URL${mMovie?.posterPath ?? ""}",
          //   height: 200,
          //   fit: BoxFit.cover,
          // ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Text(
            mMovie?.title?? "",
            style: const TextStyle(
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
