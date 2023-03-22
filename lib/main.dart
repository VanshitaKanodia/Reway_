import 'package:flutter/material.dart';
// import 'package:reway/screens/account_profile.dart';
// import 'package:reway/screens/favorites.dart';
// import 'package:reway/screens/home_screen.dart';
// import 'package:reway/screens/info_display_screen.dart';
// import 'package:reway/screens/login_screen.dart';
// import 'package:reway/screens/map_screen.dart';
// import 'package:reway/screens/my_inbox.dart';
// import 'package:reway/screens/my_orders.dart';
// import 'package:reway/screens/rating_screen.dart';
// import 'package:reway/screens/signup_screen.dart';
import 'package:reway/services/google_auth_service.dart';
// import 'package:reway/splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          hintColor: Colors.grey,
        ),
        home: handleAuthState(),
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => LoginScreen(),
        //   '/second': (context) => SignUpScreen(),
        //   '/home': (context) => HomeScreen(),
        //   '/map_screen': (context) => MapsScreen(),
        //   '/info_display': (context) => InfoDisplayScreen(),
        //   '/rating': (context) => RatingScreen(),
        //   '/account_profile': (context) => AccountProfile(),
        //   '/favorites': (context) => MyFavorites(),
        //   '/inbox': (context) => MyInbox(),
        //   '/my_orders': (context) => MyOrders(),
        //   'splash': (context) => Splash(),
        // }
    );
  }
}