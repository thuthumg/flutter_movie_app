import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_app/data/vos/actor_vo.dart';
import 'package:movie_app/data/vos/collection_vo.dart';
import 'package:movie_app/data/vos/date_vo.dart';
import 'package:movie_app/data/vos/genre_vo.dart';
import 'package:movie_app/data/vos/movie_vo.dart';
import 'package:movie_app/data/vos/production_company_vo.dart';
import 'package:movie_app/data/vos/production_country_vo.dart';
import 'package:movie_app/data/vos/spoken_language_vo.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/persistence/hive_constants.dart';

import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ActorVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguageVOAdapter());

  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);

  testWidgets("Tap Best Popular Movies and Navigate To Details",
      (widgetTester) async {
    await widgetTester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));

    await widgetTester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(HomePage), findsOneWidget);

    expect(find.text(TEST_DATA_MOVIE_NAME), findsOneWidget);

    await widgetTester.tap(find.text(TEST_DATA_MOVIE_NAME));

    await widgetTester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(TEST_DATA_MOVIE_NAME), findsOneWidget);
    expect(find.text(TEST_DATA_RELEASED_YEAR), findsOneWidget);
    expect(find.text(TEST_DATA_RATING), findsOneWidget);
  });

  testWidgets(
      "Scroll Up On The Home Page , Tap Genre Item  , Navigate To Details and Back To Main Page",
      (widgetTester) async {
    await widgetTester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));

    await widgetTester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(HomePage), findsOneWidget);

    expect(find.text(TEST_DATA_MOVIE_NAME), findsOneWidget);

    ///Scroll Up On The Home Page
    await widgetTester.dragUntilVisible(
        find.text(TEST_DATA_GENRE_NAME), //
        find.byType(SingleChildScrollView),
        // find.byKey(SingleChildScrollView), // widget you want to scroll
        Offset(0.0, -10.0)
        );
    await widgetTester.pumpAndSettle(Duration(seconds: 3));

    // Verify that the target widget is visible
    expect(find.text(TEST_DATA_GENRE_TAP_NAME), findsOneWidget);

    /// Tap Genre Item
    await widgetTester.tap(find.text(TEST_DATA_GENRE_TAP_NAME));
    await widgetTester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(TEST_DATA_GENRE_TAP_MOVIE_NAME), findsOneWidget);
    // await widgetTester.pumpAndSettle(Duration(seconds: 3));

    /// Navigate To Details
    await widgetTester.tap(find.text(TEST_DATA_GENRE_TAP_MOVIE_NAME));
    await widgetTester.pumpAndSettle(Duration(seconds: 5));
    expect(find.text(TEST_DATA_GENRE_TAP_MOVIE_NAME), findsOneWidget);
    expect(find.text(TEST_DATA_GENRE_TAP_RELEASED_YEAR), findsOneWidget);
    expect(find.text(TEST_DATA_GENRE_TAP_RATING), findsOneWidget);

    ///Back To Main Page
    // await widgetTester.sendKeyEvent(LogicalKeyboardKey.escape);
    // await widgetTester.pumpAndSettle(Duration(seconds: 5));
    //  expect(find.text('Discover'), findsOneWidget);
  });
}
