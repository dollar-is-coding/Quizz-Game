import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quizz_game_is_that_you/menu.dart';

class WinOrLoseScreen extends StatefulWidget {
  final String roomID;
  final String categoryUser;
  final int onLeaves;
  WinOrLoseScreen(this.roomID, this.categoryUser, this.onLeaves);
  @override
  State<WinOrLoseScreen> createState() =>
      _WinOrLoseScreenState(this.roomID, this.categoryUser, this.onLeaves);
}

class _WinOrLoseScreenState extends State<WinOrLoseScreen> {
  String roomID;
  String categoryUser;
  int onLeaves;
  late int result;
  late int leavesGot;
  final _authMail = FirebaseAuth.instance.currentUser!.email;
  var users = FirebaseFirestore.instance.collection('Users');
  _WinOrLoseScreenState(this.roomID, this.categoryUser, this.onLeaves);
  final rooms = FirebaseFirestore.instance.collection('Rooms');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: rooms.where('room', isEqualTo: roomID).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: snapshot.data!.docs.map(
                  (room) {
                    if (categoryUser == 'user1' && room['no2'] < 11) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Text(
                              textAlign: TextAlign.center,
                              '${room['user2']}',
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 5, 33, 71),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Text(
                              textAlign: TextAlign.center,
                              'is completing their turn!',
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 5, 33, 71),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          LottieBuilder.network(
                              'https://assets1.lottiefiles.com/packages/lf20_x62chJ.json'),
                        ],
                      );
                    }
                    if (categoryUser == 'user2' && room['no1'] < 11) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Text(
                              textAlign: TextAlign.center,
                              '${room['user1']}',
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 5, 33, 71),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Text(
                              textAlign: TextAlign.center,
                              'is completing their turn!',
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 5, 33, 71),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Lottie.network(
                              'https://assets1.lottiefiles.com/packages/lf20_x62chJ.json'),
                        ],
                      );
                    }
                    if (categoryUser == 'user1' &&
                            room['suns1'] > room['suns2'] ||
                        categoryUser == 'user2' &&
                            room['suns1'] < room['suns2']) {
                      result = 1;
                      leavesGot = 100;
                    } else if (categoryUser == 'user1' &&
                            room['suns1'] < room['suns2'] ||
                        categoryUser == 'user2' &&
                            room['suns1'] > room['suns2']) {
                      result = -1;
                      leavesGot = 30;
                    } else {
                      result = 0;
                      leavesGot = 60;
                    }
                    return Column(
                      children: [
                        Text(
                          result == 1
                              ? 'You Win'
                              : result == -1
                                  ? 'You Lose'
                                  : 'Fair',
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'X',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                              ),
                            ),
                            const Icon(
                              Icons.eco_rounded,
                              color: Color.fromARGB(255, 204, 193, 79),
                            ),
                            Text(
                              leavesGot.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Lottie.network(result == 1
                              ? 'https://assets1.lottiefiles.com/private_files/lf30_hxmzmij0.json'
                              : result == -1
                                  ? 'https://assets2.lottiefiles.com/private_files/lf30_aprp5fnm.json'
                                  : 'https://assets4.lottiefiles.com/packages/lf20_pvlqvtxk.json'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                users.doc(_authMail).update(
                                  {
                                    'leaves': onLeaves += leavesGot,
                                  },
                                );
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 5, 33, 71),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Get bonus',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
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
      ),
    );
  }
}
