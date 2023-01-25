import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';

class BannerView extends StatelessWidget {
  const BannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Positioned.fill(
          child: BannerImageView(),
        ),
        Positioned.fill(
          child: GradientView(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: BannerTitleView(),
        ),
        Align(
          alignment: Alignment.center,
          child: PlayButtonView(),
        )
      ],
    );
  }
}

class PlayButtonView extends StatelessWidget {
  const PlayButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.play_circle_fill_rounded,
      size: BANNER_PLAY_BUTTON_SIZE,
      color: PLAY_BUTTON_COLOR,
    );
  }
}

class GradientView extends StatelessWidget {
  const GradientView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            PRIMARY_COLOR
          ]
        )
      ),
    );
  }
}

class BannerTitleView extends StatelessWidget {
  const BannerTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "The Wolverine 2013.",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_1X,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Official Review.",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_1X,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {
  const BannerImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://www.pixelstalk.net/wp-content/uploads/images6/Wolverine-Wallpaper-Desktop.jpg",
      fit: BoxFit.cover,
    );
  }
}
