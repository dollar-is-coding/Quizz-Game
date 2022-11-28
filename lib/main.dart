import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/begin_screens/sign_in.dart';
import 'package:quizz_game_is_that_you/begin_screens/verify_email.dart';
import 'package:quizz_game_is_that_you/menu.dart';
import 'package:quizz_game_is_that_you/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(QuizzGame());
}

final navigatorKey = GlobalKey<NavigatorState>();

class QuizzGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Quizz Game',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 237, 243, 255),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          } else if (snapshot.hasData) {
            return VerifyEmailScreen();
          } else {
            return SignInScreen();
          }
        },
      ),
    );
  }
}
