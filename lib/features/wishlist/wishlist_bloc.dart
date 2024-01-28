
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:recipe/data/wishlist_item.dart';

import '../../data/model/home_product_model.dart';


class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(cartInitialEvent);
  }

  FutureOr<void> cartInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItem: wishlistItem));
  }
}

abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent{}


abstract class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistSuccessState extends WishlistState{
  final List<ProductModel> wishlistItem;

  WishlistSuccessState({required this.wishlistItem});
}
