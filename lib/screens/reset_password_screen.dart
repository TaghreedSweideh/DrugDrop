import 'package:animate_do/animate_do.dart';
import 'package:drug_drop/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../screens/log_in_screen.dart';
import '../widgets/logo.dart';
import '../widgets/my_upper_clipper.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const routeName = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

var _isVisible;

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  void initState() {
    _isVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                  SizedBox(
                    height: media.size.height * 0.4,
                    child: SlideInLeft(
                      duration: const Duration(milliseconds: 1000),
                      child: Image.asset('assets/images/resetPassword.png'),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      LocaleKeys.enter_your_password.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PollerOne',
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  PasswordForm(),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .popAndPushNamed(LogInScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordForm extends StatefulWidget {
  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SlideInRight(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                obscureText: _isVisible,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: theme.colorScheme.primary,
                  label: const Text('Password'),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _isVisible = !_isVisible),
                    icon: Icon(
                        _isVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                  suffixIconColor: theme.colorScheme.primary,
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
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            SlideInLeft(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                obscureText: _isVisible,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: theme.colorScheme.primary,
                  label: const Text('Confirm Password'),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _isVisible = !_isVisible),
                    icon: Icon(
                        _isVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                  suffixIconColor: theme.colorScheme.primary,
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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
