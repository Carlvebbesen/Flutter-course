import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart' show Orders;
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static final routeName = "/orders";
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        drawer: AppDrawer(),
        body: ListView.builder(
          itemBuilder: (context, index) => OrderItem(
            orderData.orders[index],
          ),
          itemCount: orderData.orders.length,
        ));
  }
}
