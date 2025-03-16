import 'package:flutter/material.dart';
import 'package:quequitos/data/model_queque.dart';
import 'package:quequitos/data/db.dart';

class Queque extends StatefulWidget{
  const Queque({super.key});

  @override
  _QuequeState createState() => _QuequeState();
}

class _QuequeState extends State<Queque> {
  List<ModelQueque> queques = [];

  @override
  void initState() {
    super.initState();
    _loadQueques();
  }

  Future<void> _loadQueques() async {
    final dbQueques = await DBHelper.instance.getAllQueques();
    setState(() {
      queques = dbQueques;
    });
  }

  Future<void> _addQueque() async {
    final newQueque = ModelQueque.fromNothing();
    final id = await DBHelper.instance.insertQueque(newQueque);


    setState(() {
      newQueque.setID(id);
      queques.add(newQueque);
    });
  }


  @override
  Widget build(BuildContext context) {
    int totalCost = 0;
    int totalGain = 0;
    return Scaffold(
      body: Column(
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
              itemCount: queques.length,
              itemBuilder: (context, index) {
                final queque = queques[index];
                totalCost += queque.cost.toInt();
                totalGain += queque.gain.toInt();
                return SizedBox(
                  height: 50, // Altura de la fila
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                    children: [
                      Expanded(flex: 1, child: queque.pickDate(context)),
                      Expanded(flex: 3, child: queque.pickSold(context)),
                      Expanded(flex: 2, child: queque.pickFlavor(context)),
                      Flexible(child: queque.pickCharged(context)),
                    ],
                  )
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),)
          ),

          SizedBox(
            child: Column(
              children: [
                Text('Total vendidos: ${queques.length}'),
                Text('Costo total: $totalCost'),
                Text('Ganancia total: $totalGain'),
              ],
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: _addQueque,
      tooltip: "Agregar Queque",
      child: Icon(Icons.add),
      ),
    );
  }
}

//