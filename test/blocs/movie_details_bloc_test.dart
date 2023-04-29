import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/blocs/movie_details_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){
  group("Movie Details Bloc Test", () {

    MovieDetailsBloc? movieDetailsBloc;

    setUp((){
      movieDetailsBloc = MovieDetailsBloc(1,MovieModelImplMock());
    });


    test("Fetch Movie Details Test", (){
      expect(movieDetailsBloc?.mMovie, getMockMoviesForTest().first);
    });

    test("Fetch Creators Test", (){
      expect(movieDetailsBloc?.crew, getMockCredits().last);
    });

    test("Fetch Actors Test", (){
      expect(movieDetailsBloc?.cast, getMockCredits().first);
    });

    test("Fetch Related Movies Test", ()async{

      await Future.delayed(Duration(milliseconds: 500));

      expect(movieDetailsBloc?.mRelatedMovies?.contains(getMockMoviesForTest().first),true);
    });

  });
}