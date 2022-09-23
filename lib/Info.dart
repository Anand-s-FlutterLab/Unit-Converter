import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Play',
              letterSpacing: 1.5,
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                    ),
                  ),
                  child: Image.asset("img/img.png",
                      width: 150, height: 150, fit: BoxFit.fill),
                ),
              ],
            ),
            Container(
              height: 30,
            ),
            const Text(
              "Created By: Anand R Patel",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Play', fontSize: 20),
            ),
            Container(
              height: 30,
            ),
            const Text(
              "Version: 1.0",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Play', fontSize: 20),
            ),
            Container(
              height: 50,
            ),
            const Text(
              "Contact Us: ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Play',
                  fontSize: 20,
                  decoration: TextDecoration.underline),
            ),
            Container(
              height: 15,
            ),
            const Text(
              "Mobile Number: 7069144776",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Play', fontSize: 20),
            ),
            Container(
              height: 15,
            ),
            const Text(
              "Email: anandrajpatel134@gmail.com",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Play', fontSize: 20),
            ),
            Container(
              height: 50,
            ),
            const Text(
              "For any kind of Feedback, provide it through mail",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Play',
                  fontSize: 25,
                  decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}