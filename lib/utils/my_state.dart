import 'package:flutter/material.dart';

class ThemeState extends ChangeNotifier {
  int currentThemeIndex = 0;
  ThemeMode currentThemeMode = ThemeMode.light;
  List<ThemeMode> _themeModes = [
    ThemeMode.light,
    ThemeMode.dark,
    ThemeMode.system
  ];
  

  changeThemeMode(index) {
    currentThemeMode = _themeModes[index];
    currentThemeIndex = index;
    notifyListeners();
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      // scaffoldBackgroundColor: Colors.black45,
      colorScheme: ColorScheme.dark(),
      // canvasColor: Colors.black87,
      appBarTheme: AppBarTheme(
        // brightness: Brightness.dark,
        color: Colors.black45,
      ),
      accentColor: currentAccent,
      primaryColor: Colors.black45,
    );
  }

  // For Accent colors
  int currentAccentIndex = 0;
  List<Color> accentColors = [
    Colors.amber,
    Colors.purple,
    Colors.cyan,
    Colors.greenAccent,
    Colors.lime,
    Colors.redAccent
  ];
  List<Text> accentTexts = [
    Text("Amber"),
    Text("Purple"),
    Text("Cyan"),
    Text("Green Accent"),
    Text("Lime"),
    Text("Red Accent")
  ];
  Color currentAccent = Colors.amber;

  changeAccent(index) {
    currentAccent = accentColors[index];
    currentAccentIndex = index;
    notifyListeners();
  }
}

class PageState extends ChangeNotifier {
  int currentPage = 0;

  changePage(index) {
    currentPage = index;
    notifyListeners();
  }
}
