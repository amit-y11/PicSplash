import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:picsplash/models/imagemodel.dart';
import 'package:picsplash/utils/pref_manager.dart';
import 'package:picsplash/widgets/photosgrid.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    getImageModels();
    super.initState();
  }

  ScrollController scrolls = ScrollController();
  List<ImageModel> myImages = [];
  PrefManager prefs = PrefManager();

  Future<void> getImageModels() async {
    final favorites = await prefs.getFavoriteList();
    if (favorites.length != 0) {
      favorites.forEach((url) {
        final imagedata = {
          "id": "",
          "urls": {
            "small": "",
            "raw": "",
            "regular": url,
            "thumb": "",
            "full": ""
          }
        };
        setState(() {
          myImages.add(ImageModel.fromJson(imagedata));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: myImages.length == 0
            ? NoFavoritePage()
            : Container(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10.0, 60.0, 10.0, 10.0),
                      constraints: BoxConstraints.expand(height: 80),
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        "Favorites",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      )),
                    ),
                    Expanded(
                      child: PhotosView(
                          images: myImages,
                          scrollController: scrolls,
                          isNormalGrid: true),
                    ),
                  ],
                ),
              ));
  }
}

class NoFavoritePage extends StatelessWidget {
  const NoFavoritePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/heart.png",
              height: 80,
              width: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "You have no favorites yet.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Click some hearts.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
