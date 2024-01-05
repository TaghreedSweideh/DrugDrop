import 'dart:convert';

import 'package:drug_drop/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'categories_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'search-screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'notifications_screen.dart';
import '../providers/cart_provider.dart';
import '../providers/notification_provider.dart';

class HomeBottomBar extends StatefulWidget {
  static const routeName = '/home-bottom-bar';

  int userId;

  HomeBottomBar(this.userId);

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  String socketId = '';
  String channel_name = '';
  var channel;
  String privateChannelName = '';
  String authBroadCast = '';

  @override
  void initState() {
    channel = WebSocketChannel.connect(
        Uri.parse('ws://192.168.43.239:6001/app/1029384756'));
    // TODO: implement initState
    channel.sink.add(jsonEncode({
      "event": "pusher:subscribe",
      "data": {"channel": "notifications", "auth": ""}
    }));
    channel_name = 'private-notifications';
    channel.stream.listen((message) {
      Map getData = jsonDecode(message);
      if (getData['event'] == 'pusher:connection_established') {
        socketId = jsonDecode(getData['data'])['socket_id'];
        Provider.of<NotificationProvider>(context, listen: false).broadcastAuth(
          socketId,
          channel_name,
          channel,
        );
      }
      if (getData['event'] == 'New Drug in Storage'){
        setState(() => Provider.of<NotificationProvider>(context, listen: false).getNotification());
      }
      print(getData);
    });

    super.initState();
  }

  final List<Map<String, dynamic>> _screens = [
    {
      'title': LocaleKeys.orders.tr(),
      'screen': OrdersScreen(),
    },
    {
      'title': LocaleKeys.search.tr(),
      'screen': SearchScreen(),
    },
    {
      'title': LocaleKeys.home.tr(),
      'screen': CategoriesScreen(),
    },
    {
      'title': LocaleKeys.favorites.tr(),
      'screen': FavoritesScreen(),
    },
    {
      'title': LocaleKeys.profile.tr(),
      'screen': ProfileScreen(),
    },
  ];
  var _selectedIndex = 2;
  var _previousIndex = 0;

  void _selectScreen(int index) => setState(() {
        _previousIndex = _selectedIndex;
        _selectedIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(_screens[_selectedIndex]['title']),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              backgroundColor: Colors.transparent,
              // alignment: Alignment.bottomRight,
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
              onPressed: () => Navigator.of(context)
                  .pushNamed(NotificationsScreen.routeName),
              icon: const Icon(
                Icons.notifications,
              ),
            ),
          ),
        ],
      ),
      body: _previousIndex > _selectedIndex
          ? FadeInLeft(
              duration: const Duration(milliseconds: 600),
              child: _screens[_selectedIndex]['screen'],
            )
          : FadeInRight(
              duration: const Duration(milliseconds: 600),
              child: _screens[_selectedIndex]['screen'],
            ),
      bottomNavigationBar: CurvedNavigationBar(
        height: MediaQuery.of(context).size.height * 0.08,
        color: colorScheme.primary,
        backgroundColor: Colors.transparent,
        onTap: _selectScreen,
        index: _selectedIndex,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        items: const [
          Icon(
            Icons.local_shipping,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
            size: 25,
          ),
        ],
      ),
    );
  }
}
