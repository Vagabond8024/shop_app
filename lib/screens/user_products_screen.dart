import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/views/app_drawer.dart';
import 'package:shop_app/screens/views/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your products'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/edit-product');
                },
                icon: const Icon(Icons.add))
          ],
        ),
        drawer: const AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () {
            return _refreshProduct(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: productsData.items.length,
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    UserProductItem(
                      id: productsData.items[index].id,
                      title: productsData.items[index].title,
                      imageUrl: productsData.items[index].imageUrl,
                    ),
                    const Divider()
                  ],
                );
              },
            ),
          ),
        ));
  }
}
