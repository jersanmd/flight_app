import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  List<BottomNavigationBarItem> bottomBarItems = [];

  final bottomNavigationBarItemStyle =
      TextStyle(fontStyle: FontStyle.normal, color: Colors.black);

  CustomNavigationBar() {
    bottomBarItems.add(BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Colors.black),
      title: Text("Explore", style: bottomNavigationBarItemStyle),
    ));

    bottomBarItems.add(BottomNavigationBarItem(
      icon: Icon(Icons.favorite, color: Colors.black),
      title: Text("Watchlist", style: bottomNavigationBarItemStyle),
    ));

    bottomBarItems.add(BottomNavigationBarItem(
      icon: Icon(Icons.local_offer, color: Colors.black),
      title: Text("Deals", style: bottomNavigationBarItemStyle),
    ));

    bottomBarItems.add(BottomNavigationBarItem(
      icon: Icon(Icons.notifications, color: Colors.black),
      title: Text("Notifications", style: bottomNavigationBarItemStyle),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: BottomNavigationBar(
          currentIndex: 2,
          items: bottomBarItems, type: BottomNavigationBarType.shifting),
    );
  }
}
