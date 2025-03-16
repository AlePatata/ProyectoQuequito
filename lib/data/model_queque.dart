import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quequitos/data/db.dart';

class ModelQueque {
  int? id;
  DateTime done;
  int sold;
  String flavor;
  bool charged;
  ModelQueque({this.id, required this.done, required this.sold, required this.flavor, required this.charged});

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
  int pieces = 21;
  double _cost = 0;
  double _gain = 0;
  double mamiPrice = 15000;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'done': done.toIso8601String(),
      'sold': sold,
      'flavor': flavor,
      'charged': charged ? 1 : 0
    };
  }

  /*
  factory ModelQueque.fromJson(Map<String, dynamic> json) {
    return ModelQueque(
      done: DateTime.parse(json['done']),
      sold: json['sold'],
      flavor: json['flavor'],
      charged: json['charged']
    );
  }
  */

  factory ModelQueque.fromMap(Map<String, dynamic> map) {
    return ModelQueque(
      id: map['id'],
      done: DateTime.parse(map['done']),
      sold: map['sold'],
      flavor: map['flavor'],
      charged: map['charged'] == 1,
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

  void setSold(int increment) async {
    sold += increment;
    sold = max(0, sold);
    sold = min(pieces, sold);
    updateDB();
  }

  void setFlavor(String f) async {
    flavor = f;
    updateDB();
  }

  void setCharged(bool b) {
    charged = b;
    updateDB();
  }

  void setID(int i) {
    id = i;
    updateDB();
  }



  /// Other methods ///
  DateTime? selectedDate;

  void updateDB() async {
    if (id != null) {
      await DBHelper.instance.updateQueque(this);
    }
  }

  /// Widgets ///
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
    return DropdownButton<String>(
      value: flavor,
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
        IconButton(
          onPressed: () => setSold(-1),
          icon: Icon(Icons.remove),
          iconSize: 10.0),
        Text('$sold/$pieces'),
        IconButton(
          onPressed: () => setSold(1),
          icon: Icon(Icons.add),
          iconSize: 10.0),
      ],
    );
  }
}