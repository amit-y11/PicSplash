import 'package:flutter/material.dart';
import 'package:picsplash/utils/my_state.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final pageState = context.watch<PageState>();
    return BottomNavigationBar(
        elevation: 0.0,
        selectedItemColor: Theme.of(context).accentColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        enableFeedback: true,
        onTap: (index) {
          pageState.changePage(index);
          pageController.jumpToPage(index);
        },
        currentIndex: pageState.currentPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: "Explore",
              activeIcon: Icon(Icons.explore)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: "Favorite",
              activeIcon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
              activeIcon: Icon(Icons.settings)),
        ]);
  }
}

// NavigationBar(
//         onDestinationSelected: (value) {
//           print(value);
//           pageState.changePage(value);
//           pageController.jumpToPage(value);
//         },
//         selectedIndex: pageState.currentPage,
//         destinations: [
//           NavigationDestination(
//             icon: Icon(Icons.home_outlined),
//             label: "Home",
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.explore_outlined),
//             label: "Explore",
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.favorite_border),
//             label: "Favorite",
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.settings_outlined),
//             label: "Settings",
//           ),
//         ])


