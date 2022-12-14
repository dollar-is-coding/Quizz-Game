import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future _ResetPassword() async {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
        Utils.showSnackBar('Password reset email was sent!');
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(e.message);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 5, 33, 71),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'FORGOT PASSWORD',
          style: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 5, 33, 71),
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 237, 243, 255),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Text(
                textAlign: TextAlign.center,
                'Receive an email to reset your password',
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 5, 33, 71),
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: const Color.fromARGB(255, 202, 221, 255),
                  filled: true,
                  contentPadding: const EdgeInsets.fromLTRB(15, 3, 0, 0),
                  hintText: 'Email',
                  hintStyle: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 126, 148, 184),
                    fontSize: 15,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 1202, 221, 255),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 84, 121, 247),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  //prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: _ResetPassword,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 5, 33, 71),
                    minimumSize: const Size(140, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  'Reset Password',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: const Color.fromARGB(255, 237, 243, 255),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
