import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/play_button_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {

  final MovieVO? movie;


  ShowCaseView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: 300,
      child: Stack(
        children: [
          Positioned.fill(
            child:  CachedNetworkImage(
      fit: BoxFit.cover,
        imageUrl:   "$IMAGE_BASE_URL${movie?.posterPath}",
        placeholder: (context, url) => Center(
          child: SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),


            //
            // Image.network(
            //   "$IMAGE_BASE_URL${movie?.posterPath}",
            //   fit: BoxFit.cover,
            // ),
          ),
          Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie?.title ?? "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: TEXT_REGULAR_3X,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: MARGIN_MEDIUM,),
                  TitleText("15 DECEMBER 2016")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
