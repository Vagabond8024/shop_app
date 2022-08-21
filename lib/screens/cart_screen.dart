import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium
                              ?.color),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
