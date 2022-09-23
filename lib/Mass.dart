import 'package:flutter/material.dart';

class Mass extends StatefulWidget {
  const Mass({Key? key}) : super(key: key);

  @override
  State<Mass> createState() => _MassState();
}

class _MassState extends State<Mass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mass Converter",
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
      body: const MassHomeScreen(),
    );
  }
}

class MassHomeScreen extends StatefulWidget {
  const MassHomeScreen({Key? key}) : super(key: key);

  @override
  State<MassHomeScreen> createState() => _MassHomeScreenState();
}

class _MassHomeScreenState extends State<MassHomeScreen> {
  final Map<String, int> _measuresMap = {
    'Milligram(mg)': 0,
    'Gram(g)': 1,
    'Kilogram(kg)': 2,
    'Tonne(t)': 3,
    'Pound(p)': 4,
  };

  final dynamic _formulas = {
    '0' : [
      1,
      0.001,
      0.000001,
      0,
      0.000002,
    ],
    '1' : [
      1000,
      1,
      0.001,
      0.000001,
      0.0022046,
    ],
    '2' : [
      1000000,
      1000,
      1,
      0.001,
      2.2046,
    ],
    '3' : [
      1000000000,
      1000000,
      1000,
      1,
      2204.622,
    ],
    '4' : [
      453592.37,
      453.59237,
      0.453592,
      0.000453592,
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
    'Milligram(mg)',
    'Gram(g)',
    'Kilogram(kg)',
    'Tonne(t)',
    'Pound(p)',
  ];

  double _value = 0;
  String _fromMeasure = 'Milligram(mg)';
  String _toMeasure = 'Milligram(mg)';
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
                setState(
                      () {
                    _value = double.parse(value);
                  },
                );
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
