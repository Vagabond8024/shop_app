import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/card.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final String? token;
  List<OrderItem> _orders = [];

  Orders(this.token, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> getchAndSetOrders() async {
    final url = Uri.https(
        'dummy-shop-app-e597c-default-rtdb.europe-west1.firebasedatabase.app',
        '/orders.json',
        {'auth': token});
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extacetedData = json.decode(response.body) as Map<String, dynamic>;
    if (extacetedData == null) {
      return;
    }
    extacetedData.forEach((key, value) {
      loadedOrders.add(OrderItem(
          id: key,
          amount: value['amount'],
          products: (value['products'] as List<dynamic>)
              .map((e) => CartItem(
                  id: e['id'],
                  title: e['title'],
                  quantity: e['quantity'],
                  price: e['price']))
              .toList(),
          dateTime: DateTime.parse(value['dateTime'])));
    });
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https(
        'dummy-shop-app-e597c-default-rtdb.europe-west1.firebasedatabase.app',
        '/orders.json',
        {'auth': token});
    final timesteamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timesteamp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price
                  })
              .toList()
        }));
    _orders.insert(
      0,
      OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: timesteamp),
    );
    notifyListeners();
  }
}
