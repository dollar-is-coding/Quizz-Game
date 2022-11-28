import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/the_others/question.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    int coin = 1000;
    int score = 2000;

    Widget findRoomDialogSection = AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 5, 33, 71),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          'Enter room ID',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 42,
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 202, 221, 255),
            filled: true,
            contentPadding: const EdgeInsets.only(top: 3),
            hintText: 'Room ID',
            hintStyle: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 126, 148, 184),
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
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 129, 169, 105),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    SizedBox showAchievement(String achievement, IconData icon, Color color) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.045,
        child: TextField(
          readOnly: true,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hoverColor: Colors.white,
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(0),
            prefixIcon: Icon(
              icon,
              color: color,
            ),
            hintText: achievement,
            hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: const Color.fromARGB(255, 5, 33, 71),
            ),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 153, 185, 255),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 153, 185, 255),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            //prefixIcon: Icon(Icons.person),
          ),
        ),
      );
    }

    Widget scoreSection = Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          showAchievement(
            coin.toString(),
            Icons.eco_rounded,
            const Color.fromARGB(255, 204, 193, 79),
          ),
          showAchievement(
            score.toString(),
            Icons.brightness_low_rounded,
            const Color.fromARGB(255, 255, 210, 48),
          ),
        ],
      ),
    );

    Widget avatarSection = Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Column(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('images/avatar.png'),
            radius: 60,
          ),
          Container(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'dollar.02',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );

    Widget playButtonSection = Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.073,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 202, 221, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 2,
          ),
          child: Text(
            'PLAY',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: const Color.fromARGB(255, 5, 33, 71),
            ),
          ),
        ),
      ),
    );

    Widget createRoomButtonSection = Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.073,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 202, 221, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 2,
          ),
          child: Text(
            'CREATE ROOM',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: const Color.fromARGB(255, 5, 33, 71),
            ),
          ),
        ),
      ),
    );

    Widget findRoomButtonSection = Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.073,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return findRoomDialogSection;
                });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 202, 221, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 2,
          ),
          child: Text(
            'FIND ROOM',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: const Color.fromARGB(255, 5, 33, 71),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            scoreSection,
            avatarSection,
            playButtonSection,
            createRoomButtonSection,
            findRoomButtonSection,
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
