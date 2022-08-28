import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/views/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your products'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  UserProductItem(
                    title: productsData.items[index].title,
                    imageUrl: productsData.items[index].imageUrl,
                  ),
                  Divider()
                ],
              );
            },
          ),
        ));
  }
}
