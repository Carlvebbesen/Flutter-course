import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'package:flutter_complete_guide/screens/categories_screen.dart';
import 'package:flutter_complete_guide/screens/favorite_screen.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favorites;

  TabsScreen(this.favorites);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> tabs;
  int _selectedTab = 0;

  @override
  void initState() {
    tabs = [
      {"page": CategoriesScreen(), "title": "Categories"},
      {"page": FavoriteScreen(widget.favorites), "title": "Your Favorite"}
    ];
    super.initState();
  }

  void _selectTab(int index) => setState(() => _selectedTab = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            tabs[_selectedTab]["title"],
          ),
        ),
        drawer: MainDrawer(),
        body: tabs[_selectedTab]["page"],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectTab,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedTab,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text("Categories")),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), title: Text("Favorites"))
          ],
        ));
  }
}
