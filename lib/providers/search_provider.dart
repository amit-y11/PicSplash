import 'package:flutter/material.dart';

import '../models/imagemodel.dart';
import 'get_images.dart';

class SearchProvider extends ChangeNotifier {
  bool isSearching = false;
  bool isActive = false;
  List<ImageModel> myImages = [];
  GetImages image = GetImages();
  String query = "";

  void searchImage(String query) async {
    if (isActive) {
      isActive = false;
      isSearching = true;
      this.query = query;
      myImages.clear();
      myImages.addAll(await image.searchImage(query: query));
      isSearching = false;
      notifyListeners();
    }
  }

  Future<void> searchMoreImage() async {
    if (!isSearching) {
      isSearching = true;
      myImages.addAll(await image.searchImage(query: query));
      isSearching = false;
      notifyListeners();
    }
  }
}
