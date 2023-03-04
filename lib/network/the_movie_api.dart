import 'package:dio/dio.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/responses/get_now_playing_response.dart';
import 'package:retrofit/retrofit.dart';

part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieApi{

  factory TheMovieApi(Dio dio) = _TheMovieApi;


  @GET(ENDPOINT_GET_NOW_PLAYING)
  Future<GetNowPlayingResponse> getNowPlayingMovies(
      @Query(PARAM_API_KEY) String apiKey,
      @Query(PARAM_LANGUAGE) String language,
      @Query(PARAM_PAGE) String page,
      );

}