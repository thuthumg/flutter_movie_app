import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  const BannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         const Positioned.fill(
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
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        )
      ],
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
              colors: [Colors.transparent, HOME_SCREEN_BACKGROUND_COLOR])),
    );
  }
}

class BannerTitleView extends StatelessWidget {
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
