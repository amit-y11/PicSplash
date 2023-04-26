import 'package:flutter/material.dart';
import 'package:picsplash/screens/searchpage.dart';
import 'package:provider/provider.dart';

import '../models/imagemodel.dart';
import '../providers/get_images.dart';
import '../providers/search_provider.dart';

class SearchBar extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for search bar
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icon on the left of search bar
    return IconButton(
        onPressed: () {
          close(context, "result");
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    // shows the result
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SearchProvider>().searchImage(query);
    });
    return SearchPage(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // shows suggestion when anyone searches anything
    context.read<SearchProvider>().isActive = true;
    return Container(
      child: Center(
        child: Image(
          image: AssetImage("assets/images/mountain.png"),
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
