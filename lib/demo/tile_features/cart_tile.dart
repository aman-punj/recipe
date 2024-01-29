// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:recipe/bloc/home_bloc.dart';
//
// import '../../bloc/cart_bloc.dart';
// import '../../data/model/home_product_model.dart';
//
//
// class CartTile extends StatelessWidget {
//   final ProductModel productModel;
//   final CartBloc cartBloc;
//
//   const CartTile(
//       {super.key, required this.productModel, required this.cartBloc});
//
//   // bool isfav = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(10),
//         child: Container(
//           decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.grey,
//                 width: 1,
//               ),
//               borderRadius: BorderRadius.circular(12)),
//           width: MediaQuery.of(context).size.width - 10.sp,
//           height: 200,
//           child: Row(
//             children: [
//               Flexible(child: Image.network(productModel.imageUrl)),
//               Spacer(),
//               Flexible(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(productModel.name),
//                     Text(productModel.description),
//                     Text("${productModel.price}Rs"),
//                     Row(
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               // cartBloc.add(
//                               //     HomeProductWishlistBtnClickedEvent(
//                               //         clickedProduct: productModel));
//                               // setState(() {
//                               //   isfav = !isfav;
//                               //   // ScaffoldMessenger.of(context).showSnackBar(
//                               //   //     SnackBar(
//                               //   //         duration: Duration(seconds: 1),
//                               //   //         content: isfav
//                               //   //             ? Text('item added')
//                               //   //             : Text('item removed')));
//                               // }
//                               // );
//                             },
//                             icon: Icon(
//                                 // isfav
//                                 // ? Icons.favorite
//                                 // :
//                             Icons.favorite_border)),
//                         IconButton(
//                           onPressed: () {
//                             // cartBloc.add(HomeProductCartBtnClickedEvent(
//                             //     clickedProduct: productModel));
//                           },
//                           icon: Icon(Icons.add_shopping_cart),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               // SizedBox(width: 10.sp,)
//             ],
//           ),
//         ));
//   }
// }
