import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';

class CategoriesMealsScreen extends StatefulWidget {
  static const routeName = "/categories-meal";

  final List<Meal> filteredMeals;

  CategoriesMealsScreen(this.filteredMeals);

  @override
  _CategoriesMealsScreenState createState() => _CategoriesMealsScreenState();
}

class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  String categoryTitle;
  List<Meal> filteredMeals;
  var _loadedInitData = false;
  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs["title"];
      final String routeId = routeArgs["id"];

      filteredMeals = widget.filteredMeals
          .where((element) => element.categories.contains(routeId))
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    void _removeMeal(String mealId) {
      print(mealId);
      setState(() {
        filteredMeals.removeWhere((element) => element.id == mealId);
      });
    }

    return Scaffold(
        appBar: AppBar(
            title: Text(
          categoryTitle,
        )),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
                removeItem: _removeMeal,
                title: filteredMeals[index].title,
                id: filteredMeals[index].id,
                imageUrl: filteredMeals[index].imageUrl,
                duration: filteredMeals[index].duration,
                complexity: filteredMeals[index].complexity,
                affordability: filteredMeals[index].affordability);
          },
          itemCount: filteredMeals.length,
        ));
  }
}
