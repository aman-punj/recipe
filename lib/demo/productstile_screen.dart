// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:recipe/bloc/home_bloc.dart';
//
// import '../data/model/home_product_model.dart';
//
// class ProductTile extends StatefulWidget {
//   final ProductModel productModel;
//   final HomeBloc homeBloc;
//
//   const ProductTile(
//       {super.key, required this.productModel, required this.homeBloc});
//
//   @override
//   State<ProductTile> createState() => _ProductTileState();
// }
//
// class _ProductTileState extends State<ProductTile> {
//   bool isfav = false;
//   // bool isadded = false;
//
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
//               Flexible(child: Image.network(widget.productModel.imageUrl)),
//               const Spacer(),
//               Flexible(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(widget.productModel.name),
//                     Text(widget.productModel.description),
//                     Text("${widget.productModel.price}Rs"),
//                     Row(
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               widget.homeBloc.add(
//                                   HomeProductWishlistBtnClickedEvent(
//                                       clickedProduct: widget.productModel));
//                               setState(() {
//                                 isfav = !isfav;
//                                 // ScaffoldMessenger.of(context).showSnackBar(
//                                 //     SnackBar(
//                                 //         duration: Duration(seconds: 1),
//                                 //         content: isfav
//                                 //             ? Text('item added')
//                                 //             : Text('item removed')));
//                               });
//                             },
//                             icon: Icon(isfav
//                                 ? Icons.favorite
//                                 : Icons.favorite_border)),
//                         IconButton(
//                           onPressed: () {
//                             widget.homeBloc.add(HomeProductCartBtnClickedEvent(
//                                 clickedProduct: widget.productModel));
//                           },
//                           icon: const Icon(Icons.add_shopping_cart),
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
