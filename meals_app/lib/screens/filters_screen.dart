import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Function setFilter;
  final Map<String, bool> currentFilter;
  FiltersScreen(this.currentFilter, this.setFilter);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegan = false;
  var _vegetarian = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilter["glutenFree"];
    _lactoseFree = widget.currentFilter["lactoseFree"];
    _vegan = widget.currentFilter["vegan"];
    _vegetarian = widget.currentFilter["vegetarian"];
  }

  Widget buildSwitchFilter(
      String title, String subTitle, Function onChange, bool value) {
    return SwitchListTile(
        title: Text(title),
        value: value,
        subtitle: Text(subTitle),
        onChanged: (newValue) => onChange(newValue));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Favorite"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: () => widget.setFilter({
              "glutenFree": _glutenFree,
              "lactoseFree": _lactoseFree,
              "vegan": _vegan,
              "vegetarian": _vegetarian,
            }),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Filter your meals",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchFilter(
                  "Gluten Free",
                  "Only show gluten free meals.",
                  (newValue) => setState(() => _glutenFree = newValue),
                  _glutenFree),
              buildSwitchFilter(
                  "Lactose Free",
                  "Only show lactose free meals.",
                  (newValue) => setState(() => _lactoseFree = newValue),
                  _lactoseFree),
              buildSwitchFilter("Vegan Free", "Only show Vegan free meals.",
                  (newValue) => setState(() => _vegan = newValue), _vegan),
              buildSwitchFilter(
                  "Vegetarian Free",
                  "Only show Vegetarian free meals.",
                  (newValue) => setState(() => _vegetarian = newValue),
                  _vegetarian),
            ],
          ))
        ],
      ),
    );
  }
}
