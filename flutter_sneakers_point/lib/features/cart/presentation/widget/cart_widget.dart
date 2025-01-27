// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class CartWidget extends StatelessWidget {
//   final WidgetRef ref;
//   final List<CartEntity> cartList;

//   const CartWidget({
//     super.key,
//     required this.ref,
//     required this.cartList,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       // Put this otherwise it will take all the space
//       shrinkWrap: true,
//       itemCount: cartList.length,
//       // physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, childAspectRatio: 1.5),
//       itemBuilder: (context, index) {
//         return InkWell(
//           onTap: () {
//             ref
//                 .read(batchViewModelProvider.notifier)
//                 .getStudentsByBatch(context, cartList[index].batchId!);
//           },
//           child: Card(
//             color: Colors.green[100],
//             child: Center(
//               child: Text(
//                 cartList[index].batchName,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
