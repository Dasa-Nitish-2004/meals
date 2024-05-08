import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    // TODO: implement createState
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> favorites = [];

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void modifyFavContent(Meal meal, bool cnd) {
    // ture add, false remove
    if (cnd) {
      favorites.add(meal);
      _showMessage("added to favorite");
    } else {
      favorites.remove(meal);
      _showMessage("removed from favorite");
    }
    setState(() {});
  }

  void _showMessage(String mssg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mssg)));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget activePage = CategoriesScreen(modifyFav: modifyFavContent);
    String activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favorites,
        addRemoveFav: modifyFavContent,
      );
      activePageTitle = "Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: selectPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
