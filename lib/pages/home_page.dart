import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/blocs/home_bloc.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
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

  ///3
  ///Bloc
  HomeBloc _bloc = HomeBloc();
  @override
  void initState() {
      super.initState();
  }

  // void _getMoviesByGenre(int genreId) {
  //   mMovieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
  //     setState(() {
  //       //debugPrint("------------movies by genre api call----------------${moviesByGenre?.length} + ${genres?.first.id}");
  //       this.moviesByGenre = moviesByGenre;
  //     });
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //   });
  // }

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
              StreamBuilder(
                stream: _bloc.mPopularMoviesListStreamController.stream,
                builder: (BuildContext context, AsyncSnapshot<List<MovieVO>> snapshot) {
                  return BannerSectionView(
                    movieList: snapshot.data?.take(5).toList(),
                  );
                },

              ),
              const SizedBox(height: MARGIN_LARGE),
              StreamBuilder(
                stream: _bloc.mNowPlayingStreamController.stream,
                builder: (BuildContext context, AsyncSnapshot<List<MovieVO>> snapshot) {
                  return BestPopularMoviesAndSerialsSectionView(
                      onTapMovie: (movieId) => _navigateToMovieDetailsScreen(context,movieId),
                      mNowPlayingMovieList: snapshot.data);
                },

              ),
              const SizedBox(height: MARGIN_LARGE),
              CheckMovieShowTimeSectionView(),
              const SizedBox(height: MARGIN_LARGE),
              StreamBuilder(
                stream: _bloc.mGenreListStreamController.stream,
                builder: (BuildContext context, AsyncSnapshot<List<GenreVO>> genreSnapShot) {
                  return StreamBuilder(
                    stream: _bloc.mMoviesByGenreListStreamController.stream,
                    builder: (BuildContext context, AsyncSnapshot<List<MovieVO>> moviesByGenreSnapShot) {
                      return GenreSectionView(
                        onTapMovie: (movieId) => _navigateToMovieDetailsScreen(context,movieId),
                        genreList: genreSnapShot.data,
                        moviesByGenre: moviesByGenreSnapShot.data,
                        onTapGenre: (genreId){
                          if(genreId != null){
                            _bloc.getMoviesByGenreAndRefresh(genreId);
                          }
                        }
                       ,
                      );
                    },

                  );
                },
              ),
              const SizedBox(height: MARGIN_LARGE),
              StreamBuilder(
                  stream: _bloc.mShowCaseMovieListStreamController.stream,
                  builder: (BuildContext context, AsyncSnapshot<List<MovieVO>> snapshot) {
                    return ShowCasesSectionView(topRatedMovies: snapshot.data);
                  },
              ),
              const SizedBox(height: MARGIN_LARGE),
              StreamBuilder(
                stream: _bloc.mActorsStreamController.stream,
                builder: (BuildContext context, AsyncSnapshot<List<ActorVO>> snapshot) {
                  return ActorsAndCreatorsSectionView(
                    BEST_ACTORS_TITLE,
                    BEST_ACTORS_SEE_MORE,
                    actorsList: snapshot.data,
                  );
                },

              ),
              // const SizedBox(height: MARGIN_LARGE),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context,int? movieId) {

    if(movieId != null)
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(
              movieId: movieId,
            ),
          ),
        );
      }

    // return Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MovieDetailsPage(),
    //   ),
    // );
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO>? genreList;
  final List<MovieVO>? moviesByGenre;
  final Function(int?) onTapMovie;
  final Function(int?) onTapGenre;

  GenreSectionView(
      {required this.onTapMovie,
      required this.genreList,
      required this.moviesByGenre,
      required this.onTapGenre
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: DefaultTabController(
            length: genreList?.length ?? 0,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                      ?.map(
                        (genre) => Tab(
                          child: Text(genre.name ?? ""),
                        ),
                      )
                      .toList() ??
                  [],
              onTap: (index){
                  onTapGenre(genreList?[index].id);
              },
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding:
              const EdgeInsets.only(top: MARGIN_MEDIUM_2, bottom: MARGIN_LARGE),
          child: HorizontalMovieListView(
            onTapMovie: (movieId) => this.onTapMovie(movieId),
            movieList: moviesByGenre,
          ),
        ),
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
  final List<MovieVO>? topRatedMovies;

  ShowCasesSectionView({required this.topRatedMovies});

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
              children: topRatedMovies
                      ?.map(
                        (topRatedMovie) => ShowCaseView(
                          movie: topRatedMovie,
                        ),
                      )
                      .toList() ??
                  []),
        )
      ],
    );
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? mNowPlayingMovieList;

  BestPopularMoviesAndSerialsSectionView(
      {required this.onTapMovie, required this.mNowPlayingMovieList});

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
          onTapMovie: (movieId) {
            this.onTapMovie(movieId);
          },
          movieList: mNowPlayingMovieList,
        )
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;

  HorizontalMovieListView({required this.onTapMovie, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              itemCount: movieList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: ()=> onTapMovie(movieList?[index].id),
                  child: MovieView(
                    //  onTapMovie: () => this.onTapMovie(movieList?[index].id),
                      mMovie: movieList?[index]),
                );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  final List<MovieVO>? movieList;

  BannerSectionView({required this.movieList});

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
          height: MediaQuery.of(context).size.height / 4,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: widget.movieList
                    ?.map(
                      (movie) => BannerView(
                        movie: movie,
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: widget.movieList?.length == 0 ? 1 : widget.movieList?.length?? 1,
          position: _position,
          decorator: const DotsDecorator(
              color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
              activeColor: PLAY_BUTTON_COLOR),
        ),
      ],
    );
  }
}
