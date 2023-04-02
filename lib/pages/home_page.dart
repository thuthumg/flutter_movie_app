import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
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
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  // MovieModel mMovieModel = MovieModelImpl();

 /* List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];*/
  //
  // List<MovieVO>? mNowPlayingMovies;
  // List<MovieVO>? mPopularMovies;
  // List<MovieVO>? mTopRatedMovies;
  // List<MovieVO>? mMoviesByGenre;
  // List<GenreVO>? mGenres;
  // List<ActorVO>? mActors;
  //
  // @override
  // void initState() {
  //   /// Now Playing movies from Network
  //   // mMovieModel.getNowPlayingMovies().then((movieList) {
  //   //   setState(() {
  //   //     nowPlayingMovies = movieList;
  //   //   });
  //   // }).catchError((error) {
  //   //   debugPrint(error.toString());
  //   // });
  //
  //   /// Now Playing movies from Database
  //   mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
  //     setState(() {
  //       mNowPlayingMovies = movieList;
  //     });
  //   }).onError((error) {
  //     debugPrint(error.toString());
  //   });
  //
  //   /// Popular Movies from Network
  //   // mMovieModel.getPopularMovies().then((movieList) {
  //   //   setState(() {
  //   //     popularMovies = movieList;
  //   //   });
  //   // }).catchError((error) {
  //   //   debugPrint(error.toString());
  //   // });
  //
  //   /// Popular Movies from Database
  //   mMovieModel.getPopularMoviesFromDatabase().listen((movieList) {
  //     setState(() {
  //       mPopularMovies = movieList;
  //     });
  //   }).onError((error) {
  //     debugPrint(error.toString());
  //   });
  //
  //   /// Top Rated Movies(showcases) from NetWork
  //   // mMovieModel.getTopRatedMovies().then((movieList) {
  //   //   setState(() {
  //   //     topRatedMovies = movieList;
  //   //   });
  //   // }).catchError((error) {
  //   //   debugPrint(error.toString());
  //   // });
  //
  //   /// Top Rated Movies(Showcases) from Database
  //   mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
  //     setState(() {
  //       mTopRatedMovies = movieList;
  //     });
  //   }).onError((error) {
  //     debugPrint(error.toString());
  //   });
  //
  //   ///Genres from network
  //   mMovieModel.getGenres().then((genres) {
  //     setState(() {
  //       this.mGenres = genres;
  //     });
  //     _getMoviesByGenre(genres?.first.id ?? 0);
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //   });
  //
  //   ///Genres from database
  //   mMovieModel.getGenresFromDatabase().then((genres) {
  //     setState(() {
  //       this.mGenres = genres;
  //     });
  //     _getMoviesByGenre(genres?.first.id ?? 0);
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //   });
  //
  //   ///Actors from network
  //   mMovieModel.getActors(1).then((actors) {
  //     setState(() {
  //       this.mActors = actors;
  //     });
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //   });
  //
  //   ///Actors from database
  //   mMovieModel.getAllActorsFromDatabase().then((actors) {
  //     setState(() {
  //       this.mActors = actors;
  //     });
  //   }).catchError((error) {
  //     debugPrint(error.toString());
  //   });
  //
  //   super.initState();
  // }

  // void _getMoviesByGenre(int genreId) {
  //   mMovieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
  //     setState(() {
  //       //debugPrint("------------movies by genre api call----------------${moviesByGenre?.length} + ${genres?.first.id}");
  //       this.mMoviesByGenre = moviesByGenre;
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
              ScopedModelDescendant<MovieModelImpl>(

                builder: (BuildContext context, Widget? child, MovieModelImpl model){
                  return BannerSectionView(
                    movieList: model.mPopularMovies?.take(5).toList(),
                  );
                },

              ),
              const SizedBox(height: MARGIN_LARGE),
              ScopedModelDescendant(
                builder: (BuildContext context, Widget? child, MovieModelImpl model) {
                  return BestPopularMoviesAndSerialsSectionView(
                      onTapMovie: (movieId) => _navigateToMovieDetailsScreen(context,movieId,model),
                      mNowPlayingMovieList: model.mNowPlayingMovies);
                },

              ),
              const SizedBox(height: MARGIN_LARGE),
              CheckMovieShowTimeSectionView(),
              const SizedBox(height: MARGIN_LARGE),

              ScopedModelDescendant(
                builder: (BuildContext context, Widget? child, MovieModelImpl model) {
                  return GenreSectionView(
                    onTapMovie: (movieId) => _navigateToMovieDetailsScreen(context,movieId,model),
                    genreList: model.mGenres,
                    moviesByGenre: model.mMoviesByGenre,
                    onChooseGenre: (genreId){
                      if(genreId != null){
                        model.getMoviesByGenre(genreId);
                      }
                    },
                  );
                },

              ),

              const SizedBox(height: MARGIN_LARGE),
              ScopedModelDescendant(
                builder: (BuildContext context, Widget? child, MovieModelImpl model) {
                  return ShowCasesSectionView(topRatedMovies: model.mTopRatedMovies);
                },
              ),

              const SizedBox(height: MARGIN_LARGE),
              ScopedModelDescendant(
                builder: (BuildContext context, Widget? child, MovieModelImpl model) {

                  return ActorsAndCreatorsSectionView(
                    BEST_ACTORS_TITLE,
                    BEST_ACTORS_SEE_MORE,
                    actorsList: model.mActors,
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

  void _navigateToMovieDetailsScreen(BuildContext context,int? movieId,MovieModelImpl model) {


    if(movieId != null)
    {
      model.getMovieDetails(movieId);
      model.getMovieDetailsFromDatabase(movieId);
      model.getCreditsByMovie(movieId);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsPage(),
        ),
      );
    }
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO>? genreList;
  final List<MovieVO>? moviesByGenre;
  final Function(int?) onTapMovie;
  final Function(int?) onChooseGenre;

  GenreSectionView(
      {required this.onTapMovie,
      required this.genreList,
      required this.moviesByGenre,
      required this.onChooseGenre});

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
                  onChooseGenre(genreList?[index].id);
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
