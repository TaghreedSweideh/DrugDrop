import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'reset_password_screen.dart';
import '../widgets/logo.dart';
import '../widgets/my_upper_clipper.dart';

var OTP = '';

class OTPScreen extends StatelessWidget {
  static const routeName = '/OTP';

  bool checkOTP() {
    if (OTP == '111111') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: media.size.height - media.padding.top,
          margin: EdgeInsets.only(
            top: media.padding.top,
            bottom: media.padding.bottom,
          ),
          child: Stack(
            children: [
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(),
                  const Spacer(),
                  SizedBox(
                    height: media.size.height * 0.3,
                    width: double.infinity,
                    child: Image.asset('assets/images/OTP.png'),
                  ),
                  Text(
                    'Enter the code you received',
                    style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontFamily: 'PollerOne',
                        fontSize: media.size.width * 0.05),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SlideInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 1500),
                            child: OTPDigit(TextInputAction.next),
                          ),
                        ),
                        SlideInDown(
                          duration: const Duration(milliseconds: 1000),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 1500),
                            child: OTPDigit(TextInputAction.next),
                          ),
                        ),
                        SlideInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 1500),
                            child: OTPDigit(TextInputAction.next),
                          ),
                        ),
                        SlideInDown(
                          duration: const Duration(milliseconds: 1000),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 1500),
                            child: OTPDigit(TextInputAction.next),
                          ),
                        ),
                        SlideInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 1500),
                            child: OTPDigit(TextInputAction.next),
                          ),
                        ),
                        SlideInDown(
                          duration: const Duration(milliseconds: 1000),
                          child: FadeIn(
                            duration: const Duration(milliseconds: 1500),
                            child: OTPDigit(TextInputAction.done),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: media.size.height * 0.05),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(ResetPasswordScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OTPDigit extends StatelessWidget {
  final TextInputAction input;

  OTPDigit(this.input);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return SizedBox(
      height: media.size.height * 0.1,
      width: media.size.width * 0.15,
      child: Card(
        elevation: 5,
        color: const Color.fromRGBO(205, 230, 255, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: TextFormField(
            initialValue: '',
            maxLength: 1,
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            cursorColor: Theme.of(context).colorScheme.primary,
            cursorWidth: 1,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: input,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (digit) {
              input == TextInputAction.done
                  ? FocusScope.of(context).unfocus()
                  : FocusScope.of(context).nextFocus();
              OTP += digit;
            },
          ),
        ),
      ),
    );
  }
}
