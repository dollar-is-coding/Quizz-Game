import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/menu.dart';
import 'package:quizz_game_is_that_you/the_others/battle_question.dart';

class MatchingScreen extends StatefulWidget {
  final String roomID;
  MatchingScreen(this.roomID);
  @override
  State<MatchingScreen> createState() => _MatchingScreenState(this.roomID);
}

class _MatchingScreenState extends State<MatchingScreen> {
  String roomID;
  _MatchingScreenState(this.roomID);
  final _authMail = FirebaseAuth.instance.currentUser!.email;
  final users = FirebaseFirestore.instance.collection('Users');
  var rooms = FirebaseFirestore.instance.collection('Rooms');
  late String topic;
  late String categoryUser;

  @override
  Widget build(BuildContext context) {
    Widget mainSection = Padding(
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
      child: StreamBuilder(
        stream: rooms.where('room', isEqualTo: roomID).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data!.docs.map(
                (room) {
                  return IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/avatar.png'),
                                minRadius: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  room['user1'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(255, 5, 33, 71),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          color:
                              Color.fromARGB(255, 5, 33, 71), //color of divider
                          thickness: 2, //thickness of divier line
                          endIndent: 50,
                          indent: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(room['user2'] != ''
                                    ? 'images/avatar_01.png'
                                    : 'images/no_avatar.png'),
                                minRadius: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  room['user2'] == ''
                                      ? 'User 2'
                                      : room['user2'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(255, 5, 33, 71),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            );
          }
          return const Text('No user');
        },
      ),
    );

    Widget descriptionSection = Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Column(
        children: [
          StreamBuilder(
            stream: rooms.where('room', isEqualTo: roomID).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data!.docs.map(
                    (room) {
                      topic = room['topic'];
                      return Text(
                        room['topic'],
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ).toList(),
                );
              }
              return const Text('No user');
            },
          ),
          Text(
            'The description pattern focuses on the details as part of the whole. If you give details about an object\'s appearance, you are describing.',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    Widget buttonSection = Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
      child: StreamBuilder(
        stream: rooms.where('room', isEqualTo: roomID).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data!.docs.map(
                (room) {
                  return room['email1'] == _authMail
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (room['user2'] != '') {
                                      room.reference.update(
                                          {'state': 1, 'suns1': 0, 'no1': 0});
                                      categoryUser = 'user1';
                                      Timer(const Duration(seconds: 2), () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BattleQuestionScreen(roomID,
                                                    topic, categoryUser),
                                          ),
                                        );
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: room['user2'] != ''
                                        ? const Color.fromARGB(255, 5, 33, 71)
                                        : const Color.fromARGB(
                                            255, 153, 185, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
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
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (room['user2'] == '') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MainMenuScreen(),
                                        ),
                                      );
                                      rooms.doc(roomID).delete();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: room['user2'] == ''
                                        ? const Color.fromARGB(255, 255, 0, 0)
                                        : const Color.fromARGB(
                                            255, 153, 185, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (room['state'] != 0) {
                                      room.reference
                                          .update({'suns2': 0, 'no2': 0});
                                      categoryUser = 'user2';
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BattleQuestionScreen(
                                                  roomID, topic, categoryUser),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: room['state'] != 0
                                        ? const Color.fromARGB(255, 5, 33, 71)
                                        : const Color.fromARGB(
                                            255, 153, 185, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
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
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainMenuScreen(),
                                      ),
                                    );
                                    rooms.doc(roomID).update({
                                      'email2': '',
                                      'user2': '',
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 0, 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    'Quit',
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                },
              ).toList(),
            );
          }
          return const Text('No user');
        },
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
