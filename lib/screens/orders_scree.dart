import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/views/app_drawer.dart';
import 'package:shop_app/screens/views/order_item.dart' as oi;

class OrdersScree extends StatefulWidget {
  const OrdersScree({Key? key}) : super(key: key);

  @override
  State<OrdersScree> createState() => _OrdersScreeState();
}

class _OrdersScreeState extends State<OrdersScree> {
  bool _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).getchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orders.orders.length,
              itemBuilder: (context, index) {
                return oi.OrderItem(order: orders.orders[index]);
              },
            ),
    );
  }
}
