import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order_item_model.dart' as ord;
import '../providers/orders_provider.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItemModel orderItem;

  const OrderItem(this.orderItem);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final width = MediaQuery.of(context).size.width;
    final order = Provider.of<OrdersProvider>(context, listen: false);
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Total: ${widget.orderItem.total}   S.P',
              style: TextStyle(
                color: primary,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Date: ${widget.orderItem.dateTime}',
              style: TextStyle(
                color: primary,
              ),
            ),
            trailing: _isLoading
                ? const CircularProgressIndicator(
                  strokeCap: StrokeCap.round,
                )
                : IconButton(
                    icon: Icon(
                      _expanded ? Icons.expand_less : Icons.expand_more,
                      color: primary,
                    ),
                    onPressed: () async {
                      setState(() => _expanded = !_expanded);
                      setState(() => _isLoading = true);
                      await order.fetchOrderDrugs(widget.orderItem.id);
                      setState(() => _isLoading = false);
                    },
                  ),
          ),
          if (_expanded)
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(10),
              height: min(
                  widget.orderItem.products.length *
                      MediaQuery.of(context).size.height *
                      0.35,
                  MediaQuery.of(context).size.height * 0.35),
              child: ListView(
                children: widget.orderItem.products
                    .map(
                      (prod) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width * 0.4,
                                  child: Text(
                                    prod.title,
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Price: ${prod.price}  S.P',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 13),
                                    Text(
                                      'x${prod.quantity}',
                                      style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: primary,
                            indent: 20,
                            endIndent: 20,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
