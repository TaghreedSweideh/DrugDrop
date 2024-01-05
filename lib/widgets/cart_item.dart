import 'package:drug_drop/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final int productId;
  final String title;
  final int price;
  final int quantity;

  CartItem(
    this.productId,
    this.title,
    this.price,
    this.quantity,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Dismissible(
      key: ValueKey(productId),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: theme.scaffoldBackgroundColor,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.red,
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: theme.colorScheme.secondary,
            icon: Icon(
              Icons.delete,
              color: theme.colorScheme.error,
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            title:  Text('${LocaleKeys.are_you_sure.tr()}?'),
            content:  Text(LocaleKeys.this_will_delete_from_cart.tr()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child:  Text(LocaleKeys.no.tr()),
              ),
              TextButton(
                onPressed: () {

                  Navigator.of(ctx).pop(true);
                },
                child:  Text(LocaleKeys.yes.tr()),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) => Provider.of<CartProvider>(
        context,
        listen: false,
      ).removeSingleItem(productId),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        shadowColor: theme.colorScheme.secondary,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              radius: 25,
              child: const FittedBox(
                child: Text('Drug Image'),
              ),
            ),
            title: Text(title),
            subtitle: Text('${LocaleKeys.price.tr()}: $price (${LocaleKeys.sp.tr()
            })'),
            trailing: Text(
              'x $quantity',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
