import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/begin_screens/forgot_password.dart';
import 'package:quizz_game_is_that_you/utils.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isSignIn = true;
  @override
  Widget build(BuildContext context) {
    Future _SignIn() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(e.message);
      }
    }

    Future SignUp() async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(e.message);
      }
    }

    Widget textSection = Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quizz Game',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 5, 33, 71),
              fontWeight: FontWeight.w800,
              fontSize: 35,
            ),
          ),
          Text(
            'Enter your log in details to access your account',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 17,
              color: const Color.fromARGB(255, 5, 33, 71),
            ),
          ),
        ],
      ),
    );
    Widget titleSection = Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 2),
                  child: Text(
                    'Email',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: const Color.fromARGB(255, 5, 33, 71),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: emailController,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
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
                          color: Color.fromARGB(255, 202, 221, 255),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 84, 121, 247),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 2),
                child: Text(
                  'Password',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: const Color.fromARGB(255, 5, 33, 71),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextField(
                  controller: passwordController,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 202, 221, 255),
                    filled: true,
                    contentPadding: const EdgeInsets.fromLTRB(15, 3, 0, 0),
                    hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 126, 148, 184),
                      fontSize: 15,
                    ),
                    border: const OutlineInputBorder(),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.visibility_off,
                        color: Color.fromARGB(255, 126, 148, 184),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 202, 221, 255),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 84, 121, 247),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 5, 33, 71),
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Forgot your password?',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 5, 33, 71),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
    Widget buttonSection = Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: _SignIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 5, 33, 71),
          minimumSize: const Size(140, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          'Sign In',
          style: GoogleFonts.poppins(
            fontSize: 17,
            color: const Color.fromARGB(255, 237, 243, 255),
          ),
        ),
      ),
    );
    Widget signUpSection = Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        // Không đủ dòng sẽ tự xuống dòng theo kiểu row
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        children: [
          Text(
            "Don't have an account?",
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: const Color.fromARGB(255, 5, 33, 71),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isSignIn = !isSignIn;
              });
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 5, 33, 71),
              minimumSize: Size.zero,
              padding: const EdgeInsets.only(left: 5),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Create account',
              style: GoogleFonts.poppins(
                fontSize: 15,
                decoration: TextDecoration.underline,
                color: const Color.fromARGB(255, 5, 33, 71),
              ),
            ),
          )
        ],
      ),
    );

    Widget text = Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Text(
        'Quizz Game',
        style: GoogleFonts.poppins(
          color: const Color.fromARGB(255, 5, 33, 71),
          fontSize: 35,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
    Widget input = Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 2),
                  child: Text(
                    'Email',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: const Color.fromARGB(255, 5, 33, 71),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height * 0.07,
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 2),
                  child: Text(
                    'Password',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: const Color.fromARGB(255, 5, 33, 71),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height * 0.07,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'At least 6 character'
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
                      hintText: 'Password',
                      hintStyle: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 126, 148, 184),
                        fontSize: 15,
                      ),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 202, 221, 255),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 84, 121, 247),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.visibility_off,
                          color: Color.fromARGB(255, 126, 148, 184),
                        ),
                      ),
                      suffixIconConstraints:
                          const BoxConstraints(minHeight: 30, minWidth: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 2),
                  child: Text(
                    'Confirm password',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: const Color.fromARGB(255, 5, 33, 71),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height * 0.07,
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        value != null && value != passwordController.text
                            ? 'Confirm password doesn\'t fit password'
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
                      hintText: 'Confirm password',
                      hintStyle: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 126, 148, 184),
                        fontSize: 15,
                      ),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 202, 221, 255),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 84, 121, 247),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.visibility_off,
                          color: Color.fromARGB(255, 126, 148, 184),
                        ),
                      ),
                      suffixIconConstraints:
                          const BoxConstraints(minHeight: 30, minWidth: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    Widget button = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ElevatedButton(
        onPressed: SignUp,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 5, 33, 71),
            minimumSize: const Size(140, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: Text(
          'Sign Up',
          style: GoogleFonts.poppins(
            fontSize: 17,
            color: const Color.fromARGB(255, 237, 243, 255),
          ),
        ),
      ),
    );
    Widget signInSection = Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        // Không đủ dòng sẽ tự xuống dòng theo kiểu row
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        children: [
          Text(
            "Aldready have an account?",
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: const Color.fromARGB(255, 5, 33, 71),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isSignIn = true;
              });
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 5, 33, 71),
              minimumSize: Size.zero,
              padding: const EdgeInsets.only(left: 5),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Sign In',
              style: GoogleFonts.poppins(
                fontSize: 15,
                decoration: TextDecoration.underline,
                color: const Color.fromARGB(255, 5, 33, 71),
              ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          isSignIn ? 'SIGN IN' : 'SIGN UP',
          style: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 5, 33, 71),
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 237, 243, 255),
      ),
      body: isSignIn
          ? Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textSection,
                    titleSection,
                    buttonSection,
                    signUpSection,
                  ],
                ),
              ),
            )
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    text,
                    input,
                    button,
                    signInSection,
                  ],
                ),
              ),
            ),
    );
  }
}
