import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  toggleFavorite(String url) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final myFavoriteList = prefs.getStringList("favoriteList");
    if (myFavoriteList != null) {
      if (myFavoriteList.contains(url)) {
        myFavoriteList.remove(url);
        await prefs.setStringList("favoriteList", myFavoriteList);
      } else {
        myFavoriteList.add(url);
        await prefs.setStringList("favoriteList", myFavoriteList);
      }
    } else {
      await prefs.setStringList("favoriteList", [url]);
    }
  }

  Future<bool> isFavorite(url) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final myFavoriteList = prefs.getStringList("favoriteList");
    if (myFavoriteList != null) {
      if (myFavoriteList.contains(url))
        return true;
      else
        return false;
    } else
      return false;
  }

  Future<List<String>> getFavoriteList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final myFavoriteList = prefs.getStringList("favoriteList");
    if (myFavoriteList != null) {
      return myFavoriteList;
    } else {
      return [];
    }
  }

  saveThemeIndex(int themeIndex) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("themeIndex", themeIndex);
  }

  Future<int> getThemeIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt("themeIndex");
    if (themeIndex != null) {
      return themeIndex;
    } else
      return 0;
  }

  saveAccentIndex(int accentIndex) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("accentIndex", accentIndex);
  }

  Future<int> getAccentIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accentIndex = prefs.getInt("accentIndex");
    if (accentIndex != null) {
      return accentIndex;
    } else
      return 0;
  }
}
