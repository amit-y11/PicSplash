import 'package:flutter/material.dart';
import 'package:picsplash/screens/searchpage.dart';

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
        icon: AnimatedIcons.menu_arrow, progress: transitionAnimation
      )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // shows the result
    return SearchPage(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // shows suggestion when anyone searches anything
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
