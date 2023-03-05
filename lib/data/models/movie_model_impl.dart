import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_app/network/dataagents/retrofit_data_agent_impl.dart';

class MovieModelImpl extends MovieModel{

  MovieDataAgent _dataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton =
  MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  @override
  Future<List<MovieVO>?> getNowPlayingMovies() {
   return _dataAgent.getNowPlayingMovies(1);
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    return _dataAgent.getActors(page);
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres();
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return _dataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<MovieVO>?> getPopularMovies() {
    return _dataAgent.getPopularMovies(1);
  }

  @override
  Future<List<MovieVO>?> getTopRatedMovies() {
    return _dataAgent.getTopRatedMovies(1);
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return _dataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId);
  }


}