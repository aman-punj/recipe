import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../data/api_services/api_service.dart';
import '../data/model/recipeModel.dart';
import '../utils/strings.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository repository;

  CategoryBloc({required this.repository}) : super(CategoryInitialState()) {
    on<FetchCategoryEvent>((event, emit) async {
      emit(CategoryInitialState());
      try {
        CategoryModel categoryModel = await repository.sendOtpDealer(event.data);

        if (categoryModel.categories != null) {
          if (categoryModel.categories!.isNotEmpty) {
            emit(CategoryLoadedState(categoryModel: categoryModel));
          } else {
            emit(CategoryErrorState(message: 'No categories found'));
          }
        } else {
          emit(CategoryErrorState(message: 'No categories found'));
        }
      } catch (e) {
        emit(CategoryErrorState(message: 'No categories found'));
      }
    });
  }
}

abstract class CategoryEvent extends Equatable {}

class FetchCategoryEvent extends CategoryEvent {
  Map<String, dynamic>? data;

  FetchCategoryEvent({required this.data});

  @override
  List<Object?> get props => throw UnimplementedError();
}

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryLoadingState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoadedState extends CategoryState {
  // loaded will have a a state depending on the model so we will keep this
  CategoryModel categoryModel;

  CategoryLoadedState({required this.categoryModel});

  @override
  List<Object> get props => [categoryModel];
}

class CategoryErrorState extends CategoryState {
  String message;

  CategoryErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class CategoryInitialState extends CategoryState {
  @override
  List<Object> get props => [];
}

abstract class CategoryRepository {
  Future<CategoryModel> sendOtpDealer(Map<String, dynamic>? data);
}

class CategoryRepositoryImpl extends CategoryRepository {
  @override
  Future<CategoryModel> sendOtpDealer(Map<String, dynamic>? data) async {
    final Response response =
        await ApiService().post(AppConstants.categories, data: data);
    if (response.statusCode == 200) {
      var data = json.decode('$response');
      CategoryModel model = CategoryModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
