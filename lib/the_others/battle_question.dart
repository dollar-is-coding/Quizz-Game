import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/the_others/win_lose.dart';

class BattleQuestionScreen extends StatefulWidget {
  final String roomID;
  final String topic;
  final String categoryUser;
  BattleQuestionScreen(this.roomID, this.topic, this.categoryUser);
  @override
  State<BattleQuestionScreen> createState() =>
      _BattleQuestionScreenState(this.roomID, this.topic, this.categoryUser);
}

class _BattleQuestionScreenState extends State<BattleQuestionScreen> {
  String roomID;
  String topic;
  String categoryUser;
  _BattleQuestionScreenState(this.roomID, this.topic, this.categoryUser);
  var rooms = FirebaseFirestore.instance.collection('Rooms');
  final _authMail = FirebaseAuth.instance.currentUser!.email;
  var users = FirebaseFirestore.instance.collection('Users');
  Timer? timer;
  int index = 30;
  int no = 1;
  int doubleScore = 1;
  int onLeaves = 0;
  late int suns;
  int sumSuns = 0;
  Color aColor = const Color.fromARGB(255, 202, 221, 255);
  Color bColor = const Color.fromARGB(255, 202, 221, 255);
  Color cColor = const Color.fromARGB(255, 202, 221, 255);
  Color dColor = const Color.fromARGB(255, 202, 221, 255);
  Color doubleScoreColor = const Color.fromARGB(255, 202, 221, 255);
  void startCountDown() {
    timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (_) {
        if (index > 0) {
          setState(() => index--);
        } else {
          setState(
            () {
              aColor = const Color.fromARGB(255, 202, 221, 255);
              bColor = const Color.fromARGB(255, 202, 221, 255);
              cColor = const Color.fromARGB(255, 202, 221, 255);
              dColor = const Color.fromARGB(255, 202, 221, 255);
              if (doubleScore == 2) {
                doubleScore += 1;
              }
            },
          );
          index = 30;
          no++;
          categoryUser == 'user1'
              ? rooms.doc(roomID).update({'no1': no})
              : rooms.doc(roomID).update({'no2': no});
          if (no == 11) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    WinOrLoseScreen(roomID, categoryUser, onLeaves),
              ),
            );
          }
        }
      },
    );
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      startCountDown();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget solo = Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: StreamBuilder(
        stream: rooms.where('room', isEqualTo: roomID).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data!.docs.map(
                (room) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  room['email1'] == _authMail
                                      ? 'images/avatar_01.png'
                                      : 'images/avatar_02.png'),
                              radius: 25,
                            ),
                          ),
                          const Icon(
                            Icons.brightness_low_rounded,
                            color: Color.fromARGB(255, 204, 193, 79),
                            size: 25,
                          ),
                          Text(
                            room['email1'] == _authMail
                                ? room['suns1'].toString()
                                : room['suns2'].toString(),
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 5, 33, 71),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.brightness_low_rounded,
                            color: Color.fromARGB(255, 204, 193, 79),
                            size: 25,
                          ),
                          Text(
                            room['email1'] == _authMail
                                ? room['suns2'].toString()
                                : room['suns1'].toString(),
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 5, 33, 71),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  room['email1'] == _authMail
                                      ? 'images/avatar_02.png'
                                      : 'images/avatar_01.png'),
                              radius: 25,
                            ),
                          ),
                        ],
                      ),
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
    Widget question = Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.34,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 18, 50, 77),
        borderRadius: BorderRadius.circular(10),
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(topic)
            .where('no', isEqualTo: no)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map(
                (topic) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Question ${topic['no'].toString()}',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '$index',
                              style: index >= 10
                                  ? GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    )
                                  : GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.brightness_low_rounded,
                                  color: Color.fromARGB(255, 204, 193, 79),
                                ),
                                Text(
                                  '30',
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
                          color: const Color.fromARGB(255, 202, 221, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Text(
                            topic['question'],
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 5, 33, 71),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            );
          }
          return const Text('No data');
        },
      ),
    );

    Widget fourAnswer = StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(topic)
          .where('no', isEqualTo: no)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map(
              (topic) {
                return SizedBox(
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
                            onPressed: () {
                              if (timer!.isActive) {
                                timer?.cancel();
                                Timer(
                                  const Duration(seconds: 2),
                                  () {
                                    index = 30;
                                    no++;
                                    categoryUser == 'user1'
                                        ? rooms.doc(roomID).update({'no1': no})
                                        : rooms.doc(roomID).update({'no2': no});
                                    if (no == 11) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WinOrLoseScreen(
                                              roomID, categoryUser, onLeaves),
                                        ),
                                      );
                                    }
                                    startCountDown();
                                    setState(
                                      () {
                                        aColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        bColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        cColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        dColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        if (doubleScore == 2) {
                                          doubleScore += 1;
                                        }
                                      },
                                    );
                                  },
                                );
                                if (topic['true'] == 'a') {
                                  setState(() => aColor = Colors.green);
                                  index >= 25
                                      ? suns = 30
                                      : index >= 20
                                          ? suns = 25
                                          : index >= 15
                                              ? suns = 20
                                              : index >= 10
                                                  ? suns = 15
                                                  : index >= 5
                                                      ? suns = 10
                                                      : suns = 5;
                                  sumSuns += doubleScore == 2 ? suns * 2 : suns;
                                  categoryUser == 'user1'
                                      ? rooms
                                          .doc(roomID)
                                          .update({'suns1': sumSuns})
                                      : rooms
                                          .doc(roomID)
                                          .update({'suns2': sumSuns});
                                } else {
                                  setState(() => aColor = Colors.red);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: aColor,
                              minimumSize: const Size(120, 42),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                topic['a'],
                                style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(255, 5, 33, 71),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
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
                            onPressed: () {
                              if (timer!.isActive) {
                                timer?.cancel();
                                Timer(
                                  const Duration(seconds: 2),
                                  () {
                                    index = 30;
                                    no++;
                                    categoryUser == 'user1'
                                        ? rooms.doc(roomID).update({'no1': no})
                                        : rooms.doc(roomID).update({'no2': no});

                                    if (no == 11) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WinOrLoseScreen(
                                              roomID, categoryUser, onLeaves),
                                        ),
                                      );
                                    }
                                    startCountDown();
                                    setState(
                                      () {
                                        aColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        bColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        cColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        dColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        if (doubleScore == 2) {
                                          doubleScore += 1;
                                        }
                                      },
                                    );
                                  },
                                );
                                if (topic['true'] == 'b') {
                                  setState(() => bColor = Colors.green);
                                  index >= 25
                                      ? suns = 40
                                      : index >= 20
                                          ? suns = 30
                                          : index >= 15
                                              ? suns = 20
                                              : index >= 10
                                                  ? suns = 15
                                                  : index >= 5
                                                      ? suns = 10
                                                      : suns = 5;
                                  sumSuns += doubleScore == 2 ? suns * 2 : suns;
                                  categoryUser == 'user1'
                                      ? rooms
                                          .doc(roomID)
                                          .update({'suns1': sumSuns})
                                      : rooms
                                          .doc(roomID)
                                          .update({'suns2': sumSuns});
                                } else {
                                  setState(() => bColor = Colors.red);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: bColor,
                              minimumSize: const Size(120, 42),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                topic['b'],
                                style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(255, 5, 33, 71),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
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
                            onPressed: () {
                              if (timer!.isActive) {
                                timer?.cancel();
                                Timer(
                                  const Duration(seconds: 2),
                                  () {
                                    index = 30;
                                    no++;
                                    categoryUser == 'user1'
                                        ? rooms.doc(roomID).update({'no1': no})
                                        : rooms.doc(roomID).update({'no2': no});

                                    if (no == 11) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WinOrLoseScreen(
                                              roomID, categoryUser, onLeaves),
                                        ),
                                      );
                                    }
                                    startCountDown();
                                    setState(
                                      () {
                                        aColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        bColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        cColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        dColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        if (doubleScore == 2) {
                                          doubleScore += 1;
                                        }
                                      },
                                    );
                                  },
                                );
                                if (topic['true'] == 'c') {
                                  setState(() => cColor = Colors.green);
                                  index >= 25
                                      ? suns = 40
                                      : index >= 20
                                          ? suns = 30
                                          : index >= 15
                                              ? suns = 20
                                              : index >= 10
                                                  ? suns = 15
                                                  : index >= 5
                                                      ? suns = 10
                                                      : suns = 5;
                                  sumSuns += doubleScore == 2 ? suns * 2 : suns;
                                  categoryUser == 'user1'
                                      ? rooms
                                          .doc(roomID)
                                          .update({'suns1': sumSuns})
                                      : rooms
                                          .doc(roomID)
                                          .update({'suns2': sumSuns});
                                } else {
                                  setState(() => cColor = Colors.red);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cColor,
                              minimumSize: const Size(120, 42),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                topic['c'],
                                style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(255, 5, 33, 71),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
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
                            onPressed: () {
                              if (timer!.isActive) {
                                timer?.cancel();
                                Timer(
                                  const Duration(seconds: 2),
                                  () {
                                    index = 30;
                                    no++;
                                    categoryUser == 'user1'
                                        ? rooms.doc(roomID).update({'no1': no})
                                        : rooms.doc(roomID).update({'no2': no});
                                    startCountDown();
                                    if (no == 11) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WinOrLoseScreen(
                                              roomID, categoryUser, onLeaves),
                                        ),
                                      );
                                    }
                                    setState(
                                      () {
                                        aColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        bColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        cColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        dColor = const Color.fromARGB(
                                            255, 202, 221, 255);
                                        if (doubleScore == 2) {
                                          doubleScore += 1;
                                        }
                                      },
                                    );
                                  },
                                );
                                if (topic['true'] == 'd') {
                                  setState(() => dColor = Colors.green);
                                  index >= 25
                                      ? suns = 40
                                      : index >= 20
                                          ? suns = 30
                                          : index >= 15
                                              ? suns = 20
                                              : index >= 10
                                                  ? suns = 15
                                                  : index >= 5
                                                      ? suns = 10
                                                      : suns = 5;
                                  sumSuns += doubleScore == 2 ? suns * 2 : suns;
                                  categoryUser == 'user1'
                                      ? rooms
                                          .doc(roomID)
                                          .update({'suns1': sumSuns})
                                      : rooms
                                          .doc(roomID)
                                          .update({'suns2': sumSuns});
                                } else {
                                  setState(() => dColor = Colors.red);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: dColor,
                              minimumSize: const Size(120, 42),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                topic['d'],
                                style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(255, 5, 33, 71),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          );
        }
        return const Text('No data');
      },
    );

    Widget helpButton = Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
            child: StreamBuilder(
              stream: users.where('email', isEqualTo: _authMail).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!.docs.map(
                      (user) {
                        onLeaves = user['leaves'];
                        return Row(
                          children: [
                            const Icon(
                              Icons.eco_rounded,
                              color: Color.fromARGB(255, 215, 175, 30),
                            ),
                            Text(
                              user['leaves'].toString(),
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 5, 33, 71),
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  );
                }
                return const Text('No data');
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.09,
                child: ElevatedButton(
                  onPressed: () {
                    if (doubleScore == 1 && onLeaves >= 50) {
                      doubleScore++;
                      users.doc(_authMail).update(
                        {
                          'leaves': onLeaves -= 50,
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        doubleScore == 1 ? doubleScoreColor : Colors.red,
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
                            '50',
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
                            '40',
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
                  solo,
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
