import 'package:flutter/material.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/viewitems/actor_view.dart';
import 'package:movie_app/widgets/title_text_with_see_more_widget_view.dart';

class ActorsAndCreatorsSectionView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;

  final List<ActorVO>? actorsList;

  ActorsAndCreatorsSectionView(
    this.titleText,
    this.seeMoreText, {
    this.seeMoreButtonVisibility = true,
    required this.actorsList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: EdgeInsets.only(top: MARGIN_XLARGE, bottom: MARGIN_XLARGE),
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
              children: actorsList?.map((actor)=> ActorView(
                actorVO: actor,
              ),).toList() ?? [],
            ),
          )
        ],
      ),
    );
  }
}
