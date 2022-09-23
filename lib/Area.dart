import 'package:flutter/material.dart';

class Area extends StatefulWidget {
  const Area({Key? key}) : super(key: key);

  @override
  State<Area> createState() => _AreaState();
}

class _AreaState extends State<Area> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Area Converter",
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
      body: const AreaHomeScreen(),
    );
  }
}

class AreaHomeScreen extends StatefulWidget {
  const AreaHomeScreen({Key? key}) : super(key: key);

  @override
  State<AreaHomeScreen> createState() => _AreaHomeScreenState();
}

class _AreaHomeScreenState extends State<AreaHomeScreen> {
  final Map<String, int> _measuresMap = {
    'Square Meters': 0,
    'Square Kilometers': 1,
    'Square Centimeter': 2,
    'Square Millimeters': 3,
    'Square Mile': 4,
    'Square foot': 5,
    'Square inch': 6,
    'Hectare': 7,
    'Acre': 8,
  };

  final dynamic _formulas = {
    '0': [
      1,
      0.000001,
      10000,
      1000000,
      0.0000003861,
      10.7639,
      1550.0031,
      0.0001,
      0.00024710
    ],
    '1': [
      1000000,
      1,
      10000000000,
      1000000000000,
      0.3861021,
      10763910.4,
      155000310,
      100,
      247.1054
    ],
    '2': [
      0.0001,
      0.0000000001,
      1,
      100,
      0.00000000003861,
      0.001076,
      0.15500031,
      0.00000001,
      0.00000024710
    ],
    '3': [
      0.000001,
      0.000000000001,
      0.01,
      1,
      0.0000000000003861,
      0.00001076,
      0.0015500031,
      0.000000001,
      0.000000002471
    ],
    '4': [
      2589988.11,
      2.58998811,
      25899881100,
      2589988110000,
      1,
      27878400,
      4014489600,
      258.998811,
      640.000067
    ],
    '5': [
      0.09290,
      0.00000009290,
      929.0304,
      92903.04,
      0.00000003587,
      1,
      144,
      0.0000929,
      0.000022956
    ],
    '6': [
      0.00064516,
      0.0000000064516,
      6.4516,
      645.16,
      0.0000000024909,
      0.0069444,
      1,
      0.0000006451,
      0.00000159
    ],
    '7': [
      10000,
      0.01,
      100000000,
      10000000000,
      0.0038610,
      107639.104,
      15500031,
      1,
      2.47105407
    ],
    '8': [
      4046.856,
      0.0040468,
      40468560,
      4046856000,
      0.001562499,
      43559.9955,
      6272639.35,
      1
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
    'Square Meters',
    'Square Kilometers',
    'Square Centimeter',
    'Square Millimeters',
    'Square Mile',
    'Square foot',
    'Square inch',
    'Hectare',
    'Acre',
  ];

  double _value = 0;
  String _fromMeasure = 'Square Meters';
  String _toMeasure = 'Square Kilometers';
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
