import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/viewitems/actor_view.dart';
import 'package:movie_app/widgets/title_text_with_see_more_widget_view.dart';

class ActorsAndCreatorsSectionView extends StatelessWidget {

 final String titleText;
 final String seeMoreText;
 final bool seeMoreButtonVisibility;

 ActorsAndCreatorsSectionView(
     this.titleText,this.seeMoreText,{this.seeMoreButtonVisibility = true}
     );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: EdgeInsets.only(
          top: MARGIN_XLARGE,
          bottom: MARGIN_XLARGE
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2,
            ),
            child: TitleTextWithSeeMoreWidgetView(
              titleText,
              seeMoreText,
              seeMoreButtonVisibility: this.seeMoreButtonVisibility,
            ),
          ),
          const SizedBox(height: MARGIN_SMALL),
          Container(
            height: BEST_ACTORS_HEIGHT,
            child: ListView(
              padding: EdgeInsets.only(left: MARGIN_MEDIUM),
              scrollDirection: Axis.horizontal,
              children: [ActorView(), ActorView(), ActorView()],
            ),
          )
        ],
      ),
    );
  }
}