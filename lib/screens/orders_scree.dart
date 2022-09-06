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
  Future? _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).getchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: _ordersFuture,
          // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.error != null) {
                return const Center(
                  child: Text('Error occured'),
                );
              } else {
                return Consumer<Orders>(
                    builder: (context, value, child) => ListView.builder(
                          itemCount: value.orders.length,
                          itemBuilder: (context, index) {
                            return oi.OrderItem(order: value.orders[index]);
                          },
                        ));
              }
            }
          },
        ));
  }
}
