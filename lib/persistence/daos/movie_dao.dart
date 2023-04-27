
import 'package:movie_app/data/vos/movie_vo.dart';


abstract class MovieDao {
  void saveAllMovies(List<MovieVO> movies);
  void saveSingleMovie(MovieVO movie);
  List<MovieVO> getAllMovies();
  MovieVO? getMovieById(int movieId);
  ///Reactive Programming
  Stream<void> getAllMoviesEventStream();
  Stream<List<MovieVO>> getNowPlayingMoviesStream();
  Stream<List<MovieVO>> getPopularMoviesStream();
  Stream<List<MovieVO>> getTopRatedMoviesStream();
  List<MovieVO> getNowPlayingMovies();
  List<MovieVO> getTopRatedMovies();
  List<MovieVO> getPopularMovies();
}

