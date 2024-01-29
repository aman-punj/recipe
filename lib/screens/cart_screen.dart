import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';
import '../features/cart_tile.dart';
import '../tile_features/cart_tile.dart';
import 'productstile_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successstate = state as CartSuccessState;
              return ListView.builder(
                itemCount: successstate.cartItem.length,
                itemBuilder: (context, index) {
                  return CartTile(
                    productModel: successstate.cartItem[index],
                    cartBloc: cartBloc,
                  );
                },
              );
            default:
            // Handle other cases or return a placeholder
              return const Center(
                child: Text('Error') ,
              );
          }
        },
      ),
    );
  }

}
