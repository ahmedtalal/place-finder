import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/pages/navbar_components/favorites.dart';
import 'package:online_booking_places/pages/navbar_components/search.dart';
import 'package:online_booking_places/pages/navbar_components/settings.dart';
import 'package:online_booking_places/pages/navbar_components/targets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  switchPages(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> pages = [
    Targets(),
    Search(),
    Favorites(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: false,
        opacity: 0.9,
        currentIndex: currentIndex,
        onTap: switchPages,
        elevation: 3.0,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
        items: [
          //home page
          BubbleBottomBarItem(
            title: Text(
              "Home",
              style: TextStyle(
                fontFamily: appFont,
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
            icon: Image.asset(
              homePage,
              height: 15.0,
              color: Colors.black,
            ),
            activeIcon: Image.asset(
              homePage,
              height: 15.0,
              color: Colors.white,
            ),
          ),

          // search page
          BubbleBottomBarItem(
            title: Text(
              "Search",
              style: TextStyle(
                fontFamily: appFont,
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.deepPurple,
            icon: Icon(
              Icons.search,
              size: 16.0,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.search,
              size: 16.0,
              color: Colors.white,
            ),
          ),

          // favorites
          BubbleBottomBarItem(
            title: Text(
              "Favorites",
              style: TextStyle(
                fontFamily: appFont,
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.indigo,
            icon: Image.asset(
              favoritesPage,
              height: 15.0,
              color: Colors.black,
            ),
            activeIcon: Image.asset(
              favoritesPage,
              height: 15.0,
              color: Colors.white,
            ),
          ),

          // settings
          BubbleBottomBarItem(
            title: Text(
              "Settings",
              style: TextStyle(
                fontFamily: appFont,
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.purple,
            icon: Image.asset(
              settingPage,
              height: 15.0,
              color: Colors.black,
            ),
            activeIcon: Image.asset(
              settingPage,
              height: 18.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: pages.elementAt(currentIndex),
      ),
    );
  }
}
