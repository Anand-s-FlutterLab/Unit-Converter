import 'package:flutter/material.dart';

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Converter",
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
      body: const DataHomeScreen(),
    );
  }
}

class DataHomeScreen extends StatefulWidget {
  const DataHomeScreen({Key? key}) : super(key: key);

  @override
  State<DataHomeScreen> createState() => _DataHomeScreenState();
}

class _DataHomeScreenState extends State<DataHomeScreen> {
  final Map<String, int> _measuresMap = {
    'Byte(b)': 0,
    'Kilobyte(KB)': 1,
    'Megabyte(MB)': 2,
    'Gigabyte(GB)': 3,
    'Terabyte(TB)': 4,
    'Petabyte(PB)': 5,
  };

  final dynamic _formulas = {
    '0' : [1, 0.0009765, 0.00000095367, 0.00000000093132, 0, 0],
    '1' : [1024, 1, 0.0009765, 0.00000095367, 0.00000000093132, 0],
    '2' : [1048576, 1024, 1, 0.0009765, 0.00000095367, 0.00000000093132],
    '3' : [1073741820, 1048576, 1024, 1, 0.0009765, 0.00000095367],
    '4' : [109951163000, 1073741820, 1048576, 1024, 1, 0.0009765],
    '5' : [112589990000000,109951163000, 1073741820, 1048576, 1024, 1],
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
    'Byte(b)',
    'Kilobyte(KB)',
    'Megabyte(MB)',
    'Gigabyte(GB)',
    'Terabyte(TB)',
    'Petabyte(PB)',
  ];

  double _value = 0;
  String _fromMeasure = 'Byte(b)';
  String _toMeasure = 'Byte(b)';
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
                  labelText: 'Data Value',
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
        // _result = "$_value $_fromMeasure = ${_value * multiplier} $_toMeasure";
        _result = "$_fromMeasure = $_value\n$_toMeasure = ${_value * multiplier}";
      });
    } else {
      setState(() {
        _result = "Please enter a non zero value";
      });
    }
  }
}
