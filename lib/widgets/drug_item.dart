import 'package:drug_drop/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/drug_details_screen.dart';
import '../providers/drugs_provider.dart';
import '../providers/cart_provider.dart';

int _selectedQuantity = 0;

class DrugItem extends StatefulWidget {
  final int id;
  final String name;
  final int price;
  final int quantity;
  final String imageUrl;
  bool isFavorite;

  DrugItem(this.id, this.imageUrl, this.price, this.quantity, this.name,
      this.isFavorite);

  @override
  State<DrugItem> createState() => _DrugItemState();
}

class _DrugItemState extends State<DrugItem> {
  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).colorScheme.primary;
    var secondary = Theme.of(context).colorScheme.secondary;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final scaffold = ScaffoldMessenger.of(context);
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(DrugDetailsScreen.routeName, arguments: widget.id),
      child: Container(
        width: width * 0.35,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(5, 5),
              blurRadius: 15,
              spreadRadius: -2,
            ),
          ],
        ),
        child: GridTile(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  widget.isFavorite
                      ? Provider.of<DrugsProvider>(context, listen: false)
                          .removeFromFavorites(widget.id)
                      : Provider.of<DrugsProvider>(context, listen: false)
                          .addToFavorites(widget.id);
                  setState(() => widget.isFavorite = !widget.isFavorite);
                },
                icon: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: width * 0.06,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      widget.id,
                      widget.name,
                      widget.price,
                      widget.quantity,
                    ),
                  );
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: primary,
                  size: width * 0.06,
                ),
              ),
            ],
          ),
          child: Column(
            children: [
              Flexible(
                flex: 6,
                child: Image.asset(
                  'assets/images/forgotPassword.png',
                  color: Colors.white.withOpacity(0.6),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 6,
                    top: 2,
                  ),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.15,
                        child: Text(
                          widget.name,
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: width * 0.02,
                            color: secondary,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Text(
                        '${widget.price} S.P',
                        style: TextStyle(
                          fontSize: width * 0.02,
                          color: secondary,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Dialog extends StatefulWidget {
  final int id;
  final String title;
  final int price;
  final int quantity;

  Dialog(this.id, this.title, this.price, this.quantity);

  @override
  State<Dialog> createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return SizedBox(
      child: AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
          child: Text(
            'Indicate Your Quantity',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (_selectedQuantity > 0) setState(() => _selectedQuantity--);
              },
              icon: Icon(
                Icons.remove_circle_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text('$_selectedQuantity'),
            IconButton(
              onPressed: () {
                if (_selectedQuantity < widget.quantity)
                  setState(() => _selectedQuantity++);
                print(_selectedQuantity);
              },
              icon: Icon(
                Icons.add_circle_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              cart.addToCart(
                  widget.id, widget.title, widget.price, _selectedQuantity);
              _selectedQuantity = 0;
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                  content: Text(
                    LocaleKeys.added_item_to_cart.tr(),
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text(LocaleKeys.add_to_cart.tr()),
          )
        ],
      ),
    );
  }
}
