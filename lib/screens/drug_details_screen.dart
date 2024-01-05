import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../providers/drugs_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/tags_provider.dart';

class DrugDetailsScreen extends StatefulWidget {
  static const routeName = '/drug-details';

  @override
  State<DrugDetailsScreen> createState() => _DrugDetailsScreenState();
}

class _DrugDetailsScreenState extends State<DrugDetailsScreen> {
  late final drugId = ModalRoute.of(context)!.settings.arguments as int;
  bool isPressed = false;
  bool _isInit = false;
  bool _isLoading = false;

//show dialog for quantity
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.background,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //this container for adding description
  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      setState(() => _isLoading = true);
      await Provider.of<DrugsProvider>(context).getDrugInfo(drugId);
      setState(() => _isLoading = false);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context).colorScheme;
    final scaffold = ScaffoldMessenger.of(context);
    final loadedDrug = Provider.of<DrugsProvider>(context).drugInfo;
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedDrug.tradeName),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 300,
                  child: loadedDrug.imageUrl.isEmpty ||
                          loadedDrug.imageUrl == 'null'
                      ? Image.asset('assets/images/Login.png')
                      : Image.network(
                          'http://$host/${loadedDrug.imageUrl}',
                          fit: BoxFit.cover,
                        ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          loadedDrug.scientificName,
                          style: TextStyle(
                              color: theme.primary,
                              fontFamily: 'PollerOne',
                              fontSize: 16),
                        ),
                        Text(
                          '${loadedDrug.price} s.p',
                          style: TextStyle(
                              color: theme.primary,
                              fontFamily: 'PollerOne',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          loadedDrug.company,
                          style: TextStyle(
                            color: theme.primary,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${loadedDrug.quantity}',
                          style: TextStyle(
                            color: theme.primary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    buildSectionTitle(context, 'Drug Description'),
                    buildContainer(
                      SingleChildScrollView(
                        child: Card(
                          color: Theme.of(context).colorScheme.secondary,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 5,
                            ),
                            child: Text(
                              loadedDrug.description,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: theme.primary,
            onPressed: () {
              loadedDrug.isFavorite
                  ? Provider.of<DrugsProvider>(context)
                      .removeFromFavorites(loadedDrug.id)
                  : Provider.of<DrugsProvider>(context)
                      .addToFavorites(loadedDrug.id);
              setState(() => loadedDrug.isFavorite = !loadedDrug.isFavorite);
            },
            heroTag: null,
            child: Icon(
              loadedDrug.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.pinkAccent,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: theme.primary,
            onPressed: () {
              onPressed:
              () => showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      loadedDrug.id,
                      loadedDrug.tradeName,
                      loadedDrug.price,
                      loadedDrug.quantity,
                    ),
                  );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Added item to cart!',
                  ),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(loadedDrug.id);
                    },
                  ),
                ),
              );
            },
            heroTag: null,
            child: Icon(
              Icons.shopping_cart_rounded,
              color: theme.background,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
  int _selectedQuantity = 0;

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
                const SnackBar(
                  content: Text(
                    'Added item to cart!',
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Add to cart'),
          )
        ],
      ),
    );
  }
}
