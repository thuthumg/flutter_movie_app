import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/persistence/daos/genre_dao.dart';

class GenreDaoImplMock extends GenreDao{

  Map<int,GenreVO> genreListFromDatabaseMock = {};

  @override
  List<GenreVO> getAllGenres() {
    return genreListFromDatabaseMock.values.toList();
  }

  @override
  void saveAllGenres(List<GenreVO>? genres) {
   return genres?.forEach((element) {
     genreListFromDatabaseMock[element.id??0] = element;
   });
  }

}