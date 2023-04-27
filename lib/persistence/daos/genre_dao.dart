
import 'package:movie_app/data/vos/genre_vo.dart';


abstract class GenreDao{
  void saveAllGenres(List<GenreVO>? genres);
  List<GenreVO> getAllGenres();

}