import 'dart:math';

import 'package:flutter/material.dart';

import '../icons/my_flutter_app_icons.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DrugDrop',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontFamily: 'PollerOne',
              ),
            ),
            const SizedBox(width: 5),
            Transform.rotate(
              angle: 30 * pi / 180,
              child: const Icon(
                MyFlutterApp.pills,
                color: Color.fromRGBO(68, 191, 219, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
