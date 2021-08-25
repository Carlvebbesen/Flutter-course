import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/dummy_data.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'package:flutter_complete_guide/screens/categories_meals_screen.dart';
import 'package:flutter_complete_guide/screens/filters_screen.dart';
import 'package:flutter_complete_guide/screens/meal_detail_screen.dart';
import 'package:flutter_complete_guide/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> filteredMeals = DUMMY_MEALS;
  List<Meal> favorites = [];

  Map<String, bool> filters = {
    "glutenFree": false,
    "lactoseFree": false,
    "vegan": false,
    "vegetarian": false,
  };
  void setFilter(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;
      filteredMeals = DUMMY_MEALS
          .where((element) =>
              (element.isVegan || !filterData["vegan"]) &&
              (element.isGlutenFree || !filterData["glutenFree"]) &&
              (element.isLactoseFree || !filterData["lactoseFree"]) &&
              (element.isVegetarian || !filterData["vegetarian"]))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: "Raleway",
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                fontFamily: "RobotoCondensed",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),
      routes: {
        "/": (context) => TabsScreen(favorites),
        FiltersScreen.routeName: (context) => FiltersScreen(filters, setFilter),
        CategoriesMealsScreen.routeName: (context) =>
            CategoriesMealsScreen(filteredMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(filteredMeals),
      },
    );
  }
}
