import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/routes/route.dart';
import 'package:recipe/screens/productstile_screen.dart';
import 'package:recipe/utils/strings.dart';

import '../data/cart_item.dart';
import '../features/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is !HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          sendRoute(context, RoutesNames.cart);
        } else if (state is HomeNavigateToWishlistPageActionState) {
          sendRoute(context, RoutesNames.wishlist);
        } else if (state is AddedToWishlistActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 1),
              content:
                  /*isfav
                      ? Text('item added')
                      : */
                  Text('item added to favorite')));
        }
        else if (state is AddedToCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 1),
              content:
              /*isfav
                      ? Text('item added')
                      : */
              Text('item added to cart')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeInitial:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successstate = state as HomeLoadedSuccessState;

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  AppConstants.appname,
                  style: TextStyle(fontSize: 20.sp),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductWishlistNavigateEvent());
                    },
                    icon: const Icon(Icons.favorite),
                  ),

                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          homeBloc.add(HomeProductCartNavigateEvent());
                        },
                        icon: const Icon(Icons.shopping_cart),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            cartItem.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.sp,)


                ],
              ),
              body: ListView.builder(
                itemCount: successstate.products.length,
                itemBuilder: (context, index) {
                  return ProductTile(
                    productModel: successstate.products[index],
                    homeBloc: homeBloc,
                  );
                },
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(child: Text('error')),
            );
          default:
            throw UnimplementedError('Unexpected state: $state');
        }
      },
    );
  }
}
