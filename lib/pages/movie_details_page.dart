import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class MovieDetailsPage extends StatelessWidget {
  final List<String> genreList = ["Family", "Fantasy", "Adventure"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetailsSliverAppBarView(
                ()=> Navigator.pop(context),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: TrailerSection(genreList),
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              ActorsAndCreatorsSectionView(
                MOVIE_DETAILS_SCREEN_ACTORS_TITLE,
                "",
                seeMoreButtonVisibility: false,
                actorsList: [],
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: AboutFilmSectionView(),
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              ActorsAndCreatorsSectionView(MOVIE_DETAILS_SCREEN_CREATORS_TITLE,
                  MOVIE_DETAILS_SCREEN_CREATORS_SEE_MORE,actorsList: [],)
            ]))
          ],
        ),
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  const AboutFilmSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView("Original Title", "Fantastic Beasts and Where to Find Them"),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView("Type:", "Family, Fantasy, Adventure"),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView("Production:", "United Kingdom, USA"),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView("Premiere:", "8 November 2016(World)"),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        AboutFilmInfoView("Description:",
            "The Film begins in 1926. Newt Scamander back from a great trip, the purpose of which was to find and describe a range of fantastic animals.His brief stay in New York..MORE"),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String label;
  final String description;

  AboutFilmInfoView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: const TextStyle(
              color: MOVIE_DETAIL_INFO_TEXT_COLOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          width: MARGIN_CARD_MEDIUM_2,
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final List<String> genreList;

  TrailerSection(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        const SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        const StoryLineView(),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Row(
          children: [
            MovieDetailsScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              const Icon(
                Icons.play_circle_fill,
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              width: MARGIN_CARD_MEDIUM_2,
            ),
            MovieDetailsScreenButtonView(
                "RATE MOVIE",
                HOME_SCREEN_BACKGROUND_COLOR,
                const Icon(
                  Icons.star,
                  color: PLAY_BUTTON_COLOR,
                ),
                isGhostButton: true),
          ],
        )
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailsScreenButtonView(
      this.title, this.backgroundColor, this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        border:
            (isGhostButton) ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            const SizedBox(
              width: MARGIN_MEDIUM,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_REGULAR_2X),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  const StoryLineView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        const Text(
          "Seventy years before Harry Potter reading a book by Newt Scamander, author experiencing extraordinary adventures in the mysterious, the New York Association of witches.",
          style: TextStyle(color: Colors.white, fontSize: TEXT_REGULAR_2X),
        ),
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        const Text(
          "2h 30min",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Row(
          children: genreList
              .map(
                (genre) => GenreChipView(genre),
              )
              .toList(),
        ),
        const Spacer(),
        const Icon(
          Icons.favorite_border,
          color: Colors.white,
        )
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Chip(
            backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
            label: Text(
              genreText,
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          width: MARGIN_SMALL,
        )
      ],
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {

  final Function onTapBack;

  MovieDetailsSliverAppBarView(this.onTapBack);


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: PRIMARY_COLOR,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
     // floating: true,
      pinned: true,
    //  snap: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            const Positioned.fill(
              child: MovieDetailsAppBarImageView(),
            ),
            const Positioned.fill(
              child: GradientView(),
            ),
             Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: MARGIN_XXLARGE, left: MARGIN_MEDIUM_2),
                child: BackButtonView(()=> onTapBack()),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MARGIN_XXLARGE + MARGIN_MEDIUM,
                    right: MARGIN_MEDIUM_2),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: MARGIN_MEDIUM_2,
                    right: MARGIN_MEDIUM_2,
                    bottom: MARGIN_LARGE),
                child: MovieDetailsAppBarInfoView(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MovieDetailsYearView(),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    const SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    TitleText("38876 VOTES"),
                    const SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    )
                  ],
                ),
                const SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                const Text(
                  "9.96",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        const Text(
          "Fantastic Beasts and Where to Find Them",
          style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_2X,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  const MovieDetailsYearView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
      ),
      child: const Center(
        child: Text(
          "2016",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;

  const BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTapBack();
      },
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  const MovieDetailsAppBarImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://media.wired.com/photos/59269d967034dc5f91bec129/master/pass/FantasticBeasts_HP.jpg",
      fit: BoxFit.cover,
    );
  }
}
