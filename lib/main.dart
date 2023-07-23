import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reway/screens/account_profile.dart';
import 'package:reway/screens/pickups_screen.dart';
import 'package:reway/screens/home.dart';
import 'package:reway/screens/info_display_screen.dart';
import 'package:reway/screens/login_screen.dart';
import 'package:reway/screens/login_screen_with_mobile.dart';
import 'package:reway/screens/map_screen.dart';
import 'package:reway/screens/my_inbox.dart';
import 'package:reway/screens/buy_screen.dart';
import 'package:reway/screens/rating_screen.dart';
import 'package:reway/screens/signup_screen.dart';
import 'package:reway/services/googlesheets.dart';
import 'package:reway/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SheetsFlutter.init();
  await Firebase.initializeApp();
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Reway',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          hintColor: Colors.grey,
        ),
        // home: handleAuthState(),
        initialRoute: '/splash',
        routes: {
          '/': (context) => const LoginScreen(),
          '/second': (context) => const SignUpScreen(),
          '/home': (context) => const Home(),
          '/map_screen': (context) => const MapsScreen(),
          '/info_display': (context) => const InfoDisplayScreen(),
          '/rating': (context) => const RatingScreen(),
          '/account_profile': (context) => AccountProfile(),
          '/favorites': (context) => const BuyScreen(),
          '/inbox': (context) => const MyInbox(),
          '/my_orders': (context) => const PickupScreen(),
          '/splash': (context) => const Splash(),
          '/login_with_mobile': (context) => const LoginWithMobile(),
          // '/otp_verification_screen': (context) =>
          //     const OtpVerificationScreen(),
        });
  }
}
