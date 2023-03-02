import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/movie_data_agent.dart';

class DioMovieDataAgentImpl extends MovieDataAgent{
  @override
  void getNowPlayingMovies(int page) {
    Map<String,String> queryParameter = {
      PARAM_API_KEY: API_KEY,
      PARAM_LANGUAGE: LANGUAGE_EN_US,
      PARAM_PAGE: page.toString()
    };

    Dio().get("$BASE_URL_DIO$ENDPOINT_GET_NOW_PLAYING",queryParameters: queryParameter)
        .then((value) => {
      debugPrint("Now Playing Movie  =  ${value.toString()}")
    }).catchError((error){
      debugPrint("Error =  ${error.toString()}");
    });
  }

}