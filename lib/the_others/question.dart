import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    Widget question = Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.34,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 18, 50, 77),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question 1',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.eco_rounded,
                      color: Color.fromARGB(255, 215, 175, 30),
                    ),
                    Text(
                      '50',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.26,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 255, 255),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text(
                'Dinh bao nhiêu tuổi?',
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 5, 33, 71),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Widget countdown = CircularCountDownTimer(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.height * 0.08,
      duration: 30,
      fillColor: Colors.red,
      ringColor: Colors.yellow,
      backgroundColor: Colors.white,
      textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      onComplete: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Done'),
            );
          },
        );
      },
    );
    Widget fourAnswer = SizedBox(
      height: MediaQuery.of(context).size.height * 0.32,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.065,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 202, 221, 255),
                  minimumSize: const Size(120, 42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Answer A',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 5, 33, 71),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.065,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 202, 221, 255),
                  minimumSize: const Size(120, 42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Answer B',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 5, 33, 71),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.065,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 202, 221, 255),
                  minimumSize: const Size(120, 42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Answer C',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 5, 33, 71),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.065,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 202, 221, 255),
                  minimumSize: const Size(120, 42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Answer D',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 5, 33, 71),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Widget helpButton = Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
            child: Row(
              children: [
                const Icon(
                  Icons.eco_rounded,
                  color: Color.fromARGB(255, 215, 175, 30),
                ),
                Text(
                  '1200',
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 5, 33, 71),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.09,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 202, 221, 255),
                      minimumSize: const Size(120, 42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Double Score',
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 5, 33, 71),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.eco_rounded,
                            color: Color.fromARGB(255, 215, 175, 30),
                          ),
                          Text(
                            '60',
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 5, 33, 71),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.09,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 202, 221, 255),
                    minimumSize: const Size(120, 42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Fifty fifty',
                            style: GoogleFonts.poppins(color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.eco_rounded,
                            color: Color.fromARGB(255, 215, 175, 30),
                          ),
                          Text(
                            '40',
                            style: GoogleFonts.poppins(color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  countdown,
                  question,
                ],
              ),
              fourAnswer,
              helpButton,
            ],
          ),
        ),
      ),
    );
  }
}
