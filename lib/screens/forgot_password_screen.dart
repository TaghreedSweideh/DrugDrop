import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'otp_screen.dart';
import '../widgets/my_upper_clipper.dart';
import '../widgets/logo.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const routeName = '/forgot-password';

  final _formKey = GlobalKey<FormState>();
  late final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height - media.padding.top,
          margin: EdgeInsets.only(
            top: media.padding.top,
            bottom: media.padding.bottom,
          ),
          child: Stack(
            children: [
              ClipPath(
                clipper: MyUpperClipper(),
                child: Container(
                  height: media.size.height * 0.2,
                  width: double.infinity,
                  color: const Color.fromRGBO(205, 230, 255, 1),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Transform.flip(
                  flipX: true,
                  flipY: true,
                  child: ClipPath(
                    clipper: MyUpperClipper(),
                    child: Container(
                      height: media.size.height * 0.2,
                      width: double.infinity,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: media.size.width * 0.1,
                top: media.size.height * 0.15,
                child: SlideInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: SlideInLeft(
                    duration: const Duration(milliseconds: 1000),
                    child: Circle(40),
                  ),
                ),
              ),
              Positioned(
                right: media.size.width * 0.15,
                bottom: media.size.height * 0.15,
                child: SlideInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: SlideInRight(
                    duration: const Duration(milliseconds: 1000),
                    child: Circle(
                      20,
                      color: theme.colorScheme.primary.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: media.size.width * 0.15,
                bottom: media.size.height * 0.35,
                child: SlideInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: SlideInLeft(
                    duration: const Duration(milliseconds: 1000),
                    child: Circle(
                      25,
                      color: theme.colorScheme.primary.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: media.size.width * 0.15,
                top: media.size.height * 0.35,
                child: SlideInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: SlideInLeft(
                    duration: const Duration(milliseconds: 1000),
                    child: Circle(30),
                  ),
                ),
              ),
              Logo(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Spacer(flex: 2),
                  // SizedBox(
                  //   height: height * 0.35,
                  //   child: Image.asset('assets/images/forgotPassword.png'),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                    child: Text(
                      'Please enter your phone number.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PollerOne',
                        color: theme.colorScheme.primary,
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.1),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      maxLength: 8,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 15),
                        prefixIcon: const Icon(Icons.phone),
                        prefixIconColor: theme.colorScheme.primary,
                        prefix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text('09'),
                        ),
                        prefixStyle: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        label: const Text('Phone Number'),
                        isDense: true,
                        filled: true,
                        fillColor: Colors.transparent,
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (phoneNumber) {
                        if (phoneNumber!.isEmpty) {
                          return 'This field is required';
                        } else if (phoneNumber.length < 8) {
                          return 'Must be 8 digits';
                        }
                      },
                      onSaved: (phoneNumber) =>
                          phoneNumber = phoneNumber.toString(),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(OTPScreen.routeName),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Send',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // const Spacer(flex: 2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final double radius;
  final Color color;

  Circle(this.radius, {this.color = const Color.fromRGBO(205, 230, 255, 1)});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: radius,
    );
  }
}
