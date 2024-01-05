import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animate_do/animate_do.dart';

import 'sign_up_screen.dart';

class IntroScreens extends StatefulWidget {
  static const routeName = '/intro';

  @override
  State<IntroScreens> createState() => _IntroScreensState();
}

class _IntroScreensState extends State<IntroScreens> {
  final _controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FadeIn(
        duration: const Duration(milliseconds: 2000),
        child: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            controller: _controller,
            children: [
              Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: 140, bottom: 33),
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset(
                      'assets/images/Online Groceries-cuate.png',
                      width: 350,
                      height: 350,
                    ),
                  ),
                ),
                Text(
                  'Order Medicine Online',
                  style: TextStyle(
                    fontFamily: 'PollerOne',
                    fontSize: width * 0.05,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'this is description.this is description.this is \ndescription.this is description.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: width * 0.04,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              ]),
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100, bottom: 30),
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.asset(
                        'assets/images/Medicine-rafiki.png',
                        width: 400,
                        height: 400,
                      ),
                    ),
                  ),
                  Text(
                    'Easy Order Fast Delivery',
                    style: TextStyle(
                      fontFamily: 'PollerOne',
                      fontSize: width * 0.05,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'this is description.this is description.this is \ndescription.this is description.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: width * 0.04,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 118, bottom: 12),
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.asset(
                        'assets/images/Contraception methods-rafiki.png',
                        width: 400,
                        height: 400,
                      ),
                    ),
                  ),
                  Text(
                    'Huge  Medicines Variety',
                    style: TextStyle(
                      fontFamily: 'PollerOne',
                      fontSize: width * 0.05,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'this is description.this is description.this is \ndescription.this is description.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: width * 0.04,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
              },
              child: const Text(
                'Get Started',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )
          : Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 29,
              ),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil(
                            SignUpScreen.routeName, (route) => false),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: JumpingDotEffect(
                        verticalOffset: 8,
                        activeDotColor: Theme.of(context).colorScheme.primary,
                        dotColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                        dotHeight: 15,
                        dotWidth: 15,
                      ),
                      onDotClicked: (index) => _controller.animateToPage(
                        index,
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
