import 'package:flutter/material.dart';
import 'package:quequitos/data/model_queque.dart';

class Queque extends StatelessWidget{
  const Queque({super.key});


  @override
  Widget build(BuildContext context) {
    final queque = ModelQueque.fromNothing();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 2, child: Text("Hecho", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text("Vendido", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text("Sabor", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 1, child: Text("Cobrado", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
              ]
            ),
        ),
        Flexible(
          child:
          ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: 10,
            itemBuilder: (context, index) {

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 2, child: queque.pickDate(context)),
                  Expanded(flex: 3, child: queque.pickSold(context)),
                  Expanded(flex: 2, child: queque.pickFlavor(context)),
                  Expanded(flex: 1, child: queque.pickCharged(context)),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),)
        )
      ],
    );


  }
}