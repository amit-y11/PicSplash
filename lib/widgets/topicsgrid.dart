import 'package:flutter/material.dart';
import 'package:picsplash/models/imagemodel.dart';
import 'package:picsplash/models/topicsmodel.dart';
import 'package:picsplash/providers/get_images.dart';
import 'package:picsplash/widgets/photosgrid.dart';

class TopicsView extends StatelessWidget {
  const TopicsView({
    Key? key,
    required this.topics,
  }) : super(key: key);

  final List<TopicsModel> topics;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.96,
        minChildSize: 0.65,
        builder: (context, scrolls) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 2)],
                color: Theme.of(context).canvasColor),
            child: OrientationBuilder(builder: (context, orientation) {
              return GridView.count(
                  controller: scrolls,
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                  children: topics
                      .map((topic) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OnTopicsClick(
                                            slug: topic.slug,
                                            topicTitle: topic.title,
                                          )));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            topic.coverPhoto.urls.small),
                                        fit: BoxFit.cover)),
                                child: Stack(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      topic.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                ])),
                          ))
                      .toList());
            }),
          );
        });
  }
}

class OnTopicsClick extends StatefulWidget {
  const OnTopicsClick({Key? key, required this.slug, required this.topicTitle})
      : super(key: key);

  final String slug;
  final String topicTitle;
  @override
  _OnTopicsClickState createState() => _OnTopicsClickState();
}

class _OnTopicsClickState extends State<OnTopicsClick> {
  final scrolls = ScrollController();

  final List<ImageModel> topicImages = [];
  final GetImages image = GetImages();

  @override
  void initState() {
    super.initState();
    int pageNo = 1;
    getTopicsImages(widget.slug, pageNo);
    scrolls.addListener(() {
      if (scrolls.position.pixels == scrolls.position.maxScrollExtent) {
        pageNo++;
        getTopicsImages(widget.slug, pageNo);
      }
    });
  }

  void getTopicsImages(topic, pageNo) async {
    List<ImageModel> images =
        await image.getTopic(topic: topic, pageNo: pageNo);
    setState(() {
      images.forEach((image) {
        topicImages.add(image);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.topicTitle),
        ),
        body: PhotosView(
          images: topicImages,
          scrollController: scrolls,
          isNormalGrid: false,
        ));
  }
}
