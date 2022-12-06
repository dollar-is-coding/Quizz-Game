import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/the_others/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Widget signOutDialog = AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 5, 33, 71),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          'SIGN OUT',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      content: Wrap(
        children: [
          Text(
            textAlign: TextAlign.center,
            'Are you sure to sign out ?',
            style: GoogleFonts.poppins(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 129, 169, 105),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    Widget infoSection = Container(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'dollar.02',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Male',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                'Joined in May, 2022',
                style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromARGB(255, 121, 138, 163)),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('images/avatar.png'),
                radius: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 5, 33, 71),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text(
                      'Edit',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    Widget nameStatisticSection = Container(
      padding: const EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        'Statistic',
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    Widget statisticSection = ListView.builder(
      itemCount: 5,
      itemBuilder: ((context, index) {
        return Card(
          color: const Color.fromARGB(255, 202, 221, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            alignment: Alignment.center,
            child: const ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 5, 33, 71),
                radius: 25,
              ),
              title: Text('Science'),
              subtitle: Text('35 answered'),
              trailing: Text(
                '25%',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      }),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return signOutDialog;
                  },
                );
              },
              child: Text(
                'Sign Out',
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 5, 33, 71),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 237, 243, 255),
      ),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
        child: Column(
          children: [
            infoSection,
            nameStatisticSection,
            Expanded(
              child: statisticSection,
            ),
          ],
        ),
      ),
    );
  }
}
