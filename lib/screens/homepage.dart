import 'package:flutter/material.dart';
import 'package:picsplash/models/imagemodel.dart';
import 'package:picsplash/providers/get_images.dart';
import 'package:picsplash/utils/search_bar.dart';
import 'package:picsplash/widgets/photosgrid.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final List<ImageModel> myImage = [];
  @override
  void initState() {
    super.initState();
    getMyImages();
    scrolls.addListener(() {
      if (scrolls.position.pixels == scrolls.position.maxScrollExtent) {
        getMyImages();
      }
    });
  }

  void getMyImages() async {
    List<ImageModel> images = await image.getRandomImages();
    setState(() {
      images.forEach((image) {
        myImage.add(image);
      });
    });
  }

  final GetImages image = GetImages();
  ScrollController scrolls = ScrollController();

  @override
  void dispose() {
    scrolls.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          children: [
            Text(
              "Pic",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Splash",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchBar());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: PhotosView(
        images: myImage,
        scrollController: scrolls,
      ),
    );
  }
}
