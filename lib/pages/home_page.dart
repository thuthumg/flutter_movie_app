import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/pages/movie_details_page.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/viewitems/banner_view.dart';
import 'package:movie_app/viewitems/movie_view.dart';
import 'package:movie_app/viewitems/showcase_view.dart';
import 'package:movie_app/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_widget_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieModel mMovieModel = MovieModelImpl();

  List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];

  List<MovieVO>? mNowPlayingMovieList;

  @override
  void initState() {
    super.initState();
    mMovieModel.getNowPlayingMovies(1).then((movieList) {
      setState(() {
        mNowPlayingMovieList = movieList?? [];
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          MAIN_SCREEN_APP_BAR_TITLE,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              left: 0,
              top: 0,
              right: MARGIN_MEDIUM_2,
              bottom: 0,
            ),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerSectionView(),
              const SizedBox(height: MARGIN_LARGE),
              BestPopularMoviesAndSerialsSectionView(
                  () => _navigateToMovieDetailsScreen(context),
                  mNowPlayingMovieList),
              const SizedBox(height: MARGIN_LARGE),
              CheckMovieShowTimeSectionView(),
              const SizedBox(height: MARGIN_LARGE),
              GenreSectionView(() => _navigateToMovieDetailsScreen(context),
                  genreList: genreList),
              const SizedBox(height: MARGIN_LARGE),
              ShowCasesSectionView(),
              const SizedBox(height: MARGIN_LARGE),
              ActorsAndCreatorsSectionView(
                  BEST_ACTORS_TITLE, BEST_ACTORS_SEE_MORE),
              // const SizedBox(height: MARGIN_LARGE),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToMovieDetailsScreen(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(),
      ),
    );
  }
}

class GenreSectionView extends StatelessWidget {
  final List<String> genreList;
  final Function onTapMovie;

  GenreSectionView(
    this.onTapMovie, {
    required this.genreList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList.length,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                  .map(
                    (genre) => Tab(
                      child: Text(genre),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Container(
            color: PRIMARY_COLOR,
            padding: const EdgeInsets.only(
                top: MARGIN_MEDIUM_2, bottom: MARGIN_LARGE),
            child: HorizontalMovieListView(() {
              onTapMovie();
            })),
      ],
    );
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: const EdgeInsets.all(MARGIN_LARGE),
      height: SHOWTIME_SECTION_HEIGHT,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                MAIN_SCREEN_CHECK_MOVIE_SHOWTIMES,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
                textColor: PLAY_BUTTON_COLOR,
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          )
        ],
      ),
    );
  }
}

class ShowCasesSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: TitleTextWithSeeMoreWidgetView(
            SHOW_CASES_TITLE,
            SHOW_CASES_SEE_MORE,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            children: [
              ShowCaseView(),
              ShowCaseView(),
              ShowCaseView(),
            ],
          ),
        )
      ],
    );
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function onTapMovie;
  final List<MovieVO>? mNowPlayingMovieList;

  BestPopularMoviesAndSerialsSectionView(
      this.onTapMovie, this.mNowPlayingMovieList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(MAIN_SCREEN_BEST_POPULAR_MOVIES_AND_SERIALS),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(
          () {
            this.onTapMovie();
          },
          movieList: mNowPlayingMovieList,
        )
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function onTapMovie;
  final List<MovieVO>? movieList;

  HorizontalMovieListView(this.onTapMovie, {this.movieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)? ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          itemCount: movieList?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return MovieView(
              () {
                this.onTapMovie();
              },
              movieList![index]
            );
          }) : Center(child: CircularProgressIndicator()),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: const [
              BannerView(),
              BannerView(),
            ],
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: 2,
          position: _position,
          decorator: const DotsDecorator(
              color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
              activeColor: PLAY_BUTTON_COLOR),
        ),
      ],
    );
  }
}
