import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/the_others/matching.dart';

class Topic {
  String topic;
  Topic(this.topic);
}

class TopicScreen extends StatelessWidget {
  final String name;

  TopicScreen({Key? key, required this.name}) : super(key: key);
  List<Topic> topics = [
    Topic('History'),
    Topic('Art'),
    Topic('Geography'),
    Topic('Literality'),
    Topic('Science'),
    Topic('funny question'),
  ];
  var rooms = FirebaseFirestore.instance.collection('Rooms');
  final _authMail = FirebaseAuth.instance.currentUser!.email;

  final _chars = 'abcdefghijklmnopqrstuvwxyz1234567890';
  final Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  late String roomID;

  var today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Widget titleSection = ListView.builder(
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final item = topics[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
              child: ElevatedButton(
                onPressed: () {
                  roomID = getRandomString(6);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchingScreen(roomID),
                    ),
                  );
                  rooms.doc(roomID).set({
                    'room': roomID,
                    'user1': name,
                    'email1': _authMail,
                    'user2': '',
                    'email2': '',
                    'date':
                        '${today.day}-${today.month}-${today.year} ${today.hour}:${today.minute}',
                    'state': 0,
                    'topic': item.topic
                  });
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 3),
                            child: Text(
                              item.topic,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 237, 243, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Available',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: const Color.fromARGB(255, 5, 33, 71),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 5, 33, 71),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color.fromARGB(255, 237, 243, 255),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'TOPIC',
          style: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 5, 33, 71),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Expanded(
          child: titleSection,
        ),
      ),
    );
  }
}
