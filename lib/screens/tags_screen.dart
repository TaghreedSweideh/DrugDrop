import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
import 'notifications_screen.dart';
import '../widgets/tag_item.dart';
import '../providers/tags_provider.dart';
import '../providers/categories_provider.dart';
import '../providers/cart_provider.dart';

class TagsScreen extends StatefulWidget {
  static const routeName = '/tags';

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  bool _isLoading = false;
  late final catId = ModalRoute.of(context)?.settings.arguments as int;

  @override
  void didChangeDependencies() async {
    setState(() => _isLoading = true);
    await Provider.of<TagsProvider>(context, listen: false)
        .fetchAndSetTags(catId);
    setState(() => _isLoading = false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final catData = Provider.of<CategoriesProvider>(context).findById(catId);
    final tags = Provider.of<TagsProvider>(context, listen: false).tags;
    Locale currentLocale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(currentLocale.languageCode == 'en'
            ? catData.en_name
            : catData.ar_name),
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
          : ListView.builder(
              itemBuilder: (_, index) => tags[index].drugs.isNotEmpty ? Column(
                children: [
                  TagItem(tags[index].id, tags[index].name, tags[index].drugs, catId),
                  Divider(
                    color: Theme.of(context).colorScheme.primary,
                    indent: 40,
                    endIndent: 40,
                  ),
                ],
              ) : Container(),
              itemCount: tags.length,
            ),
    );
  }
}
