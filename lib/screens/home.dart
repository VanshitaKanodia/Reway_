// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'account_profile.dart';
import 'pickups_screen.dart';
import 'home_screen.dart';
import 'buy_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final pages = [
    const HomeScreen(),
    const PickupScreen(),
    const BuyScreen(),
     AccountProfile(),
  ];

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      selectedLabelStyle: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        color: Colors.black45,
        fontSize: 14,
      ),
      iconSize: 28,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: (pageIndex) => setState(() => currentIndex = pageIndex),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Buy',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money),
          label: 'Pickups',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box_sharp),
          label: 'Account',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
      body: pages[currentIndex],
    );
  }
}
