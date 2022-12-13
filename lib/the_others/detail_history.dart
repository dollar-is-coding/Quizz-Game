import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//grouped listview cho này ok
class DetailHistoryScreen extends StatefulWidget {
  @override
  State<DetailHistoryScreen> createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  bool flag = true;
  final _authMail = FirebaseAuth.instance.currentUser!.email;
  var _ranks = FirebaseFirestore.instance.collection('Ranks');
  var _room = FirebaseFirestore.instance.collection('Rooms');
  @override
  Widget build(BuildContext context) {
    Widget chooseSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          padding: const EdgeInsets.only(right: 10),
          child: ElevatedButton(
            onPressed: () {
              setState(() => flag = true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: flag
                  ? const Color.fromARGB(255, 5, 33, 71)
                  : const Color.fromARGB(255, 202, 221, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              'Solo',
              style: GoogleFonts.poppins(
                color:
                    flag ? Colors.white : const Color.fromARGB(255, 5, 33, 71),
                fontWeight: flag ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          padding: const EdgeInsets.only(left: 10),
          child: ElevatedButton(
            onPressed: () {
              setState(() => flag = !flag);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: flag == false
                  ? const Color.fromARGB(255, 5, 33, 71)
                  : const Color.fromARGB(255, 202, 221, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              'Battle',
              style: GoogleFonts.poppins(
                color: flag == false
                    ? Colors.white
                    : const Color.fromARGB(255, 5, 33, 71),
                fontWeight: flag == false ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
    Widget soloSection = StreamBuilder(
      stream: _ranks.where('email', isEqualTo: _authMail).snapshots(),
      builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.requireData;
          return ListView.builder(
            physics: const ScrollPhysics(parent: null),
            shrinkWrap: true, //shr & phys để cuộn được khi nằm trong column
            itemCount: data.size,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 2),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailHistoryScreen(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 202, 221, 255),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 237, 243, 255),
                          child: Icon(
                            Icons.calendar_month,
                            color: Color.fromARGB(255, 5, 33, 71),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            ('Date ${data.docs[index]['date']}'),
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 24, 43, 80),
                            ),
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.eco_rounded,
                                color: Color.fromARGB(255, 204, 193, 79),
                              ),
                            ),
                            Text(
                              ('${data.docs[index]['suns']}'),
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 24, 43, 80),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }
        return const Text('No data');
      }),
    );
    Widget battleSection = ListView.builder(
      itemCount: 10,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 5, 33, 71),
                    radius: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '5:30',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: VerticalDivider(
                        thickness: 2,
                        endIndent: 3,
                        color: Color.fromARGB(255, 5, 33, 71),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //set border radius more than 50% of height and width to make circle
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 5, 33, 71),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 10),
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('images/avatar.png'),
                                      radius: 40,
                                    ),
                                    Text(
                                      'You',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      'Win',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Image.asset('images/vs_01.png'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 10),
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('images/avatar_01.png'),
                                      radius: 40,
                                    ),
                                    Text(
                                      'Hana',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      'Lose',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.red,
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
                  ],
                ),
              )
            ],
          ),
        );
      }),
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
        elevation: 0,
        centerTitle: true,
        title: Text(
          'HISTORY',
          style: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 5, 33, 71),
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 237, 243, 255),
      ),
      extendBody: true,
      body: Column(
        children: [
          chooseSection,
          Expanded(
            child: flag == true ? soloSection : battleSection,
          ),
        ],
      ),
    );
  }
}
