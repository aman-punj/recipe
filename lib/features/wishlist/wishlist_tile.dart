import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/features/home/home_bloc.dart';

import '../../data/model/home_product_model.dart';
import 'wishlist_bloc.dart';

class WishlistTile extends StatelessWidget {
  final ProductModel productModel;
  final WishlistBloc wishlistBloc;

  const WishlistTile(
      {super.key, required this.productModel, required this.wishlistBloc});

  // bool isfav = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12)),
          width: MediaQuery.of(context).size.width - 10.sp,
          height: 200,
          child: Row(
            children: [
              Flexible(child: Image.network(productModel.imageUrl)),
              const Spacer(),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(productModel.name),
                    Text(productModel.description),
                    Text("${productModel.price}Rs"),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.favorite)),
                        IconButton(
                          onPressed: () {
                            // wishlistBloc.add(HomeProductWishlistBtnClickedEvent(
                            //     clickedProduct: productModel));
                          },
                          icon: const Icon(Icons.add_shopping_cart),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // SizedBox(width: 10.sp,)
            ],
          ),
        ));
  }
}
