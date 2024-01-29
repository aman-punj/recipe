import 'dart:async';

import 'package:bloc/bloc.dart';

import '../data/cart_item.dart';
import '../data/model/home_product_model.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartItemremovesEvent>(cartItemremovesEvent);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItem: cartItem));
  }
  FutureOr<void> cartItemremovesEvent(CartItemremovesEvent event, Emitter<CartState> emit) {
  }
}

abstract class CartEvent {}

class CartInitialEvent extends CartEvent{}

class CartItemremovesEvent extends CartEvent{}


abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState{
  final List<ProductModel> cartItem;

  CartSuccessState({required this.cartItem});
}

class CartItemremovesState extends CartState{
  // final List<ProductModel> cartItem;
  //
  // CartItemremovesState({required this.cartItem});
}