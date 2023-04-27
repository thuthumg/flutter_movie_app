import 'package:hive/hive.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:movie_app/persistence/hive_constants.dart';

class MovieDaoImpl extends MovieDao{
  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl() {
    return _singleton;
  }

  MovieDaoImpl._internal();

  @override
  void saveAllMovies(List<MovieVO> movies) async {
    Map<int, MovieVO> movieMap = Map.fromIterable(movies,
        key: (movie) => movie.id, value: (movie) => movie);

    await getMovieBox().putAll(movieMap);
  }

  @override
  void saveSingleMovie(MovieVO movie) async {
    return getMovieBox().put(movie.id, movie);
  }

  @override
  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  @override
  MovieVO? getMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }

  ///Reactive Programming
  @override
  Stream<void> getAllMoviesEventStream() {
    return getMovieBox().watch();
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isNowPlaying ?? false)
        .toList());
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(
        getAllMovies().where((element) => element.isPopular ?? false).toList());
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesStream() {
    return Stream.value(getAllMovies()
        .where((element) => element.isTopRated ?? false)
        .toList());
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((element) => element.isNowPlaying ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  List<MovieVO> getTopRatedMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((element) => element.isTopRated ?? false)
          .toList();
    } else {
      return [];
    }
  }

  @override
  List<MovieVO> getPopularMovies() {
    if (getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)) {
      return getAllMovies()
          .where((element) => element.isPopular ?? false)
          .toList();
    } else {
      return [];
    }
  }
}

