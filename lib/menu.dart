import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:quizz_game_is_that_you/menu_screens/home.dart';
import 'package:quizz_game_is_that_you/menu_screens/profile.dart';
import 'package:quizz_game_is_that_you/menu_screens/rank.dart';
import 'package:quizz_game_is_that_you/menu_screens/history.dart';

class MainMenuScreen extends StatefulWidget {
  @override
  MainMenuScreenState createState() => MainMenuScreenState();
}

class MainMenuScreenState extends State<MainMenuScreen> {
  int index = 0;
  final screens = [
    HomeScreen(),
    HistoryScreen(),
    RankScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final items = <Widget>[
      const Icon(Icons.home_rounded, size: 35),
      const Icon(Icons.history_rounded, size: 35),
      const Icon(Icons.emoji_events_rounded, size: 35),
      const Icon(Icons.person_rounded, size: 35),
    ];

    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          color: const Color.fromARGB(255, 5, 33, 71),
          buttonBackgroundColor: const Color.fromARGB(255, 5, 33, 71),
          backgroundColor: Colors.transparent,
          height: 55,
          items: items,
          animationDuration: const Duration(milliseconds: 250),
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
