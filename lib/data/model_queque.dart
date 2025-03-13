import 'dart:math';

import 'package:flutter/material.dart';

class ModelQueque {
  DateTime done;
  int sold;
  int pieces = 21;
  String flavor;
  bool charged;
  ModelQueque({required this.done, required this.sold, required this.flavor, required this.charged});

  List<String> flavors = ['Limon', 'Vainilla', 'Marmolado'];
  Map<String, double> recipe = {
    'Harina': 1.5,
    'Azucar': 1.0,
    'Huevos': 10,
    'Aceite': 0.5,
    'Polvos': 0.5,
    'Otros': 1
  };
  Map<String, double> prices = {
    'Harina': 1300,
    'Azucar': 1100,
    'Huevos': 300,
    'Aceite': 1400,
    'Polvos': 650,
    'Otros': 0
  };
  double _cost = 0;
  double _gain = 0;
  double mamiPrice = 15000;

  factory ModelQueque.fromJson(Map<String, dynamic> json) {
    return ModelQueque(
      done: DateTime.parse(json['done']),
      sold: json['sold'],
      flavor: json['flavor'],
      charged: json['charged']
    );
  }

  factory ModelQueque.fromNothing() {
    return ModelQueque(
      done: DateTime.now(),
      sold: 0,
      flavor: '-',
      charged: false
    );
  }

  /// Getters ///
  double get cost {
    _cost = 0;
    prices.forEach((key, value) {
      _cost += (value.toDouble() * recipe[key]!).toInt();
    });
    return _cost;
  }

  double get gain {
    _gain = mamiPrice/pieces * sold;
    return _gain;
  }

  /// Setters ///
  void setDone(DateTime d) {
    done = d;
  }

  void setSold(int s) {
    sold = s;
  }

  void setFlavor(String f) {
    flavor = f;
  }

  void setCharged(bool b) {
    charged = b;
  }



  /// Other methods ///
  DateTime? selectedDate;

  Widget pickDate(BuildContext context) {
    DateTime? selectedDate;
    Future<void> selectDateFunction() async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2025),
        lastDate: DateTime(2026),
      );
      selectedDate = pickedDate;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        OutlinedButton(
          onPressed: selectDateFunction,
          child: Text(selectedDate == null
              ? 'Date'
              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
              , style: TextStyle(fontSize: 10)),
        ),
      ],
    );
  }

  Widget pickCharged(BuildContext context) {
    return Checkbox(
        value: charged,
        onChanged: (value) {
          setCharged(value!);
        }
    );
  }

  Widget pickFlavor(BuildContext context) {
    return DropdownButton(
      items: flavors.map((String flavor) {
        return DropdownMenuItem(
          value: flavor,
          child: Text(flavor),
        );
      }).toList(),
      onChanged: (value) {
        setFlavor(value.toString());
      },
      underline: Container(),
        icon: Icon(Icons.arrow_drop_down, color: Colors.black)
    );
  }

  Widget pickSold(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: (){sold = max(0, sold-1);}, icon: Icon(Icons.remove), iconSize: 10.0),
        Text('$sold/$pieces'),
        IconButton(onPressed: (){sold++;}, icon: Icon(Icons.add), iconSize: 10.0),
      ],
    );
  }
}