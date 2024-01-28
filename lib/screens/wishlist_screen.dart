import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/wishlist/wishlist_bloc.dart';
import '../features/wishlist/wishlist_tile.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Wishlist'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successstate = state as WishlistSuccessState;
              return ListView.builder(
                itemCount: successstate.wishlistItem.length,
                itemBuilder: (context, index) {
                  return WishlistTile(
                    productModel: successstate.wishlistItem[index],
                    wishlistBloc: wishlistBloc,
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
