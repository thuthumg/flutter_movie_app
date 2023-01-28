import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';

class ActorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(right: MARGIN_MEDIUM),
        width: MOVIE_LIST_ITEM_WIDTH,
        child: Stack(
          children: [
            const Positioned.fill(
              child: ActorImageView(),
            ),
            const Padding(
              padding: EdgeInsets.all(MARGIN_MEDIUM),
              child: Align(
                alignment: Alignment.topRight,
                child: FavouriteButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ActorNameAndLikeView(),
            )
          ],
        ),
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  const ActorImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://cdn1-production-images-kly.akamaized.net/4UKeLIvdFlL6tDI0I01sWbD9LuU=/1200x900/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/1712534/original/092141800_1505624991-Song_Seung_Hun.jpg",
      fit: BoxFit.cover,
    );
  }
}

class FavouriteButtonView extends StatelessWidget {
  const FavouriteButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite_border,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
        vertical: MARGIN_MEDIUM_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Song Seung-heon",
            style: TextStyle(
                fontSize: TEXT_REGULAR,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: const [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MARGIN_CARD_MEDIUM,
              ),
              SizedBox(width: MARGIN_MEDIUM),
              Text(
                "YOU LIKE 13 MOVIES",
                style: TextStyle(
                  color: HOME_SCREEN_LIST_TITLE_COLOR,
                  fontSize: TEXT_SMALL,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
