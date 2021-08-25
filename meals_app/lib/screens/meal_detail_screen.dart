import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/meal-detal-screen";
  final List<Meal> filteredMeals;

  MealDetailScreen(this.filteredMeals);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainter(Widget child) {
    return Container(
        height: 250,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context).settings.arguments as String;
    final Meal selectedMeal =
        filteredMeals.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.contain),
            ),
            buildSectionTitle(context, "Ingridients"),
            buildContainter(ListView.builder(
              itemBuilder: (context, index) => Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedMeal.ingredients[index])),
              ),
              itemCount: selectedMeal.ingredients.length,
            )),
            buildSectionTitle(context, "Steps"),
            buildContainter(ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text("#${index + 1}"),
                    ),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () => Navigator.of(context).pop(mealId),
      ),
    );
  }
}
