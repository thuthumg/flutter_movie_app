import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class MovieModel extends Model {
  ///Network
  void getNowPlayingMovies();
  void getPopularMovies();
  void getTopRatedMovies();
  void getGenres();
  void getMoviesByGenre(int genreId);
  void getActors(int page);
  void getMovieDetails(int movieId);
  void getCreditsByMovie(int movieId);

  ///Database

  void getNowPlayingMoviesFromDatabase();
  void getPopularMoviesFromDatabase();
  void getTopRatedMoviesFromDatabase();
  void getGenresFromDatabase();
  void getAllActorsFromDatabase();
  void getMovieDetailsFromDatabase(int movieId);
}
