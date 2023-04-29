import 'package:flutter/cupertino.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

class MovieDetailsBloc extends ChangeNotifier{

  ///State
  MovieVO? mMovie;
  List<ActorVO>? cast;
  List<ActorVO>? crew;
  List<MovieVO>? mRelatedMovies;

  ///Model
 MovieModel mMovieModel = MovieModelImpl();

 MovieDetailsBloc(int movieId,[MovieModel? movieModel]){

   ///Set Mock Model for Test Data
   if(movieModel != null)
   {
     mMovieModel = movieModel;
   }

   ///Movie Details
   mMovieModel.getMovieDetails(movieId).then((movie){
     if(movie != null)
       {
         this.mMovie = movie;
         getRelatedMovies(movie.genres?.first.id??0);
         notifyListeners();
       }

   });

   ///Movie Detail data from database
   mMovieModel.getMovieDetailsFromDatabase(movieId).then((movieDetails) {
    this.mMovie = movieDetails;
    notifyListeners();
   }).catchError((error) {
     debugPrint(error.toString());
   });



   ///Cast and Crew
   mMovieModel.getCreditsByMovie(movieId).then((castAndCrew) {
     this.cast = castAndCrew.first;
     this.crew = castAndCrew[1];
    notifyListeners();
   }).catchError((error) {
     debugPrint(error.toString());
   });

 }


  void getRelatedMovies(int genreId){
    mMovieModel.getMoviesByGenre(genreId).then((relatedMovies){
      mRelatedMovies = relatedMovies;
      notifyListeners();
    });
  }


}