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

///2
  ///Model
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc(){

    /// Now Playing movies from Database
    mMovieModel.getNowPlayingMoviesFromDatabase().then((movieList) {
     mNowPlayingMoviesList = movieList;
     notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// Popular Movies from Database
    mMovieModel.getPopularMoviesFromDatabase().then((movieList) {
     mPopularMoviesList = movieList;
    }).catchError((error) {
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
    mMovieModel.getTopRatedMoviesFromDatabase().then((movieList) {
     mTopRatedMoviesList = movieList;
     notifyListeners();
    }).catchError((error) {
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


  void _getMoviesByGenreAndRefresh(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((moviesByGenre) {
      mMoviesByGenreList = moviesByGenre;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

}