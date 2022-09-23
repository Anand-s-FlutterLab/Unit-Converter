import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Discount extends StatefulWidget {
  const Discount({Key? key}) : super(key: key);

  @override
  State<Discount> createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Discount Calculator",
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
      body: const DiscountHomeScreen(),
    );
  }
}

class DiscountHomeScreen extends StatefulWidget {
  const DiscountHomeScreen({Key? key}) : super(key: key);

  @override
  State<DiscountHomeScreen> createState() => _DiscountHomeScreenState();
}

class _DiscountHomeScreenState extends State<DiscountHomeScreen> {
  double _original = 0;
  double _disc = 0;
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Enter Original Price",
                  labelText: "Original Price",
                  border: OutlineInputBorder()),
              style: const TextStyle(
                fontSize: 25,
                fontFamily: "Caveat",
                color: Colors.purple,
              ),
              onChanged: (original) {
                setState(() {
                  _original = double.parse(original);
                });
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Enter Discount's Percentage",
                  labelText: "Discount in %",
                  border: OutlineInputBorder()),
              style: const TextStyle(
                fontSize: 25,
                fontFamily: "Caveat",
                color: Colors.purple,
              ),
              onChanged: (disc) {
                setState(() {
                  _disc = double.parse(disc);
                });
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            MaterialButton(
              minWidth: double.infinity,
              onPressed: _convert,
              child: const Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Caveat",
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              height: 25.0,
            ),
            Text(
              _result,
              style: const TextStyle(
                color: Colors.teal,
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
                fontFamily: "Kdam",
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  void _convert() {
    if (_original > 0 && _disc > 0)
      {
        double saving = (_disc * _original) / 100;
        double fPrice = _original - saving;

        setState(() {
          _result = "Final Price = $fPrice\nTotal Saving = $saving";
        });
      }
    else{
      setState(() {
        _result = "Please enter proper value";
      });
    }
  }
}
