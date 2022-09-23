import 'package:flutter/material.dart';

class Temperature extends StatefulWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Temperature Converter",
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
      body: const TemperatureHomeScreen(),
    );
  }
}

class TemperatureHomeScreen extends StatefulWidget {
  const TemperatureHomeScreen({Key? key}) : super(key: key);

  @override
  State<TemperatureHomeScreen> createState() => _TemperatureHomeScreenState();
}

class _TemperatureHomeScreenState extends State<TemperatureHomeScreen> {
  final Map<String, int> _measuresMap = {
    'Celsius': 0,
    'Fahrenheit': 1,
    'Kelvin': 2,
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
    'Celsius',
    'Fahrenheit',
    'Kelvin',
  ];

  double _value = 0;
  String _fromMeasure = 'Celsius';
  String _toMeasure = 'Celsius';
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
                  hintText: "Enter Temperature",
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

      if(from == 0)
        {
          if(to == 0)
            {
              setState(() {
                _result = "$_fromMeasure = $_value\n$_toMeasure = $_value";
              });
            }
          else if(to == 1)
            {
              var multiplier = (_value * (9/5))+32;
              setState(() {
                _result = "$_fromMeasure = $_value\n$_toMeasure = $multiplier";
              });
            }
          else if(to == 2)
          {
            setState(() {
              _result = "$_fromMeasure = $_value\n$_toMeasure = ${_value + 273.15}";
            });
          }
        }
      else if(from == 1)
      {
        if(to == 0)
        {
          var multiplier = (_value - 32) * (5/9);
          setState(() {
            _result = "$_fromMeasure = $_value\n$_toMeasure = $multiplier";
          });
        }
        else if(to == 1)
          {
            setState(() {
              _result = "$_fromMeasure = $_value\n$_toMeasure = $_value";
            });
          }
        else if(to == 2)
        {
          var multiplier = ((_value - 32) * (5/9)) + 273.15;
          setState(() {
            _result = "$_fromMeasure = $_value\n$_toMeasure = $multiplier";
          });
        }
      }
      else if(from == 2)
      {
        if(to == 0)
        {
          setState(() {
            _result = "$_fromMeasure = $_value\n$_toMeasure = ${_value - 273.15}";
          });
        }
        else if(to == 1)
        {
          var multiplier = ((_value - 273.15) * (9/5))+32;
          setState(() {
            _result = "$_fromMeasure = $_value\n$_toMeasure = $multiplier";
          });
        }
        else if(to == 2)
        {
          setState(() {
            _result = "$_fromMeasure = $_value\n$_toMeasure = $_value";
          });
        }
      }
    } else {
      setState(() {
        _result = "Please enter a non zero value";
      });
    }
  }
}