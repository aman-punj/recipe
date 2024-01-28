import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:recipe/data/cart_item.dart';
import 'package:recipe/data/grocery.dart';
import 'package:recipe/data/wishlist_item.dart';

import '../../data/model/home_product_model.dart';

// part 'home_event.dart';

// part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);

    on<HomeProductWishlistBtnClickedEvent>(homeProductWishlistBtnClickedEvent);

    on<HomeProductCartBtnClickedEvent>(homeProductCartBtnClickedEvent);

    on<HomeProductWishlistNavigateEvent>(homeProductWishlistNavigateEvent);

    on<HomeProductCartNavigateEvent>(homeProductCartNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GroceryData.getGroceryProducts()
            .map((e) => ProductModel(
                  id: e['id'].toString(),
                  name: e['name'],
                  description: e['description'],
                  price: e['price'].toString(),
                  imageUrl: e['imageUrl'],
                ))
            .toList()));
  }

  FutureOr<void> homeProductWishlistBtnClickedEvent(
      HomeProductWishlistBtnClickedEvent event, Emitter<HomeState> emit) {
    print('wishlist  product clicked');
    wishlistItem.add(event.clickedProduct);
    emit(AddedToWishlistActionState());
  }

  FutureOr<void> homeProductCartBtnClickedEvent(
      HomeProductCartBtnClickedEvent event, Emitter<HomeState> emit) {
    print('cart product clicked');
    cartItem.add(event.clickedProduct);
    emit(AddedToCartActionState());
  }

  FutureOr<void> homeProductWishlistNavigateEvent(
      HomeProductWishlistNavigateEvent event, Emitter<HomeState> emit) {
    print('wishlist clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeProductCartNavigateEvent(
      HomeProductCartNavigateEvent event, Emitter<HomeState> emit) {
    print('cart clicked');
    emit(HomeNavigateToCartPageActionState());
  }
}

abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistBtnClickedEvent extends HomeEvent {
  final ProductModel clickedProduct;

  HomeProductWishlistBtnClickedEvent({required this.clickedProduct});
}

class HomeProductCartBtnClickedEvent extends HomeEvent {
  final ProductModel clickedProduct;

  HomeProductCartBtnClickedEvent({required this.clickedProduct});
}

class HomeProductWishlistNavigateEvent extends HomeEvent {}

class HomeProductCartNavigateEvent extends HomeEvent {}

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class AddedToCartActionState extends HomeActionState {}

class AddedToWishlistActionState extends HomeActionState {}
