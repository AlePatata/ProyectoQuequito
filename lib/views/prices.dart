import 'package:flutter/cupertino.dart';
import 'package:quequitos/data/model_queque.dart';

class Prices extends StatelessWidget {
  const Prices({super.key});


  @override
  Widget build(BuildContext context) {
    final model = ModelQueque.fromNothing();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text("Ingrediente", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 1, child: Text("Precio", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: model.recipe.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 2, child: Text(model.recipe.keys.elementAt(index))),
                  Expanded(flex: 1, child: Text(model.prices.values.elementAt(index).toString())),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}