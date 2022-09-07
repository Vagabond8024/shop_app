import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/card.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_scree.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider(create: (BuildContext context) {
          return ProductsProvider();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return Orders();
        }),
      ],
      child: Consumer<Auth>(builder: (context, value, child) => MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
        ),
        home: value.isAuth ? ProductsOverviewScreen() : AuthScreen(),
        routes: {
          '/product-details': (context) => const ProductDetailScreen(),
          '/cart': (context) => const CartScreen(),
          '/orders': (context) => const OrdersScree(),
          '/user-products': (context) => const UserProductsScreen(),
          '/edit-product': (context) => const EditProductScreen(),
          '/auth': (context) => const AuthScreen()
        },
      ),)
    );
  }
}
