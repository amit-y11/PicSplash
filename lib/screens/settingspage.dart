import 'package:flutter/material.dart';
import 'package:picsplash/screens/aboutpage.dart';
import 'package:picsplash/widgets/accent_colors.dart';
import 'package:picsplash/widgets/thememode_dialog.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Appearance",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return ThemeModeDialog();
                    }),
                title: Text(
                  "Select theme mode",
                ),
                leading: Icon(Icons.format_paint),
                subtitle: Text("Choose theme mode"),
              ),
              ListTile(
                title: Text("Select dark theme"),
                subtitle: Text(
                    "Choose the dark theme to use when dark mode is enabled"),
                leading: Icon(Icons.color_lens),
              ),
              ListTile(
                  onTap:() => showDialog(
                    context: context,
                    builder: (context) {
                      return AccentColors();
                    }),
                  title: Text("Pick accent color"),
                  subtitle: Text("Select accent color"),
                  leading: Icon(Icons.colorize)),
              ListTile(
                title: Text(
                  "Info",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListTile( 
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>AboutPage()));
                },
                title: Text("About"),
                leading: Icon(Icons.info),
              )
            ],
          ),
        ));
  }
}
