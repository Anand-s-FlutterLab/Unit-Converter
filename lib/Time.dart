import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  const Time({Key? key}) : super(key: key);

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Time Converter",
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
      body: const TimeHomeScreen(),
    );
  }
}

class TimeHomeScreen extends StatefulWidget {
  const TimeHomeScreen({Key? key}) : super(key: key);

  @override
  State<TimeHomeScreen> createState() => _TimeHomeScreenState();
}

class _TimeHomeScreenState extends State<TimeHomeScreen> {
  final Map<String, int> _measuresMap = {
    'Second': 0,
    'Minute': 1,
    'Hour': 2,
    'Day': 3,
    'Week': 4,
    'Year': 5,
  };

  final dynamic _formulas = {
    '0': [
      1,
      0.01667,
      0.0002777,
      0,
      0,
      0,
    ],
    '1': [
      60,
      1,
      0.01667,
      0.00069458,
      0,
      0,
    ],
    '2': [
      3600,
      60,
      1,
      0.041667,
      0.01,
      0.000114,
    ],
    '3': [86400, 1440, 24, 1, 0.14, 0.002738],
    '4': [
      604800,
      10080,
      168,
      7,
      1,
      0.019165,
    ],
    '5': [
      31557600,
      525960,
      8766,
      365.2,
      52.18,
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
    'Second',
    'Minute',
    'Hour',
    'Day',
    'Week',
    'Year',
  ];

  double _value = 0;
  String _fromMeasure = 'Second';
  String _toMeasure = 'Minute';
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
