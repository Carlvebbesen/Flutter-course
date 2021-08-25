import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  List<Meal> favorites;

  FavoriteScreen(this.favorites);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("My favorites"),
    );
  }
}
''