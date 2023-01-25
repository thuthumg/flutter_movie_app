import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/viewitems/banner_view.dart';
import 'package:movie_app/viewitems/movie_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
        title: const Text(
          MAIN_SCREEN_APP_BAR_TITLE,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              left: 0,
              top: 0,
              right: MARGIN_MEDIUM_2,
              bottom: 0,
            ),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        color: PRIMARY_COLOR,
        child: Column(
          children:  [
            BannerSectionView(),
            Container(
              height: MOVIE_LIST_HEIGHT,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                itemCount: 10,
                  itemBuilder: (BuildContext context, int index){
                  return MovieView();
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BannerSectionView extends StatelessWidget {
  const BannerSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: PageView(
        children: const [
          BannerView(),
          BannerView(),
        ],
      ),
    );
  }
}
