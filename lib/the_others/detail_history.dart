import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//grouped listview cho này ok
class DetailHistoryScreen extends StatefulWidget {
  @override
  State<DetailHistoryScreen> createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  bool flag = true;
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
    Widget soloSection = ListView.builder(
      physics: const ScrollPhysics(parent: null),
      shrinkWrap: true, //shr & phys để cuộn được khi nằm trong column
      itemCount: 10,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Card(
            color: const Color.fromARGB(255, 202, 221, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //set border radius more than 50% of height and width to make circle
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 23,
                        child: Icon(
                          Icons.check_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            'Hot dog là từ dùng để chỉ món ăn nào sau đây?'
                            ' Hot dog là từ dùng để chỉ món ăn nào sau đây?',
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis, // new
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              // fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 5, 33, 71),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Detail',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
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
