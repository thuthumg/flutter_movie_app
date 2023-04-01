import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

abstract class MovieModel{

  ///Network
  // Future<List<MovieVO>?> getNowPlayingMovies();
  // Future<List<MovieVO>?> getPopularMovies();
  // Future<List<MovieVO>?> getTopRatedMovies();
  void getNowPlayingMovies();
  void getPopularMovies();
  void getTopRatedMovies();

  Future<List<GenreVO>?> getGenres();
  Future<List<MovieVO>?> getMoviesByGenre(int genreId);
  Future<List<ActorVO>?> getActors(int page);
  Future<MovieVO?> getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);


  ///Database
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>> getPopularMoviesFromDatabase();
  Stream<List<MovieVO>>  getTopRatedMoviesFromDatabase();
  Future<List<GenreVO>?> getGenresFromDatabase();
  Future<List<ActorVO>?> getAllActorsFromDatabase();
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId);
}