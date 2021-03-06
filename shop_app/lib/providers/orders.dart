import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final String authtoken;
  final String userId;
  List<OrderItem> _orders = [];
  Orders(this.authtoken, this._orders, this.userId);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.https("fluttercourse-4d5af-default-rtdb.firebaseio.com",
        "/orders/$userId.json?auth=$authtoken");
    final response = await http.get(url);
    List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, data) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: data["amount"],
          products: (data["products"] as List<dynamic>)
              .map((e) => CartItem(
                  id: e["id"],
                  title: e["title"],
                  quantity: e["quantity"],
                  price: e["price"]))
              .toList(),
          dateTime: DateTime.parse(data["dateTime"])));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timestamp = DateTime.now();
    final url = Uri.https("fluttercourse-4d5af-default-rtdb.firebaseio.com",
        "/orders/$userId.json?auth=$authtoken");
    final response = await http.post(url,
        body: json.encode({
          "amount": total,
          "dateTime": timestamp.toIso8601String(),
          "products": cartProducts
              .map((e) => {
                    "id": e.id,
                    "title": e.title,
                    "quantity": e.quantity,
                    "price": e.price
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)["name"],
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
