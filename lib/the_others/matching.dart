import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchingScreen extends StatefulWidget {
  final String topic;
  MatchingScreen(this.topic);
  @override
  State<MatchingScreen> createState() => _MatchingScreenState(this.topic);
}

class _MatchingScreenState extends State<MatchingScreen> {
  String topic;
  _MatchingScreenState(this.topic);
  int index = 5;
  Timer? timer;
  late String roomID;

  final _chars = 'abcdefg hijklmnopqrstuvwxyz1234567890';
  final Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  void startCountDown() {
    timer = Timer.periodic(
        const Duration(
          seconds: 1,
        ), (_) {
      if (index > 0) {
        setState(() => index--);
      }
    });
  }

  @override
  void initState() {
    roomID = getRandomString(6);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainSection = Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: IntrinsicHeight(
        // dòng này để sử dụng divider
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('images/avatar.png'),
                  minRadius: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'dollar.02',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 5, 33, 71),
                    ),
                  ),
                ),
              ],
            ),
            const VerticalDivider(
              color: Color.fromARGB(255, 5, 33, 71), //color of divider
              thickness: 2, //thickness of divier line
              endIndent: 50,
              indent: 10,
            ),
            Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('images/avatar_01.png'),
                  minRadius: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'hana.2k4',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 5, 33, 71),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    Widget descriptionSection = Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Column(
        children: [
          Text(
            'Science',
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            ' The description pattern focuses on the details as part of the whole. If you give details about an object\'s appearance, you are describing.',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    Widget countdownSection = Text(
      "$index",
      style: GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: const Color.fromARGB(255, 5, 33, 71),
      ),
    );

    Widget buttonSection = Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  startCountDown();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 5, 33, 71),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  'Start',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 45,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  'Quit',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 237, 243, 255),
        elevation: 0,
        centerTitle: true,
        title: Text(
          roomID,
          style: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 5, 33, 71),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          countdownSection,
          Column(
            children: [
              mainSection,
              descriptionSection,
            ],
          ),
          buttonSection,
        ],
      ),
    );
  }
}
