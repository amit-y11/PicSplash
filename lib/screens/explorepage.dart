import 'package:flutter/material.dart';
import 'package:picsplash/models/topicsmodel.dart';
import 'package:picsplash/providers/get_images.dart';
import 'package:picsplash/widgets/topicsgrid.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final List<TopicsModel> topics = [];
  final GetImages image = GetImages();
  @override
  void initState() {
    super.initState();
    getTopics();
  }

  void getTopics() async {
    List<TopicsModel> topic = await image.getTopicsList();
    setState(() {
      topic.forEach((element) {
        topics.add(element);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10.0, 80.0, 10.0, 10.0),
          constraints: BoxConstraints.expand(height: 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                  image: AssetImage("assets/images/explore.jpg"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Text(
              "Explore",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ),
        ),
        TopicsView(topics: topics)
      ]),
    );
  }
}
