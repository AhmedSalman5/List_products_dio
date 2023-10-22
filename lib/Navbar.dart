import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'screens/CategoriesScreen.dart';
import 'screens/FavoritesScreen.dart';
import 'screens/ProductsScreen.dart';
import 'screens/SettingScreen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];

  List<String> titleList = [
    'Products',
    'Categories',
    'Favorites',
    'Setting',
  ];

  int initialActiveIndex = 0;

  void changeItem(int value) {
    //print(value);
    setState(() {
      initialActiveIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundImage: AssetImage('assets/gg.jpg')),
        ),
        title: Text(
          titleList[initialActiveIndex],
          style: const TextStyle(color: Color.fromARGB(255, 36, 185, 235)),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[50],
      ),
      body: bottomScreens[initialActiveIndex],
      bottomNavigationBar: ConvexAppBar.badge(
        const {2: '15'},
        badgeMargin: const EdgeInsets.only(bottom: 30, right: 50),
        items: const [
          TabItem(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 8, 2, 25),
              ),
              title: 'Home'),
          TabItem(
              icon: Icon(
                Icons.production_quantity_limits,
                color: Color.fromARGB(255, 8, 2, 25),
              ),
              title: 'Categories'),
          TabItem(
              icon: Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 8, 2, 25),
              ),
              title: 'Favorites'),
          TabItem(
              icon: Icon(
                Icons.settings,
                color: Color.fromARGB(255, 8, 2, 25),
              ),
              title: 'Settings'),
        ],
        initialActiveIndex: initialActiveIndex,
        onTap: changeItem,
        backgroundColor: Color.fromARGB(255, 36, 185, 235),
        activeColor: Colors.white,
      ),
    );
  }
}
