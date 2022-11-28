import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    int coin = 1000;
    int score = 2000;

    SizedBox showAchievement(String achievement, IconData icon, Color color) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.045,
        child: TextField(
          readOnly: true,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hoverColor: Colors.white,
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(0),
            prefixIcon: Icon(
              icon,
              color: color,
            ),
            hintText: achievement,
            hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: const Color.fromARGB(255, 5, 33, 71),
            ),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 153, 185, 255),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 153, 185, 255),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            //prefixIcon: Icon(Icons.person),
          ),
        ),
      );
    }

    Widget scoreSection = Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          showAchievement(
            coin.toString(),
            Icons.eco_rounded,
            const Color.fromARGB(255, 204, 193, 79),
          ),
          showAchievement(
            score.toString(),
            Icons.brightness_low_rounded,
            const Color.fromARGB(255, 255, 210, 48),
          ),
        ],
      ),
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
                    onPressed: () {},
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
        child: Column(
          children: [
            scoreSection,
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
