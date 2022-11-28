import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/menu.dart';
import 'package:quizz_game_is_that_you/menu_screens/home.dart';
import 'package:quizz_game_is_that_you/utils.dart';

class VerifyEmailScreen extends StatefulWidget {
  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? MainMenuScreen()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                'VERIFY EMAIL',
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 5, 33, 71),
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 237, 243, 255),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                  child: Text(
                    textAlign: TextAlign.center,
                    'A verification email has been sent to your email.',
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 5, 33, 71),
                      fontSize: 17,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ElevatedButton(
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 5, 33, 71),
                        minimumSize: const Size(140, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: Text(
                      'Reset Email',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: const Color.fromARGB(255, 237, 243, 255),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 237, 243, 255),
                        minimumSize: const Size(140, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: const Color.fromARGB(255, 5, 33, 71),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
