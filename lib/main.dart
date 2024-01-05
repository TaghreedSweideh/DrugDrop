import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'screens/log_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/sign_up_otp_screen.dart';
import 'screens/home_bottom_bar.dart';
import 'screens/categories_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/search-screen.dart';
import 'screens/drug_details_screen.dart';
import 'screens/tags_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/see_all_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/notifications_screen.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/orders_provider.dart';
import 'providers/tags_provider.dart';
import 'providers/categories_provider.dart';
import 'providers/drugs_provider.dart';
import 'providers/search-provider.dart';
import 'providers/notification_provider.dart';

import '../translations/codegen_loader.g.dart';

const String host = '192.168.43.239';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translations/',
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CartProvider>(
          create: (_) => CartProvider(''),
          update: (context, auth, previous) => CartProvider(auth.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
          create: (_) => OrdersProvider(''),
          update: (context, auth, previous) => OrdersProvider(auth.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider, TagsProvider>(
          create: (_) => TagsProvider(''),
          update: (context, auth, previous) => TagsProvider(auth.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CategoriesProvider>(
          create: (_) => CategoriesProvider(''),
          update: (context, auth, previous) => CategoriesProvider(auth.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider, DrugsProvider>(
          create: (_) => DrugsProvider(''),
          update: (context, auth, previous) => DrugsProvider(auth.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider, SearchProvider>(
          create: (_) => SearchProvider(''),
          update: (context, auth, previous) => SearchProvider(auth.token),
        ),
        ChangeNotifierProxyProvider<AuthProvider, NotificationProvider>(
          create: (_) => NotificationProvider(''),
          update: (context, auth, previous) => NotificationProvider(auth.token),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, child) => MaterialApp(
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'DrugDrop',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromRGBO(255, 252, 252, 1),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color.fromRGBO(3, 37, 78, 1),
              secondary: const Color.fromRGBO(219, 243, 250, 1),
            ),
            appBarTheme: AppBarTheme(
              iconTheme: const IconThemeData(
                color: Color.fromRGBO(219, 243, 250, 1),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              toolbarHeight: MediaQuery.of(context).size.height * 0.08,
              color: const Color.fromRGBO(3, 37, 78, 1),
              titleTextStyle: const TextStyle(
                color: Color.fromRGBO(219, 243, 250, 1),
                fontSize: 20,
                fontFamily: 'PollerOne',
              ),
            ),
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: const Color.fromRGBO(3, 37, 78, 1),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.08,
              ),
            ),
          ),
          // initialRoute: SplashScreen.routeName,
          initialRoute:
              auth.isAuth ? HomeBottomBar.routeName : SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (_) => SplashScreen(),
            LogInScreen.routeName: (_) => LogInScreen(),
            IntroScreens.routeName: (_) => IntroScreens(),
            SignUpScreen.routeName: (_) => SignUpScreen(),
            ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
            OTPScreen.routeName: (_) => OTPScreen(),
            SignUpOTPScreen.routeName: (_) => SignUpOTPScreen(),
            ResetPasswordScreen.routeName: (_) => ResetPasswordScreen(),
            HomeBottomBar.routeName: (_) => HomeBottomBar(auth.userId),
            CartScreen.routeName: (_) => CartScreen(),
            OrdersScreen.routeName: (_) => OrdersScreen(),
            CategoriesScreen.routeName: (_) => CategoriesScreen(),
            SearchScreen.routeName: (_) => SearchScreen(),
            DrugDetailsScreen.routeName: (_) => DrugDetailsScreen(),
            TagsScreen.routeName: (_) => TagsScreen(),
            FavoritesScreen.routeName: (_) => FavoritesScreen(),
            SeeAllScreen.routeName: (_) => SeeAllScreen(),
            SettingsScreen.routeName: (_) => SettingsScreen(),
            NotificationsScreen.routeName: (_) => NotificationsScreen(),
          },
        ),
      ),
    );
  }
}
