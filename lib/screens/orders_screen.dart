import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import '../providers/orders_provider.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders-screen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;
  bool _done = false;

  @override
  void didChangeDependencies() async {
    setState(() => _isLoading = true);
    await Provider.of<OrdersProvider>(context, listen: false)
        .fetchUnDoneOrders();
    setState(() => _isLoading = false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrdersProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: width * 0.3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_done ? secondary : primary,
                  ),
                  onPressed: () async {
                    setState(() => _done = true);
                    setState(() => _isLoading = true);
                    await Provider.of<OrdersProvider>(context, listen: false)
                        .fetchDoneOrders();
                    setState(() => _isLoading = false);
                  },
                  child: Text(
                    'done',
                    style: TextStyle(
                      color: _done ? secondary : primary,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _done ? secondary : primary,
                  ),
                  onPressed: () async {
                    setState(() => _done = false);
                    setState(() => _isLoading = true);
                    await Provider.of<OrdersProvider>(context, listen: false)
                        .fetchUnDoneOrders();
                    setState(() => _isLoading = false);
                  },
                  child: Text(
                    'unDone',
                    style: TextStyle(
                      color: !_done ? secondary : primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 9,
          child: orderProvider.orders.isEmpty
              ? const Center(
                  child: Text('You have no orders'),
                )
              : _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (ctx, i) =>
                          OrderItem(orderProvider.orders[i]),
                      itemCount: orderProvider.orders.length,
                    ),
        ),
      ],
    );
  }
}
