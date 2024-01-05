import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
import 'notifications_screen.dart';
import '../providers/tags_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/drug_card.dart';

class SeeAllScreen extends StatefulWidget {
  static const routeName = '/see-all';

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  bool _isInit = false;
  bool _isLoading = false;
  late final args = ModalRoute.of(context)?.settings.arguments as Map<String, int>;
  late final tagId = args['tagId'];
  late final catId = args['catId'];

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      setState(() => _isLoading = true);
      await Provider.of<TagsProvider>(context).fetchTagDrugs(tagId!, catId!);
      setState(() => _isLoading = false);
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tag =
        Provider.of<TagsProvider>(context).findTagById(tagId.toString());
    final drugs = Provider.of<TagsProvider>(context).drugs;

    return Scaffold(
      appBar: AppBar(
        title: Text(tag.name),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              backgroundColor: Colors.transparent,
              offset: const Offset(-2, 4),
              label: Text(cart.items.length.toString()),
              child: ch,
            ),
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemBuilder: (_, index) => DrugCard(
                drugs[index].id,
                drugs[index].tradeName,
                drugs[index].price,
                drugs[index].quantity,
                drugs[index].imageUrl,
                drugs[index].isFavorite,
              ),
              itemCount: drugs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
    );
  }
}
