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

  MovieModelImpl._internal(){
    getNowPlayingMoviesFromDatabase();
    getTopRatedMoviesFromDatabase();
    getPopularMoviesFromDatabase();
    getActors(1);
    getAllActorsFromDatabase();
    getGenres();
    getGenresFromDatabase();
  }

  ///Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  ///Home page State Variables
  List<MovieVO>? mNowPlayingMovies;
  List<MovieVO>? mPopularMovies;
  List<MovieVO>? mTopRatedMovies;
  List<MovieVO>? mMoviesByGenre;
  List<GenreVO>? mGenres;
  List<ActorVO>? mActors;

  ///Movie Detail State Variables
  MovieVO? movieDetails;
  List<ActorVO>? cast;
  List<ActorVO>? crew;

  @override
  void getNowPlayingMovies() {
    //  return _dataAgent.getNowPlayingMovies(1);

    _dataAgent.getNowPlayingMovies(1).then((movies) async {
      List<MovieVO>? nowPlayingMovies = movies?.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;

        return movie;
      }).toList();

      mMovieDao.saveAllMovies(nowPlayingMovies ?? []);
      mNowPlayingMovies = nowPlayingMovies;
      notifyListeners();
    });
  }

  @override
  void getActors(int page) {
    // return _dataAgent.getActors(page);

    _dataAgent.getActors(page).then((actors) async {
      mActorDao.saveAllActors(actors ?? []);
      mActors = actors;
      notifyListeners();
      return Future.value(actors);
    });
  }

  @override
  void getGenres() {
    //  return _dataAgent.getGenres();
    _dataAgent.getGenres().then((genres) async {
      mGenreDao.saveAllGenres(genres);
      mGenres = genres;
      getMoviesByGenre(genres?.first.id??0);
      notifyListeners();
      return Future.value(genres);
    });
  }

  @override
  void  getMoviesByGenre(int genreId) {
    _dataAgent.getMoviesByGenre(genreId)
    .then((moviesList) {
      mMoviesByGenre = moviesList;
      notifyListeners();
    });
  }
  @override
  void getPopularMovies() {
     _dataAgent.getPopularMovies(1).then((movies) async {
      List<MovieVO>? popularMovies = movies?.map((movie) {
        movie.isPopular = true;
        movie.isNowPlaying = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      mPopularMovies = popularMovies;
      notifyListeners();
      mMovieDao.saveAllMovies(popularMovies ?? []);
    });
  }

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
      mTopRatedMovies = topRatedMovies;
      notifyListeners();
      mMovieDao.saveAllMovies(topRatedMovies ?? []);
    });
  }

  @override
  void getCreditsByMovie(int movieId) {
    _dataAgent.getCreditsByMovie(movieId)
    .then((creditsList){
      this.cast = creditsList.first?.toList();
      this.crew = creditsList[1]?.toList();
      notifyListeners();
    });
  }

  @override
  void getMovieDetails(int movieId) {

    _dataAgent.getMovieDetails(movieId).then((movie) async {
      if (movie != null) {

         mMovieDao.getAllMovies().where((movieVO) => movieVO.id == movie.id)
         .map((movieVOParam){
           movie.isPopular = movieVOParam.isPopular;
           movie.isTopRated = movieVOParam.isTopRated;
           movie.isNowPlaying = movieVOParam.isNowPlaying;
           mMovieDao.saveSingleMovie(movie);
           movieDetails = movie;
           notifyListeners();
         });



      }
      return Future.value(movie);
    });
  }

  ///Database
  @override
  void getAllActorsFromDatabase() {
     mActors = mActorDao.getAllActors();
  }

  @override
  void getGenresFromDatabase() {
   mGenres = mGenreDao.getAllGenres();
  }

  @override
  void getMovieDetailsFromDatabase(int movieId) {
    movieDetails = mMovieDao.getMovieById(movieId);
    notifyListeners();
  }

  @override
  void getNowPlayingMoviesFromDatabase() {
     this.getNowPlayingMovies();
     mMovieDao
      .getAllMoviesEventStream()
       .startWith(mMovieDao.getNowPlayingMoviesStream())
       .map((event) => mMovieDao.getNowPlayingMovies())
         .listen((nowPlayingMovies) {
       mNowPlayingMovies = nowPlayingMovies;
       notifyListeners();
     });
  }
  @override
  void getPopularMoviesFromDatabase() {
    this.getPopularMovies();
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovies())
        .listen((popularMovies) {
      mPopularMovies = popularMovies;
      notifyListeners();
    });
  }

  @override
  void getTopRatedMoviesFromDatabase() {
    this.getTopRatedMovies();
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .map((event) => mMovieDao.getTopRatedMovies())
    .listen((topRatedMovies) {
      mTopRatedMovies = topRatedMovies;
      notifyListeners();
    });
  }
}
