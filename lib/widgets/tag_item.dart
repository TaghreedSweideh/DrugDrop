import 'package:drug_drop/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'drug_item.dart';
import '../screens/see_all_screen.dart';
import '../providers/drug_data.dart';
import '../providers/tags_provider.dart';

class TagItem extends StatefulWidget {
  static const routeName = '/tag-item';

  final int catId;
  final int tagId;
  final String tagTitle;
  final List<Drug> drugs;

  TagItem(this.tagId, this.tagTitle, this.drugs, this.catId);

  @override
  State<TagItem> createState() => _TagItemState();
}

class _TagItemState extends State<TagItem> {
  bool _isInit = false;
  bool _isLoading = false;

  final List<String> imagePath = [
    'assets/images/Medicine.svg',
    'assets/images/spoon and syrup.svg',
    'assets/images/Syringe.svg',
    'assets/images/eye-dropper.svg',
    'assets/images/spray-can.svg',
    'assets/images/cream.svg',
    'assets/images/eye-dropper.svg',
  ];

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      setState(() => _isLoading = true);
      // await Provider.of<TagsProvider>(context)
      //     .fetchTagDrugs(widget.tagId, widget.catId);
      setState(() => _isLoading = false);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    var media = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: SvgPicture.asset(imagePath[widget.tagId]),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      widget.tagTitle,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: theme.primary,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(SeeAllScreen.routeName, arguments: {
                      'tagId': widget.tagId,
                      'catId': widget.catId,
                    });
                  },
                  child: Text(LocaleKeys.see_all.tr()),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => DrugItem(
                widget.drugs[i].id,
                widget.drugs[i].imageUrl,
                widget.drugs[i].price,
                widget.drugs[i].quantity,
                widget.drugs[i].tradeName,
                widget.drugs[i].isFavorite,
              ),
              itemCount: widget.drugs.length,
            ),
          ),
        ],
      ),
    );
  }
}
