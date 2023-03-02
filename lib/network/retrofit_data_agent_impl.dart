import 'package:dio/dio.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/the_movie_api.dart';

class RetrofitDataAgentImpl extends MovieDataAgent{

  TheMovieApi mApi;

  RetrofitDataAgentImpl(){
    final dio = Dio();
    mApi = TheMovieApi(dio);
  }

  @override
  void getNowPlayingMovies(int page) {

  }

}