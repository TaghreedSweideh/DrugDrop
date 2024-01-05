import 'package:flutter/material.dart';

class NotificationItem extends StatefulWidget {
  String title;
  String message;
  String date;

  NotificationItem(this.title, this.message, this.date);

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: theme.colorScheme.background.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(
          widget.title,
          style: TextStyle(color: theme.colorScheme.primary),
        ),
        subtitle: Text(' ${widget.message}'),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.background.withOpacity(0.6),
          child: Icon(
            Icons.notifications_active,
            color: theme.colorScheme.primary,
          ),
        ),
        //trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: theme.scaffoldBackgroundColor,
      ),
    );
  }
}
