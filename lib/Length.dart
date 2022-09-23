import 'package:flutter/material.dart';

class Length extends StatefulWidget {
  const Length({Key? key}) : super(key: key);

  @override
  State<Length> createState() => _LengthState();
}

class _LengthState extends State<Length> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Length Converter",
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
      body: const LengthHomeScreen(),
    );
  }
}

class LengthHomeScreen extends StatefulWidget {
  const LengthHomeScreen({Key? key}) : super(key: key);

  @override
  State<LengthHomeScreen> createState() => _LengthHomeScreenState();
}

class _LengthHomeScreenState extends State<LengthHomeScreen> {
  final Map<String, int> _measuresMap = {
    'Millimeter': 0,
    'Centimeter': 1,
    'Meter': 2,
    'Kilometer': 3,
    'Mile': 4,
    'Yard': 5,
    'Foot': 6,
    'Inch': 7,
  };

  final dynamic _formulas = {
    '0' : [
      1,
      0.1,
      0.001,
      0.000001,
      0.00000062137,
      0.0010936,
      0.00328,
      0.03937
    ],
    '1' : [
      10,
      1,
      0.01,
      0.00001,
      0.0000062137,
      0.010936,
      0.00328,
      0.3937
    ],
    '2' : [
      1000,
      100,
      1,
      0.001,
      0.000621,
      1.0936,
      3.28,
      39.37,
    ],
    '3' : [
      1000000,
      100000,
      1000,
      1,
      0.62137,
      1094,
      3281,
      39370,
    ],
    '4' : [
      1609344,
      160934,
      1609,
      1.61,
      1,
      1760,
      5280,
      63360,
    ],
    '5' : [
      914.4,
      91.44,
      0.91,
      0.000914,
      0.000568,
      1,
      3,
      36,
    ],
    '6' : [
      304.8,
      30.48,
      0.3,
      0.0003,
      0.000189,
      0.33,
      1,
      12,
    ],
    '7' : [
      25.4,
      2.54,
      0.03,
      0.00003,
      0.000016,
      0.03,
      0.08,
      1,
    ],
  };

  final TextStyle labelStyle = const TextStyle(
      fontSize: 25,
      letterSpacing: 1.5,
      fontWeight: FontWeight.w700,
      fontFamily: "Caveat",
      color: Colors.purple);

  final TextStyle resultSyle = const TextStyle(
    color: Colors.teal,
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
    fontFamily: "Kdam",
  );

  final List<String> _measures = [
    'Millimeter',
    'Centimeter',
    'Meter',
    'Kilometer',
    'Mile',
    'Yard',
    'Foot',
    'Inch',
  ];

  double _value = 0;
  String _fromMeasure = 'Millimeter';
  String _toMeasure = 'Millimeter';
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
                  hintText: "Enter Number",
                  labelText: 'Enter the Value',
                  border: OutlineInputBorder()),
              style: const TextStyle(
                  fontSize: 25, fontFamily: "Caveat", color: Colors.purple),
              onChanged: (value) {
                setState(() {
                  _value = double.parse(value);
                });
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "From",
                      style: labelStyle,
                    ),
                    DropdownButton(
                      items: _measures
                          .map((String value) => DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _fromMeasure = (value) as String;
                        });
                      },
                      value: _fromMeasure,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "To",
                      style: labelStyle,
                    ),
                    DropdownButton(
                      items: _measures
                          .map((String value) => DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _toMeasure = (value) as String;
                        });
                      },
                      value: _toMeasure,
                    ),
                  ],
                )
              ],
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
            Text(
              _result,
              style: resultSyle,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  void _convert() {
    if (_value != 0 && _fromMeasure.isNotEmpty && _toMeasure.isNotEmpty) {
      int? from = _measuresMap[_fromMeasure];
      int? to = _measuresMap[_toMeasure];

      var multiplier = _formulas[from.toString()][to];

      setState(() {
        _result = "$_value $_fromMeasure = ${_value * multiplier} $_toMeasure";
      });
    } else {
      setState(() {
        _result = "Please enter a non zero value";
      });
    }
  }
}
