import 'package:flutter/material.dart';
import 'dart:math';

class BMI extends StatefulWidget {
  const BMI({Key? key}) : super(key: key);

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BMI Calculator",
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontSize: 28,
              fontFamily: "Play",
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 10.0,
        shadowColor: Colors.black,
        backgroundColor: Colors.purple,
      ),
      body: const BMIHomeScreen(),
    );
  }
}

class BMIHomeScreen extends StatefulWidget {
  const BMIHomeScreen({Key? key}) : super(key: key);

  @override
  State<BMIHomeScreen> createState() => _BMIHomeScreenState();
}

class _BMIHomeScreenState extends State<BMIHomeScreen> {
  double _Weight = 0;
  double _Height = 0;
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter Weight (in KG)",
                labelText: "Weight",
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 25,
                fontFamily: "Caveat",
                color: Colors.purple,
              ),
              onChanged: (height) {
                setState(() {
                  _Weight = double.parse(height);
                });
              }),
            const SizedBox(
              height: 25.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter Height (in Meter)",
                labelText: "Height",
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 25,
                fontFamily: "Caveat",
                color: Colors.purple,
              ),
              onChanged: (weight) {
                setState(() {
                  _Height = double.parse(weight);
                });
              }),
            const SizedBox(
              height: 25.0,
            ),
            MaterialButton(
              minWidth: double.infinity,
              onPressed: _convert,
              child: const Text(
                'Convert',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Caveat",
                    fontSize: 25,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700),
              ),
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              height: 25.0,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                _result,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.teal,
                  fontFamily: "Kdam",
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _convert() {
    print(_Weight);
    print("\n");
    print(_Height);

    if(_Weight > 0 && _Height > 0)
      {
        double multiplier = roundDouble((_Weight / (_Height * _Height)),2);
        // double multi = _Weight / (_Height * _Height);

        // double multiplier = multi.toStringAsFixed(2) as double;
        setState(() {
          if (multiplier < 18.5) {
            _result = "BMI = $multiplier \nCategory = Under Weight";
          }
          else if (multiplier > 18.5 && multiplier <= 25) {
            _result = "BMI = $multiplier \nCategory = Normal";
          }
          else if (multiplier > 25 && multiplier <= 30) {
            _result = "BMI = $multiplier \nCategory = Overweight";
          }
          else if (multiplier > 30) {
            _result = "BMI = $multiplier \nCategory = Obesity";
          }
        });
      }
    else{
      setState(() {
        _result = "Please enter a non zero value";
      });
    }
  }
  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}


