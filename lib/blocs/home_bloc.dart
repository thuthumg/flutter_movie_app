import 'dart:async';

import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class HomeBloc{

  ///Reactive Streams
   late StreamController<List<MovieVO>> mNowPlayingStreamController;
   late StreamController<List<MovieVO>> mPopularMoviesListStreamController;
   late StreamController<List<GenreVO>> mGenreListStreamController;
   late StreamController<List<ActorVO>> mActorsStreamController;
   late StreamController<List<MovieVO>> mShowCaseMovieListStreamController;
   late StreamController<List<MovieVO>> mMoviesByGenreListStreamController;

  ///close stream controller
  void dispose(){
    mNowPlayingStreamController.close();
    mPopularMoviesListStreamController.close();
    mGenreListStreamController.close();
    mActorsStreamController.close();
    mShowCaseMovieListStreamController.close();
    mMoviesByGenreListStreamController.close();
  }


}