import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/the_others/result.dart';

class QuestionScreen extends StatefulWidget {
  final String username;

  QuestionScreen(this.username);
  @override
  State<QuestionScreen> createState() => _QuestionScreenState(this.username);
}

class _QuestionScreenState extends State<QuestionScreen> {
  String username;
  _QuestionScreenState(this.username);
  int index = 30;
  int no = 1;
  int tap = 0;
  int onLeaves = 0;
  int todayLeaves = 0;
  late int suns;
  int onSuns = 0;
  int doubleScore = 1;
  Color doubleScoreColor = const Color.fromARGB(255, 202, 221, 255);
  Timer? timer;
  DateTime today = DateTime.now();
  final _authMail = FirebaseAuth.instance.currentUser!.email;
  var users = FirebaseFirestore.instance.collection('Users');
  var ranks = FirebaseFirestore.instance.collection('Ranks');
  final questionHistories =
      FirebaseFirestore.instance.collection('Question History');

  CollectionReference mixedQuestion =
      FirebaseFirestore.instance.collection('Mixed question');
  Color aColor = const Color.fromARGB(255, 202, 221, 255);
  Color bColor = const Color.fromARGB(255, 202, 221, 255);
  Color cColor = const Color.fromARGB(255, 202, 221, 255);
  Color dColor = const Color.fromARGB(255, 202, 221, 255);

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
          if (no == 11) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ResultScreen(text: todayLeaves.toString()),
              ),
            );
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      startCountDown();
    });
    users.doc(_authMail).update({'suns': 0});
    ranks
        .doc(today.day < 10
            ? '${_authMail}0${today.day}-${today.month}-${today.year}'
            : '$_authMail${today.day}-${today.month}-${today.year}')
        .set({
      'email': _authMail,
      'date': today.day < 10
          ? '${today.day}-${today.month}-${today.year}'
          : '${today.day}-${today.month}-${today.year}',
      'user': username,
      'suns': 0,
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget question = Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.34,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 18, 50, 77),
        borderRadius: BorderRadius.circular(10),
      ),
      child: StreamBuilder(
        stream: mixedQuestion.where('no', isEqualTo: no).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((science) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Question ${science['no'].toString()}',
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
                                Icons.eco_rounded,
                                color: Color.fromARGB(255, 215, 175, 30),
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
                          science['question'],
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
              }).toList(),
            );
          }
          return const Text('No data');
        },
      ),
    ); 

    Widget fourAnswer = StreamBuilder(
      stream: mixedQuestion.where('no', isEqualTo: no).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((science) {
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
                              questionHistories.add(
                                {
                                  'true': science['true'],
                                  'choose': 'a',
                                  'question': science['question'],
                                  'no': science['no'],
                                  'date': DateTime.now(),
                                  'user': _authMail,
                                },
                              );
                              Timer(
                                const Duration(seconds: 3),
                                () {
                                  index = 30;
                                  no++;
                                  if (no == 11) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultScreen(
                                          text: todayLeaves.toString(),
                                        ),
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
                              if (science['true'] == 'a') {
                                setState(() => aColor = Colors.green);
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
                                todayLeaves += 30;
                                users.doc(_authMail).update(
                                  {
                                    'leaves': onLeaves += 30,
                                    'suns': onSuns +=
                                        doubleScore == 2 ? suns * 2 : suns
                                  },
                                );
                                ranks
                                    .doc(today.day < 10
                                        ? '${_authMail}0${today.day}-${today.month}-${today.year}'
                                        : '$_authMail${today.day}-${today.month}-${today.year}')
                                    .update({'suns': onSuns});
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
                              science['a'],
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
                              questionHistories.add(
                                {
                                  'true': science['true'],
                                  'choose': 'b',
                                  'question': science['question'],
                                  'no': science['no'],
                                  'date': DateTime.now(),
                                  'user': _authMail,
                                },
                              );
                              Timer(
                                const Duration(seconds: 3),
                                () {
                                  index = 30;
                                  no++;
                                  if (no == 11) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultScreen(
                                          text: todayLeaves.toString(),
                                        ),
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
                              if (science['true'] == 'b') {
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
                                todayLeaves += 30;
                                users.doc(_authMail).update(
                                  {
                                    'leaves': onLeaves += 30,
                                    'suns': onSuns +=
                                        doubleScore == 2 ? suns * 2 : suns
                                  },
                                );
                                ranks
                                    .doc(today.day < 10
                                        ? '${_authMail}0${today.day}-${today.month}-${today.year}'
                                        : '$_authMail${today.day}-${today.month}-${today.year}')
                                    .update({'suns': onSuns});
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
                              science['b'],
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
                              questionHistories.add(
                                {
                                  'true': science['true'],
                                  'choose': 'c',
                                  'question': science['question'],
                                  'no': science['no'],
                                  'date': DateTime.now(),
                                  'user': _authMail,
                                },
                              );
                              Timer(
                                const Duration(seconds: 3),
                                () {
                                  no++;
                                  if (no == 11) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultScreen(
                                          text: todayLeaves.toString(),
                                        ),
                                      ),
                                    );
                                  }
                                  index = 30;
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
                              if (science['true'] == 'c') {
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
                                todayLeaves += 30;
                                users.doc(_authMail).update(
                                  {
                                    'leaves': onLeaves += 30,
                                    'suns': onSuns +=
                                        doubleScore == 2 ? suns * 2 : suns
                                  },
                                );
                                ranks
                                    .doc(today.day < 10
                                        ? '${_authMail}0${today.day}-${today.month}-${today.year}'
                                        : '$_authMail${today.day}-${today.month}-${today.year}')
                                    .update({'suns': onSuns});
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
                              science['c'],
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
                              questionHistories.add(
                                {
                                  'true': science['true'],
                                  'choose': 'd',
                                  'question': science['question'],
                                  'no': science['no'],
                                  'date': DateTime.now(),
                                  'user': _authMail,
                                },
                              );
                              Timer(
                                const Duration(seconds: 3),
                                () {
                                  index = 30;
                                  no++;
                                  if (no == 11) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultScreen(
                                          text: todayLeaves.toString(),
                                        ),
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
                              if (science['true'] == 'd') {
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
                                todayLeaves += 30;
                                users.doc(_authMail).update(
                                  {
                                    'leaves': onLeaves += 30,
                                    'suns': onSuns +=
                                        doubleScore == 2 ? suns * 2 : suns
                                  },
                                );
                                ranks
                                    .doc(today.day < 10
                                        ? '${_authMail}0${today.day}-${today.month}-${today.year}'
                                        : '$_authMail${today.day}-${today.month}-${today.year}')
                                    .update({'suns': onSuns});
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
                              science['d'],
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
            }).toList(),
          );
        }
        return const Text('No data');
      },
    );

    Widget helpButton = Padding(
      padding: const EdgeInsets.all(15),
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
                        onSuns = user['suns'];
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
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.brightness_low_rounded,
                                color: Color.fromARGB(255, 215, 175, 30),
                              ),
                            ),
                            Text(
                              user['suns'].toString(),
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
                          Icon(
                            Icons.eco_rounded,
                            color: doubleScore == 1
                                ? const Color.fromARGB(255, 215, 175, 30)
                                : Colors.greenAccent,
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
                            '35',
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
              question,
              fourAnswer,
              helpButton,
            ],
          ),
        ),
      ),
    );
  }
}
