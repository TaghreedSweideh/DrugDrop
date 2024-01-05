import 'dart:convert';

import '../providers/notification_provider.dart';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '/main.dart';

import '../widgets/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications';

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<NotificationProvider>(context)
          .getNotification()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final notificationData =
        Provider.of<NotificationProvider>(context, listen: false).notifications;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(LocaleKeys.notifications.tr()),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: notificationData.length,
              itemBuilder: (_, i) => Column(
                children: [
                  NotificationItem(
                    notificationData[i].title,
                    notificationData[i].message,
                    notificationData[i].date,
                  ),
                ],
              ),
            ),
      // body: StreamBuilder(
      //   builder: (context, snapshot) =>
      //       NotificationItem(snapshot.hasData ? '${snapshot.data}' : ''),
      //   stream: null,
      // ),
    );
  }
}
