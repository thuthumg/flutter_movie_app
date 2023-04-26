import 'package:flutter/foundation.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier{

  ///1
  ///State Variables
  List<MovieVO>? mNowPlayingMoviesList;
  List<MovieVO>? mPopularMoviesList;
  List<MovieVO>? mTopRatedMoviesList;
  List<MovieVO>? mMoviesByGenreList;
  List<GenreVO>? mGenres;
  List<ActorVO>? mActors;

  ///Page
  int pageForNowPlayingMovies = 1;

///2
  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc(){

    /// Now Playing movies from Database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
     mNowPlayingMoviesList = movieList;
     mNowPlayingMoviesList?.sort((a,b) => (a.id??0) - (b.id??0));
     notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Popular Movies from Database
    mMovieModel.getPopularMoviesFromDatabase().listen((movieList) {
     mPopularMoviesList = movieList;
     notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });


    ///Genres from network
    mMovieModel.getGenres().then((genres) {
      mGenres = genres;
      _getMoviesByGenreAndRefresh(mGenres?.first.id ?? 0);
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Genres from database
    mMovieModel.getGenresFromDatabase().then((genres) {
      mGenres = genres;
      _getMoviesByGenreAndRefresh(genres?.first.id ?? 0);
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });


    /// Top Rated Movies(Showcases) from Database
    mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
     mTopRatedMoviesList = movieList;
     notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    ///Actors from network
    mMovieModel.getActors(1).then((actors) {
      mActors = actors;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Actors from database
    mMovieModel.getAllActorsFromDatabase().then((actors) {
     mActors = actors;
     notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onTapGenre(int genreId){
    _getMoviesByGenreAndRefresh(genreId);
  }

  void _getMoviesByGenreAndRefresh(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
      mMoviesByGenreList = moviesByGenre;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }


  void onNowPlayingMovieListEndReached(){
    this.pageForNowPlayingMovies += 1;
    mMovieModel.getNowPlayingMovies(pageForNowPlayingMovies);
  }

}