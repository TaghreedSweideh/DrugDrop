import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/drug_card.dart';
import '../providers/drugs_provider.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isLoading = false;
  bool _isInit = false;

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      setState(() => _isLoading = true);
      await Provider.of<DrugsProvider>(context).fetchFavorites();
      setState(() => _isLoading = false);
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final favorites =
        Provider.of<DrugsProvider>(context, listen: false).favoriteItems;
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : favorites.isEmpty
            ? Center(
                child: Text(
                  'Add new drugs to your favorites.',
                  style: TextStyle(
                    color: primary,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : GridView.builder(
                itemBuilder: (_, index) => DrugCard(
                  favorites[index].id,
                  favorites[index].tradeName,
                  favorites[index].price,
                  favorites[index].quantity,
                  favorites[index].imageUrl,
                  favorites[index].isFavorite,
                ),
                itemCount: favorites.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              );
  }
}
