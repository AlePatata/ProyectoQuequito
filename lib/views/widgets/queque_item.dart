// import 'package:flutter/material.dart';
// import 'package:quequitos/data/model_queque.dart';
// import 'package:provider/provider.dart';
//
// class QuequeItem extends StatelessWidget {
//   final ModelQueque queque;
//   const QuequeItem({super.key, required this.queque});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<QuequeController>(context, listen: false);
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(flex: 1, child: pickDate(context, queque)),
//         Expanded(
//           flex: 3,
//           child: Selector<QuequeController, int>(
//             selector: (_, c) => queque.sold,
//             builder: (_, sold, __) {
//               return pickSold(context, queque), () {
//                 queque.setSold(1);
//                 controller.updateQueque(queque);
//               });
//             },
//           ),
//         ),
//         Expanded(flex: 2, child: pickFlavor(context, queque)),
//         Flexible(child: pickCharged(context, queque)),
//       ],
//     );
//   }
// }
//
//
//
// Widget pickDate(BuildContext context, ModelQueque queque) {
//   Future<void> selectDateFunction() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2025),
//       lastDate: DateTime(2026),
//     );
//     queque.setDone(pickedDate?? DateTime.now());
//   }
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     children: <Widget>[
//       OutlinedButton(
//         onPressed: selectDateFunction,
//         child: Text('${queque.done.day}/${queque.done.month}/${queque.done.year}',
//             style: TextStyle(fontSize: 10)),
//       ),
//     ],
//   );
// }
//
// Widget pickCharged(BuildContext context, queque) {
//   return Checkbox(
//       value: queque.charged,
//       onChanged: (value) {
//         queque.setCharged(value!);
//       }
//   );
// }
//
// Widget pickFlavor(BuildContext context, queque) {
//   return DropdownButton(
//       items: queque.flavors.map((String flavor) {
//         return DropdownMenuItem(
//           value: flavor,
//           child: Text(flavor),
//         );
//       }).toList(),
//       onChanged: (value) {
//         queque.setFlavor(value.toString());
//       },
//       underline: Container(),
//       icon: Icon(Icons.arrow_drop_down, color: Colors.black)
//   );
// }
//
// Widget pickSold(BuildContext context, queque) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       IconButton(
//           onPressed: () => queque.setSold(-1),
//           icon: Icon(Icons.remove),
//           iconSize: 10.0),
//       Text('$queque.sold/$queque.pieces'),
//       IconButton(
//           onPressed: () => queque.setSold(1),
//           icon: Icon(Icons.add),
//           iconSize: 10.0),
//     ],
//   );
// }