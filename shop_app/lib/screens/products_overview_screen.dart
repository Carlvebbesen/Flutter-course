import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/badge.dart';
import 'package:flutter_complete_guide/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum showProducts { All, Favorites }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: [
          PopupMenuButton(
            onSelected: (showProducts selectedValue) => setState(() {
              if (selectedValue == showProducts.All) {
                _showFavorites = false;
              } else {
                _showFavorites = true;
              }
            }),
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Show All"),
                value: showProducts.All,
              ),
              PopupMenuItem(
                child: Text("Only Favorites"),
                value: showProducts.Favorites,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, child) =>
                Badge(child: child, value: cartData.itemCount.toString()),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavorites),
    );
  }
}
