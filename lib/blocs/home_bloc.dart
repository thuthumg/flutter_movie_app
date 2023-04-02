import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class HomeBloc {
  ///1
  ///Reactive Streams
  StreamController<List<MovieVO>> mNowPlayingStreamController = StreamController();
  StreamController<List<MovieVO>> mPopularMoviesListStreamController= StreamController();
  StreamController<List<GenreVO>> mGenreListStreamController= StreamController();
  StreamController<List<ActorVO>> mActorsStreamController= StreamController();
  StreamController<List<MovieVO>> mShowCaseMovieListStreamController= StreamController();
  StreamController<List<MovieVO>> mMoviesByGenreListStreamController= StreamController();

  ///close stream controller
  void dispose() {
    mNowPlayingStreamController.close();
    mPopularMoviesListStreamController.close();
    mGenreListStreamController.close();
    mActorsStreamController.close();
    mShowCaseMovieListStreamController.close();
    mMoviesByGenreListStreamController.close();
  }

  ///2
  ///Models
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc(){

    /// Now Playing movies from Database
    mMovieModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
     mNowPlayingStreamController.sink.add(movieList);
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Popular Movies from Database
    mMovieModel.getPopularMoviesFromDatabase().listen((movieList) {
     mPopularMoviesListStreamController.sink.add(movieList);
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// Top Rated Movies(Showcases) from Database
    mMovieModel.getTopRatedMoviesFromDatabase().listen((movieList) {
     mShowCaseMovieListStreamController.sink.add(movieList);
    }).onError((error) {
      debugPrint(error.toString());
    });

    ///Genres from network
    mMovieModel.getGenres().then((genres) {
     mGenreListStreamController.sink.add(genres??[]);
     ///Movies By Genre
      _getMoviesByGenre(genres?.first.id ?? 0);

    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Genres from database
    mMovieModel.getGenresFromDatabase().then((genres) {
      mGenreListStreamController.sink.add(genres??[]);

      ///Movies By Genre
      _getMoviesByGenre(genres?.first.id ?? 0);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Actors from network
    mMovieModel.getActors(1).then((actors) {
      mActorsStreamController.sink.add(actors??[]);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Actors from database
    mMovieModel.getAllActorsFromDatabase().then((actors) {
     mActorsStreamController.sink.add(actors??[]);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }


  void _getMoviesByGenre(int genreId) {
    mMovieModel.getMoviesByGenre(genreId).then((movieByGenre){
      mMoviesByGenreListStreamController.sink.add(movieByGenre??[]);

    }).catchError((error){});
  }

}

