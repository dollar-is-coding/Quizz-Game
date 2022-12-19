import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RankScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RankScreenState();
  }
}

class RankScreenState extends State<RankScreen> {
  final _authMail = FirebaseAuth.instance.currentUser!.email;
  var _ranks = FirebaseFirestore.instance.collection('Ranks');
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Widget top3Section = Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 202, 221, 255),
        ),
        height: MediaQuery.of(context).size.height * 0.28,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'USER02',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 5, 33, 71),
                      ),
                    ),
                  ),
                  Image(
                    width: MediaQuery.of(context).size.width * 0.20,
                    image: const AssetImage('images/top_two.png'),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'USER01',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                        color: const Color.fromARGB(255, 5, 33, 71),
                      ),
                    ),
                  ),
                  Image(
                    width: MediaQuery.of(context).size.width * 0.25,
                    image: const AssetImage('images/top_one.png'),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'USER03',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 5, 33, 71),
                      ),
                    ),
                  ),
                  Image(
                    width: MediaQuery.of(context).size.width * 0.20,
                    image: const AssetImage('images/top_three.png'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    Widget textSection = Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
      child: Text(
        'Today',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: const Color.fromARGB(255, 5, 33, 71),
        ),
      ),
    );

    Widget listViewSection = Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: StreamBuilder(
          stream: _ranks.orderBy('suns', descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              int i = 0;
              return ListView(
                children: snapshot.data!.docs
                    .map(
                      (rank) => Card(
                        color: const Color.fromARGB(255, 202, 221, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 202, 221, 255),
                              radius: 20,
                              child: Text(
                                '${++i}',
                                style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(255, 5, 33, 71),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            title: Text(
                              rank['user'],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 5, 33, 71),
                              ),
                            ),
                            trailing: Text(
                              rank['suns'].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 5, 33, 71),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            }
            return Text('No Data');
          }),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'RANK',
          style: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 5, 33, 71),
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 237, 243, 255),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          top3Section,
          textSection,
          Expanded(
            child: listViewSection,
          )
        ],
      ),
    );
  }
}
