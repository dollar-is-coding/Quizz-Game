import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/menu.dart';

class ResultScreen extends StatelessWidget {
  final String text;
  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget textSection = Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "You've got a new bonus!",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 5, 33, 71),
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
    Widget scoreSection = Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.height * 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 202, 221, 255),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Leaves bonus',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.eco_rounded,
                              color: Color.fromARGB(255, 215, 175, 30),
                            ),
                            Text(
                              text,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 15,
                        color: Color.fromARGB(255, 5, 33, 71),
                        spreadRadius: 0.1),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'images/leaves.png',
                    width: 60,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Widget watchSection = Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainMenuScreen(),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 5, 33, 71),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: Text(
            'Claim reward',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [textSection, scoreSection, watchSection],
        ),
      ),
    );
  }
}
