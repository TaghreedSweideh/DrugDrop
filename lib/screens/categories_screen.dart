import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import '../providers/categories_provider.dart';
import '/widgets/category_item.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() => _isLoading = true);
      await Provider.of<CategoriesProvider>(context)
          .fetchCategories()
          .timeout(const Duration(seconds: 5));
      setState(() => _isLoading = false);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    final categoryData =
        Provider.of<CategoriesProvider>(context, listen: false).categories;
    var colorScheme = Theme.of(context).colorScheme;
    return FadeInRight(
      duration: const Duration(milliseconds: 400),
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : categoryData.isEmpty
              ? Center(
                  child: Text(
                    'No categories to see.',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    itemCount: categoryData.length,
                    itemBuilder: (_, i) => Column(
                      children: [
                        CategroyItem(
                          categoryData[i].id,
                          currentLocale.languageCode == 'en'
                              ? categoryData[i].en_name
                              : categoryData[i].ar_name,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
