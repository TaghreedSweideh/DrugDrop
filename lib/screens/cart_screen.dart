import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import 'notifications_screen.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final cart = Provider.of<CartProvider>(context, listen: false).items;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final total = Provider.of<CartProvider>(context, listen: false).total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamed(NotificationsScreen.routeName),
              icon: const Icon(
                Icons.notifications,
              ),
            ),
          ),
        ],
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(
                'There is nothing in your cart.',
                style: TextStyle(
                  color: primary,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : SlideInUp(
              duration: const Duration(milliseconds: 800),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(
                      children: [
                        ListView.builder(
                          itemBuilder: (ctx, i) => CartItem(
                            cart[i].productId,
                            cart[i].title,
                            cart[i].price,
                            cart[i].quantity,
                          ),
                          itemCount: cart.length,
                        ),
                        Positioned(
                          right: width * 0.03,
                          bottom: height * 0.09,
                          child: IconButton.filledTonal(
                            onPressed: () async {
                              setState(() => _isLoading = true);
                              await cartProvider.placeOrder();
                              setState(() => _isLoading = false);
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: primary,
                            ),
                            icon: Icon(
                              Icons.local_shipping,
                              size: width * 0.08,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
      bottomSheet: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
        child: BottomAppBar(
          color: primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Total: ',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              Text(
                '$total  (S.P)',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: Container(
      //   transform: Matrix4.translationValues(0, -40, 0),
      //   child: _isLoading
      //       ? const CircularProgressIndicator(strokeCap: StrokeCap.round)
      //       : FloatingActionButton(
      //           onPressed: () async {
      //             setState(() => _isLoading = true);
      //             await cartProvider.placeOrder();
      //             setState(() => _isLoading = false);
      //           },
      //           backgroundColor: Theme.of(context).colorScheme.primary,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(50),
      //           ),
      //           child: Icon(
      //             Icons.local_shipping,
      //             color: Theme.of(context).colorScheme.secondary,
      //           ),
      //         ),
      // ),
    );
  }
}
