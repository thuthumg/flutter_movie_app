import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class MovieDetailsBloc{

  ///Stream Controllers
  StreamController<MovieVO?> movieStreamController = StreamController();
  StreamController<List<ActorVO>?> crewStreamController = StreamController();
  StreamController<List<ActorVO>?> castStreamController = StreamController();

  void disposeStreams(){
    movieStreamController.close();
    crewStreamController.close();
    castStreamController.close();
  }


  ///Models
  MovieModel movieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId){
    ///Movie Detail data
    movieModel.getMovieDetails(movieId).then((movieDetails) {
     movieStreamController.sink.add(movieDetails);
    }).catchError((error) {
      debugPrint(error.toString());
    });


    ///Movie Detail data from database
    movieModel.getMovieDetailsFromDatabase(movieId).then((movieDetails) {
      movieStreamController.sink.add(movieDetails);
    }).catchError((error) {
      debugPrint(error.toString());
    });


    ///Cast and Crew
    movieModel.getCreditsByMovie(movieId).then((castAndCrew) {

      castStreamController.sink.add(castAndCrew.first);
      crewStreamController.sink.add(castAndCrew[1]);


    }).catchError((error) {
      debugPrint(error.toString());
    });
  }
}