import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game_is_that_you/menu_screens/profile.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}
class _EditProfileScreenState extends State<EditProfileScreen> {
  final _authMail = FirebaseAuth.instance.currentUser!.email;
  final TextEditingController _name = TextEditingController();
  var _users = FirebaseFirestore.instance.collection('Users');
  var _ranks = FirebaseFirestore.instance.collection('Ranks');
  List<String> itemsGender = ['Male', 'Female'];
  String? selectGender = "Male";
  DateTime today = DateTime.now();
  List<String> itemsAge = [
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20'
  ];
  String? selectAge = "18";
  // enum Gender{Male,Female}
  @override
  Widget build(BuildContext context) {
    Widget background = Padding(
      padding: const EdgeInsets.fromLTRB(15, 2, 15, 15),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.23,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'images/cover_01.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/avatar.png',
                    ),
                    radius: 55,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
    Widget formSection = Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: StreamBuilder(
        stream: _users.where('email', isEqualTo: _authMail).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data!.docs.map(
                (_users) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 2),
                                child: Text(
                                  'Full Name',
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    color: const Color.fromARGB(255, 5, 33, 71),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: TextField(
                              controller: _name,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(255, 202, 221, 255),
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(15, 3, 0, 0),
                                hintText: _name.text = _users['username'],
                                hintStyle: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 126, 148, 184),
                                  fontSize: 15,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 196, 219, 237),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 84, 121, 247),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 0, 2),
                                child: Text(
                                  'Gender',
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    color: const Color.fromARGB(255, 5, 33, 71),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        255, 202, 221, 255),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        borderRadius: BorderRadius.circular(20),
                                        focusColor: const Color.fromARGB(
                                            255, 84, 121, 247),
                                        iconSize: 30,
                                        iconEnabledColor: Colors.black,
                                        value: selectGender,
                                        items: itemsGender
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: GoogleFonts.poppins(
                                                    color: const Color.fromARGB(
                                                        255, 5, 33, 71),
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (item) =>
                                            setState(() => selectGender = item),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 0, 2),
                                child: Text(
                                  'Age',
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    color: const Color.fromARGB(255, 5, 33, 71),
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        255, 202, 221, 255),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        borderRadius: BorderRadius.circular(20),
                                        focusColor: const Color.fromARGB(
                                            255, 84, 121, 247),
                                        iconSize: 30,
                                        iconEnabledColor: const Color.fromARGB(
                                            255, 5, 33, 71),
                                        value: selectAge,
                                        items: itemsAge
                                            .map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: GoogleFonts.poppins(
                                                    color: const Color.fromARGB(
                                                        255, 5, 33, 71),
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (item) =>
                                            setState(() => selectAge = item),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                },
              ).toList(),
            );
          }
          return const Text("No data");
        },
      ),
    );

    Widget buttonSection = Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                if (_name.text.isNotEmpty) {
                  final String name = _name.text.trim();
                  _users.doc(_authMail).update({
                    "username": name,
                    "gender": selectGender,
                    "age": selectAge
                  });
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: const Text('Thành công'),
                          actions: [
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              ProfileScreen())));
                                },
                                child: const Text('OK'))
                          ],
                        );
                      }));
                } else {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: const Text('không Thành công'),
                          actions: [
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'))
                          ],
                        );
                      }));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 5, 33, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Save',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
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
          'PROFILE',
          style: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 5, 33, 71),
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 237, 243, 255),
      ),
      body: Center(
        child: ListView(
          children: [
            background,
            formSection,
            buttonSection,
          ],
        ),
      ),
    );
  }
}
