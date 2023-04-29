import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/movie_model_impl.dart';
import 'package:movie_app/data/vos/movie_vo.dart';

import '../mock_data/mock_data.dart';
import '../network/movie_data_agent_impl_mock.dart';
import '../persistence/actor_dao_impl_mock.dart';
import '../persistence/genre_dao_impl_mock.dart';
import '../persistence/movie_dao_impl_mock.dart';

void main() {
  group("movie_model_impl", () {
    var movieModel = MovieModelImpl();
    setUp(() {
      movieModel.setDaosAndDataAgents(
          MovieDaoImplMock(),
          ActorDaoImplMock(),
          GenreDaoImplMock(),
          MovieDataAgentImplMock());
    });

    test(
        "Saving Now Playing Movies and Getting Now Playing Movies From Database",
        () {
      expect(
          movieModel.getNowPlayingMoviesFromDatabase(),
          emits(
            [
              MovieVO(
                  adult: false,
                  backDropPath: "/iJQIbOPm81fPEGKt5BPuZmfnA54.jpg",
                  genreIds: [16, 12, 10751, 14, 35],
                  id: 502356,
                  originalLanguage: "en",
                  originalTitle: "The Super Mario Bros. Movie",
                  overview:
                      "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
                  popularity: 7212.464,
                  posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
                  releaseDate: "2023-04-05",
                  title: "The Super Mario Bros. Movie",
                  video: false,
                  voteAverage: 7.5,
                  voteCount: 1435,
                  isNowPlaying: true,
                  isPopular: false,
                  isTopRated: false),
            ],
          ));
    });


    test(
        "Saving Now Playing Movies and Getting Popular Movies From Database",
            () {
          expect(
              movieModel.getPopularMoviesFromDatabase(),
              emits(
                [
                  MovieVO(
                      adult: false,
                      backDropPath: "/nDxJJyA5giRhXx96q1sWbOUjMBI.jpg",
                      genreIds: [28, 35, 14],
                      id: 594767,
                      originalLanguage: "en",
                      originalTitle: "Shazam! Fury of the Gods",
                      overview:
                      "Billy Batson and his foster siblings, who transform into superheroes by saying \"Shazam!\", are forced to get back into action and fight the Daughters of Atlas, who they must stop from using a weapon that could destroy the world.",
                      popularity: 4319.273,
                      posterPath: "/2VK4d3mqqTc7LVZLnLPeRiPaJ71.jpg",
                      releaseDate: "2023-03-15",
                      title: "Shazam! Fury of the Gods",
                      video: false,
                      voteAverage: 6.8,
                      voteCount: 1203,
                      isNowPlaying: false,
                      isPopular: true,
                      isTopRated: false),
                ],
              ));
        });

    test(
        "Saving Now Playing Movies and Getting Top Rated Movies From Database",
            () {
          expect(
              movieModel.getTopRatedMoviesFromDatabase(),
              emits(
                [
                  MovieVO(
                      adult: false,
                      backDropPath: "/7bWxAsNPv9CXHOhZbJVlj2KxgfP.jpg",
                      genreIds: [27, 53],
                      id: 713704,
                      originalLanguage: "en",
                      originalTitle: "Evil Dead Rise",
                      overview:
                      "Two sisters find an ancient vinyl that gives birth to bloodthirsty demons that run amok in a Los Angeles apartment building and thrusts them into a primal battle for survival as they face the most nightmarish version of family imaginable.",
                      popularity: 1898.367,
                      posterPath: "/mIBCtPvKZQlxubxKMeViO2UrP3q.jpg",
                      releaseDate: "2023-04-12",
                      title: "Evil Dead Rise",
                      video: false,
                      voteAverage: 6.9,
                      voteCount: 192,
                      isNowPlaying: false,
                      isPopular: false,
                      isTopRated: true),
                ],
              ));
        });

    test(
        "Get Genres Test",
            () {
          expect(
              movieModel.getGenres(),
              completion(
               equals(getMockGenres()),
              )
          );
        });

    test(
        "Get Actors Test",
            () {
          expect(
              movieModel.getActors(1),
              completion(
                equals(getMockActors()),
              )
          );
        });

    test(
        "Get Credits Test",
            () {
          expect(
              movieModel.getCreditsByMovie(1),
              completion(
                equals(getMockCredits()),
              )
          );
        });

    test(
        "Get Movie Details Test",
            () {
          expect(
              movieModel.getMovieDetails(1),
              completion(
                equals(getMockMoviesForTest().first),
              )
          );
        });

    test(
        "Get Actors From Database Test",
            () async{
          await movieModel.getActors(1);
          expect(
              movieModel.getAllActorsFromDatabase(),
              completion(
                equals(getMockActors()),
              )
          );
        });

    test(
        "Get Movie Details From Database  Test",
            () async{
          await movieModel.getMovieDetails(1);
          expect(
              movieModel.getMovieDetails(1),
              completion(
                equals(getMockMoviesForTest().first),
              )
          );
        });


    test(
        "Get Genres From Database Test",
            () async{
          await movieModel.getGenres();
          expect(
              movieModel.getGenresFromDatabase(),
              completion(
                equals(getMockGenres()),
              )
          );
        });



  });
}
