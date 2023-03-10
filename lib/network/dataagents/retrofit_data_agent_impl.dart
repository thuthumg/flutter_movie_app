import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';

import 'package:movie_app/network/the_movie_api.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  late TheMovieApi mApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    final interceptor = LogInterceptor(
      requestHeader: false, // don't log request headers
      requestBody: true, // don't log request body
      responseHeader: false, // don't log response headers
      responseBody: true, // log response body only
      logPrint: (message) => debugPrint(message.toString()), // use debugPrint for logging
    );
    dio.interceptors.add(interceptor);

    mApi = TheMovieApi(dio);
  }

  // RetrofitDataAgentImpl(){
  //   final dio = Dio();
  //   mApi = TheMovieApi(dio);
  // }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    // mApi
    //     .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
    //     .then((response) {
    //   // debugPrint("Now Playing Movie  =  ${value.toString()}")
    //
    //   response.results.forEach((movie) => debugPrint(movie.toString()));
    // }).catchError((error) {
    //   debugPrint("Error =  ${error.toString()}");
    // });


    //P11 Model Component lecture video
   return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getPopularMovies(int page) {

    return mApi
        .getPopularMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies(int page) {

    return mApi
        .getTopRatedMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<GenreVO>?> getGenres() {

    return mApi
        .getGenres(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {

    return mApi
        .getMoviesByGenre(genreId.toString(),API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {

    return mApi
        .getActors(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return mApi
        .getCreditsByMovie(movieId.toString(),API_KEY)
    .asStream()
    .map((getCreditsByMovieResponse){
      return [getCreditsByMovieResponse.cast,getCreditsByMovieResponse.crew];
    }).first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
   return mApi
       .getMovieDetails(movieId.toString(),API_KEY);
  }
}
