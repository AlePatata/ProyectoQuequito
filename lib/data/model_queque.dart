import 'dart:math';

import 'package:flutter/material.dart';

class ModelQueque {
  DateTime done;
  int sold;
  int pieces = 21;
  String flavor;
  bool charged;
  ModelQueque({required this.done, required this.sold, required this.flavor, required this.charged});

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
        initialDate: DateTime(2021, 7, 25),
        firstDate: DateTime(2021),
        lastDate: DateTime(2022),
      );
      selectedDate = pickedDate;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          onTap: selectDateFunction,
          title: Text(selectedDate == null
              ? 'Date'
              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
          ),
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
    return Form(
      child: TextFormField(
        initialValue: flavor,
        onChanged: (value) {
          setFlavor(value);
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(border: InputBorder.none),
      ),
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