import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/tags_screen.dart';
import '../providers/tags_provider.dart';

class CategroyItem extends StatelessWidget {
  final int id;
  final String title;

  CategroyItem(this.id, this.title);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(TagsScreen.routeName, arguments: id),
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
          left: 5,
          right: 5,
        ),
        padding: const EdgeInsets.only(
          bottom: 5,
          left: 8,
          right: 8,
        ),
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
          color: colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorScheme.primary,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Icon(
              Icons.local_hospital,
              color: colorScheme.primary,
              size: MediaQuery.of(context).size.width * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Text(
              title,
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
