import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WinOrLoseScreen extends StatefulWidget {
  final String roomID;
  final String categoryUser;
  WinOrLoseScreen(this.roomID, this.categoryUser);
  @override
  State<WinOrLoseScreen> createState() =>
      _WinOrLoseScreenState(this.roomID, this.categoryUser);
}

class _WinOrLoseScreenState extends State<WinOrLoseScreen> {
  String roomID;
  String categoryUser;
  late int result;
  _WinOrLoseScreenState(this.roomID, this.categoryUser);
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
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              textAlign: TextAlign.center,
                              'Waiting for ${room['user2']} completing their turn!',
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 5, 33, 71),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
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
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              textAlign: TextAlign.center,
                              'Waiting for ${room['user1']} completing their turn!',
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 5, 33, 71),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          LottieBuilder.network(
                              'https://assets1.lottiefiles.com/packages/lf20_x62chJ.json'),
                        ],
                      );
                    }
                    if (categoryUser == 'user1' &&
                            room['suns1'] > room['suns2'] ||
                        categoryUser == 'user2' &&
                            room['suns1'] < room['suns2']) {
                      result = 1;
                    } else if (categoryUser == 'user1' &&
                            room['suns1'] < room['suns2'] ||
                        categoryUser == 'user2' &&
                            room['suns1'] > room['suns2']) {
                      result = -1;
                    } else {
                      result = 0;
                    }
                    return Column(
                      children: [
                        Text(result == 1
                            ? 'You Win'
                            : result == -1
                                ? 'You Lose'
                                : 'Fair'),
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
