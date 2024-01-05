import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  String title;
  String subtitle;
  IconData iconData;
  ProfileItem(this.title, this.subtitle, this.iconData);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: theme.colorScheme.background.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: theme.colorScheme.primary),
        ),
        subtitle: Text(subtitle),
        leading: Icon(
          iconData,
          color: theme.colorScheme.primary,
        ),
        //trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: theme.scaffoldBackgroundColor,
      ),
    );
  }
}
