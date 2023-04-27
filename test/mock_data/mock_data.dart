import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/network/responses/get_credits_by_movie_response.dart';

List<MovieVO> getMockMoviesForTest() {
  return [
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
        isTopRated: true)
  ];
}

List<ActorVO> getMockActors() {
  return [
    ActorVO(
        adult: false,
        // gender: 1,
        id: 224513,
        knownFor: [
          MovieVO(
              adult: false,
              backDropPath: "/ilRyazdMJwN05exqhwK4tMKBYZs.jpg",
              genreIds: [878, 18],
              id: 335984,
              originalLanguage: "en",
              originalTitle: "Blade Runner 2049",
              overview:
                  "Thirty years after the events of the first film, a new blade runner, LAPD Officer K, unearths a long-buried secret that has the potential to plunge what's left of society into chaos. K's discovery leads him on a quest to find Rick Deckard, a former LAPD blade runner who has been missing for 30 years.",
              posterPath: "/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg",
              releaseDate: "2017-10-04",
              title: "Blade Runner 2049",
              video: false,
              voteAverage: 7.5,
              voteCount: 11770),
          MovieVO(
              adult: false,
              backDropPath: "/4HWAQu28e2yaWrtupFPGFkdNU7V.jpg",
              genreIds: [35, 80, 9648],
              id: 546554,
              originalLanguage: "en",
              originalTitle: "Knives Out",
              overview:
                  "When renowned crime novelist Harlan Thrombey is found dead at his estate just after his 85th birthday, the inquisitive and debonair Detective Benoit Blanc is mysteriously enlisted to investigate. From Harlan's dysfunctional family to his devoted staff, Blanc sifts through a web of red herrings and self-serving lies to uncover the truth behind Harlan's untimely death.",
              posterPath: "/pThyQovXQrw2m0s9x82twj48Jq4.jpg",
              releaseDate: "2019-11-27",
              title: "Knives Out",
              video: false,
              voteAverage: 7.9,
              voteCount: 10629),
          MovieVO(
              adult: false,
              backDropPath: "/3Mnbw4gOYz5BNZB9PhZ2cyBSQum.jpg",
              genreIds: [35, 80, 18],
              id: 308266,
              originalLanguage: "en",
              originalTitle: "War Dogs",
              overview:
                  "Based on the true story of two young men, David Packouz and Efraim Diveroli, who won a 300 million contract from the Pentagon to arm America's allies in Afghanistan.",
              posterPath: "/uH9qGH5XS1iZXCSb3tgu40dxQoh.jpg",
              releaseDate: "2016-08-17",
              title: "War Dogs",
              video: false,
              voteAverage: 6.9,
              voteCount: 4324)
        ],
        knownForDepartment: "Acting",
        name: "Ana de Armas",
        popularity: 349.766,
        profilePath: "/3vxvsmYLTf4jnr163SUlBIw51ee.jpg"),
    ActorVO(
        adult: false,
        id: 2710789,
        knownFor: [
          MovieVO(
              adult: false,
              backDropPath: "/rnWEut44AFaC4G7H3nSwzKVIyV8.jpg",
              genreIds: [18, 10749],
              id: 724106,
              originalLanguage: "ko",
              originalTitle: "18금 아이돌 승하의 섹스 스캔들",
              overview:
                  "When they were young, Min-joo and Seo-yeon cared for each other and were closer than brothers and sisters. However, she accidentally learns about Seo-yeon's tutor, Woo-hyeon, and because of this man, their 10-year friendship starts to become shaky. Meanwhile, Jeong-soo is hurt in seeing Min-joo like that, and so he distanced himself from Min-joo. Because of Min-joo and Seo-yeon's misunderstanding, Jeong-soo who couldn't care much might just leave so Min-joo tries to break up with the help of Seo-yeon. While in the process of breaking up, Min-joo and Seo-yeon went back to their close relationship.  The love of women who have been separated because of man, and the two men's friendship is comically drawn.",
              posterPath: "/btpk0Y0m9MjvMCfgrW0i0d7fpd1.jpg",
              releaseDate: "2020-07-17",
              title: "R-Rated Idol Seung-ha's Sex Scandal",
              video: false,
              voteAverage: 7,
              voteCount: 30)
        ],
        knownForDepartment: "Acting",
        name: "Seung Ha",
        popularity: 256.235,
        profilePath: "/hpMpnHprRlCzvNVlx6C3RWmswOF.jpg"),
    ActorVO(
        adult: false,
        id: 2710789,
        knownFor: [],
        knownForDepartment: "Acting",
        name: "Seung Ha",
        popularity: 256.235,
        profilePath: "/hpMpnHprRlCzvNVlx6C3RWmswOF.jpg")
  ];
}

List<GenreVO>? getMockGenres() {
  return [
    GenreVO(id: 28,
        name: "Action"),
    GenreVO(id: 12,
        name: "Adventure"),
    GenreVO( id: 16,
        name: "Animation")
  ];
}

List<List<ActorVO>?> getMockCredits() {
  GetCreditsByMovieResponse getCreditsByMovieResponse =
      GetCreditsByMovieResponse(id: 464052, cast: [
    ActorVO(
        adult: false,
        id: 90633,
        knownForDepartment: "Acting",
        name: "Gal Gadot",
        originalName: "Gal Gadot",
        popularity: 37.973,
        profilePath: "/plLfB60M5cJrnog8KvAKhI4UJuk.jpg",
        castId: 0,
        character: "Diana Prince / Wonder Woman",
        creditId: "595686e4c3a368382e050da4",
        order: 0),
    ActorVO(
        adult: false,
        id: 62064,
        knownForDepartment: "Acting",
        name: "Chris Pine",
        originalName: "Chris Pine",
        popularity: 38.065,
        profilePath: "/vNhLYVlo84q78NVIP6s3EYV7lEH.jpg",
        castId: 15,
        character: "Steve Trevor",
        creditId: "5b0b4526c3a3684adc0097a5",
        order: 1),
    ActorVO(
        adult: false,
        id: 41091,
        knownForDepartment: "Acting",
        name: "Kristen Wiig",
        originalName: "Kristen Wiig",
        popularity: 19.665,
        profilePath: "/43lFW3Ed6tNaVMsr9cwg0eP9n5n.jpg",
        castId: 12,
        character: "Barbara Ann Minerva / Cheetah",
        creditId: "5a975236c3a36861510077f1",
        order: 2)
  ], crew: [
    ActorVO(
        adult: false,
        id: 1113,
        knownForDepartment: "Production",
        name: "Lucinda Syson",
        originalName: "Lucinda Syson",
        popularity: 2.336,
        profilePath: null,
        creditId: "5c726ac6c3a3685a32151706"),
    ActorVO(
        adult: false,
        id: 947,
        knownForDepartment: "Sound",
        name: "Hans Zimmer",
        originalName: "Hans Zimmer",
        popularity: 14.831,
        profilePath: "/tpQnDeHY15szIXvpnhlprufz4d.jpg",
        creditId: "5b7dcdd70e0a2615ba005fa8"),
    ActorVO(
        adult: false,
        id: 282,
        knownForDepartment: "Production",
        name: "Charles Roven",
        originalName: "Charles Roven",
        popularity: 1.539,
        profilePath: "/4uJLoVstC1CBcArXFOe53N2fDr1.jpg",
        creditId: "5b212459c3a368149000ed97")
  ]);
  return [getCreditsByMovieResponse.cast, getCreditsByMovieResponse.crew];
}
