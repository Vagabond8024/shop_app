import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  const ProductItem({
    Key? key,
    // required this.id, required this.title, required this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
        builder: (BuildContext context, product, Widget? child) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: GridTile(
          footer: GridTileBar(
            leading: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavorites();
              },
            ),
            trailing: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: const Icon(
                Icons.shopping_bag,
              ),
              onPressed: () {},
            ),
            backgroundColor: Colors.black87,
            title: Text(
              product.imageUrl,
              textAlign: TextAlign.center,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/product-details', arguments: product.id);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    });
  }
}
