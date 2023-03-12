import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';

class ActorView extends StatelessWidget {

  final ActorVO? actorVO;


  ActorView({required this.actorVO});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(right: MARGIN_MEDIUM),
        width: MOVIE_LIST_ITEM_WIDTH,
        child: Stack(
          children: [
            Positioned.fill(
              child: ActorImageView(
                actorProfilePath: actorVO?.profilePath ?? "",
              ),
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
              child: ActorNameAndLikeView(
                actorName: actorVO?.name ?? "",
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {

  final String actorProfilePath;


  ActorImageView({required this.actorProfilePath});

  @override
  Widget build(BuildContext context) {
    return
      CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl:   "$IMAGE_BASE_URL$actorProfilePath",
        placeholder: (context, url) => const Center(
          child: SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(),),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    //
    //   Image.network(
    //   "$IMAGE_BASE_URL$actorProfilePath",
    //   fit: BoxFit.cover,
    // );
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

  final String actorName;


  ActorNameAndLikeView({required this.actorName});

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
          Text(
            actorName,
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
                size: MARGIN_CARD_MEDIUM_2,
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
