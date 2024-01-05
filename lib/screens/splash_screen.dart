import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';

import 'log_in_screen.dart';
import '../icons/my_flutter_app_icons.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => LogInScreen(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeIn(
        duration: const Duration(milliseconds: 1000),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'DrugDrop',
                style: TextStyle(
                  fontFamily: 'PollerOne',
                  fontSize: 30,
                  color: Color.fromRGBO(255, 252, 252, 1),
                ),
              ),
              const SizedBox(width: 3),
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
      ),
    );
  }
}
