import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("About"),
      ),
      body: Column(
        children: [
          Image(
            image: AssetImage("assets/images/logo.png"),
            height: 200.0,
            width: 200.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pic",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                "Splash",
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 20.0),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/amit-y11"),
              ),
              title: Text("Amit Yadav"),
              subtitle: Text("App Developer"),
              trailing: Container(
                width: 120.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () async {
                          final url = "https://github.com/amit-y11";
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          }
                        },
                        child: FaIcon(
                          FontAwesomeIcons.github,
                          color: Colors.black,
                          size: 30,
                        )),
                    InkWell(
                        onTap: () async {
                          final url = "https://telegram.dog/amit_y11";
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          }
                        },
                        child: FaIcon(
                          FontAwesomeIcons.telegram,
                          color: Colors.blueAccent,
                          size: 30,
                        )),
                    InkWell(
                        onTap: () async {
                          final url = "https://twitter.com/amit_y11";
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          }
                        },
                        child: FaIcon(
                          FontAwesomeIcons.twitter,
                          color: Colors.blue,
                          size: 30,
                        )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Version: 1.0.0",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
