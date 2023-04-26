import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/dataagents/movie_data_agent.dart';
import 'package:movie_app/network/dataagents/retrofit_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_dao.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';
import 'package:movie_app/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel {
  MovieDataAgent _dataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  ///Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  // @override
  // Future<List<MovieVO>?> getNowPlayingMovies() {
  //   //  return _dataAgent.getNowPlayingMovies(1);
  //
  //   return _dataAgent.getNowPlayingMovies(1).then((movies) async {
  //     List<MovieVO>? nowPlayingMovies = movies?.map((movie) {
  //       movie.isNowPlaying = true;
  //       movie.isPopular = false;
  //       movie.isTopRated = false;
  //
  //       return movie;
  //     }).toList();
  //
  //     mMovieDao.saveAllMovies(nowPlayingMovies ?? []);
  //     return Future.value(movies);
  //   });
  // }

  @override
  void getNowPlayingMovies(int page) {
    //  return _dataAgent.getNowPlayingMovies(1);

    _dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO>? nowPlayingMovies = movies?.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;

        return movie;
      }).toList();

      mMovieDao.saveAllMovies(nowPlayingMovies ?? []);
    });
  }

  @override
  Future<List<ActorVO>?> getActors(int page) {
    // return _dataAgent.getActors(page);

    return _dataAgent.getActors(page).then((actors) async {
      mActorDao.saveAllActors(actors ?? []);

      return Future.value(actors);
    });
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    //  return _dataAgent.getGenres();
    return _dataAgent.getGenres().then((genres) async {
      mGenreDao.saveAllGenres(genres);
      return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>?> getMoviesByGenre(int genreId) {
    return _dataAgent.getMoviesByGenre(genreId);
  }

  // @override
  // Future<List<MovieVO>?> getPopularMovies() {
  //   // return _dataAgent.getPopularMovies(1);
  //
  //   return _dataAgent.getPopularMovies(1).then((movies) async {
  //     List<MovieVO>? popularMovies = movies?.map((movie) {
  //       movie.isPopular = true;
  //       movie.isNowPlaying = false;
  //       movie.isTopRated = false;
  //       return movie;
  //     }).toList();
  //
  //     mMovieDao.saveAllMovies(popularMovies ?? []);
  //     return Future.value(movies);
  //   });
  // }

  @override
  void getPopularMovies() {
    // return _dataAgent.getPopularMovies(1);

    _dataAgent.getPopularMovies(1).then((movies) async {
      List<MovieVO>? popularMovies = movies?.map((movie) {
        movie.isPopular = true;
        movie.isNowPlaying = false;
        movie.isTopRated = false;
        return movie;
      }).toList();

      mMovieDao.saveAllMovies(popularMovies ?? []);
    });
  }

  // @override
  // Future<List<MovieVO>?> getTopRatedMovies() {
  //   // return _dataAgent.getTopRatedMovies(1);
  //   return _dataAgent.getTopRatedMovies(1).then((movies) {
  //     List<MovieVO>? topRatedMovies = movies?.map((movie) {
  //       movie.isTopRated = true;
  //       movie.isPopular = false;
  //       movie.isNowPlaying = false;
  //
  //       return movie;
  //     }).toList();
  //
  //     mMovieDao.saveAllMovies(topRatedMovies ?? []);
  //     return Future.value(movies);
  //   });
  // }

  @override
  void getTopRatedMovies() {
    // return _dataAgent.getTopRatedMovies(1);
    _dataAgent.getTopRatedMovies(1).then((movies) {
      List<MovieVO>? topRatedMovies = movies?.map((movie) {
        movie.isTopRated = true;
        movie.isPopular = false;
        movie.isNowPlaying = false;

        return movie;
      }).toList();

      mMovieDao.saveAllMovies(topRatedMovies ?? []);
    });
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return _dataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    // return _dataAgent.getMovieDetails(movieId);

    return _dataAgent.getMovieDetails(movieId).then((movie) async {
      if (movie != null) {

        mMovieDao.getAllMovies().where((movieVO) => movieVO.id == movie.id)
            .map((movieVOParam){
          movie.isPopular = movieVOParam.isPopular;
          movie.isTopRated = movieVOParam.isTopRated;
          movie.isNowPlaying = movieVOParam.isNowPlaying;
          mMovieDao.saveSingleMovie(movie);
        });
      }
      return Future.value(movie);
    });
  }

  ///Database
  @override
  Future<List<ActorVO>?> getAllActorsFromDatabase() {
    return Future.value(mActorDao.getAllActors());
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future.value(mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }

  // @override
  // Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
  //   return Future.value(mMovieDao
  //       .getAllMovies()
  //       .where((movie) => movie.isNowPlaying ?? true)
  //       .toList());
  // }
  //
  // @override
  // Future<List<MovieVO>?> getPopularMoviesFromDatabase() {
  //   return Future.value(mMovieDao
  //       .getAllMovies()
  //       .where((movie) => movie.isPopular ?? true)
  //       .toList());
  // }
  //
  // @override
  // Future<List<MovieVO>?> getTopRatedMoviesFromDatabase() {
  //   return Future.value(mMovieDao
  //       .getAllMovies()
  //       .where((movie) => movie.isTopRated ?? true)
  //       .toList());
  // }

//Database
//   @override
//   Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
//     this.getNowPlayingMovies();
//     return mMovieDao
//         .getAllMoviesEventStream()
//         .startWith(mMovieDao.getNowPlayingMoviesStream())
//         .combineLatest(mMovieDao.getNowPlayingMoviesStream(),
//             (event, movieList) => movieList as List<MovieVO>)
//         .first;
//   }
  @override
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovies(1);
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesFromDatabase() {
    this.getPopularMovies();
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovies());
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    this.getTopRatedMovies();
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .map((event) => mMovieDao.getTopRatedMovies());
  }
}