import 'package:drug_drop/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

// import 'otp_screen.dart';
import 'sign_up_otp_screen.dart';
import 'log_in_screen.dart';
import '../providers/auth_provider.dart';
import '../widgets/logo.dart';
import '../widgets/my_upper_clipper.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/sign-up';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: media.padding.top,
          bottom: media.padding.bottom,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: media.size.height - media.padding.top,
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
                  left: media.size.width * 0.20,
                  top: media.size.height * 0.2,
                  child: SlideInLeft(
                    duration: const Duration(milliseconds: 1500),
                    child: SlideInDown(
                      duration: const Duration(milliseconds: 1000),
                      child: Circle(30),
                    ),
                  ),
                ),
                Positioned(
                  right: media.size.width * 0.15,
                  bottom: media.size.height * 0.25,
                  child: SlideInRight(
                    duration: const Duration(milliseconds: 1000),
                    child: SlideInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: Circle(30),
                    ),
                  ),
                ),
                FadeIn(
                  duration: const Duration(milliseconds: 1500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Logo(),
                      const Spacer(flex: 1),
                      Text(
                        LocaleKeys.create_new_account.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'PollerOne',
                          fontSize: media.size.height * 0.03,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Spacer(flex: 1),
                      _signUpForm(),
                      const Spacer(flex: 3),
                      // Olives(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final double radius;

  Circle(this.radius);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color.fromRGBO(205, 230, 255, 1),
      radius: radius,
    );
  }
}

var _isVisible = false;

class _signUpForm extends StatefulWidget {
  @override
  State<_signUpForm> createState() => _signUpFormState();
}

class _signUpFormState extends State<_signUpForm> {
  bool _isLoading = false;

  final _passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final Map<String, String> _authData = {
    'name': '',
    'password': '',
    'confirmPassword': '',
    'phoneNumber': '',
    'location': '',
  };

  @override
  void initState() {
    _isVisible = true;
    super.initState();
  }

  void _showDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          LocaleKeys.an_error_occured.tr(),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        content: Text(content),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => _isLoading = false);
            },
            child: Text(LocaleKeys.try_again.tr()),
          ),
        ],
      ),
    );
  }

  void _submit() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    try {
      setState(() => _isLoading = true);
      await Provider.of<AuthProvider>(context, listen: false).signUp(
        _authData['name'].toString(),
        _authData['phoneNumber'].toString(),
        _authData['location'].toString(),
        _authData['password'].toString(),
      );
      setState(() => _isLoading = false);
      Navigator.of(context).pushNamed(SignUpOTPScreen.routeName);
    } catch (error) {
      setState(() => _isLoading = false);
      _showDialog(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Form(
        key: _form,
        child: Column(
          children: [
            SlideInRight(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                maxLength: 255,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: theme.colorScheme.primary,
                  label: Text(LocaleKeys.name.tr()),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (name) {
                  if (name!.isEmpty) {
                    return LocaleKeys.this_field_is_required.tr();
                  }
                  return null;
                },
                onSaved: (name) => _authData['name'] = name.toString(),
              ),
            ),
            const SizedBox(height: 10),
            SlideInLeft(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
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
                  label: Text(LocaleKeys.phone_number.tr()),
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
                    return LocaleKeys.this_field_is_required.tr();
                  } else if (phoneNumber.length < 8) {
                    return LocaleKeys.must_be_only_8_digits.tr();
                  }
                  return null;
                },
                onSaved: (phoneNumber) =>
                    _authData['phoneNumber'] = phoneNumber.toString(),
              ),
            ),
            const SizedBox(height: 10),
            SlideInRight(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                obscureText: _isVisible,
                textAlignVertical: TextAlignVertical.center,
                maxLength: 255,
                controller: _passwordController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: theme.colorScheme.primary,
                  label: Text(LocaleKeys.password.tr()),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _isVisible = !_isVisible),
                    icon: Icon(
                      _isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
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
                validator: (password) {
                  if (password!.isEmpty) {
                    return LocaleKeys.this_field_is_required.tr();
                  } else if (password.length < 4) {
                    return LocaleKeys.must_be_4_digits.tr();
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            SlideInLeft(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                obscureText: _isVisible,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.next,
                maxLength: 255,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: theme.colorScheme.primary,
                  label: Text(LocaleKeys.confirm_password.tr()),
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
                validator: (password) {
                  if (password!.isEmpty) {
                    return LocaleKeys.this_field_is_required.tr();
                  } else if (password.length < 4) {
                    return LocaleKeys.must_be_4_digits.tr();
                  } else if (_passwordController.text != password) {
                    return LocaleKeys.password_doesnt_match.tr();
                  }
                  return null;
                },
                onSaved: (password) =>
                    _authData['password'] = password.toString(),
              ),
            ),
            const SizedBox(height: 10),
            SlideInRight(
              duration: const Duration(milliseconds: 1000),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.done,
                maxLength: 255,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  prefixIcon: const Icon(Icons.location_on),
                  prefixIconColor: theme.colorScheme.primary,
                  label: Text(LocaleKeys.location.tr()),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (location) {
                  if (location!.isEmpty) {
                    return LocaleKeys.this_field_is_required.tr();
                  }
                  return null;
                },
                onSaved: (location) =>
                    _authData['location'] = location.toString(),
              ),
            ),
            const SizedBox(height: 10),
            _isLoading
                ? const CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                  )
                : ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      LocaleKeys.sign_up.tr(),
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${LocaleKeys.already_registered.tr()}?',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LogInScreen.routeName, (Route<dynamic> route) => false);
                  },
                  child: Text(
                    LocaleKeys.login.tr(),
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
