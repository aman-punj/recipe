import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../data/api_services/api_service.dart';
import '../data/model/recipeModel.dart';
import '../utils/strings.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeRepository repository;

  RecipeBloc({required this.repository}) : super(RecipeInitialState()) {
    on<FetchRecipeEvent>((event, emit) async {
      emit(RecipeInitialState());
      try {
        RecipeModel recipeModel = await repository.sendOtpDealer(event.data);

        if (recipeModel.categories != null) {
          if (recipeModel.categories!.isNotEmpty) {
            emit(RecipeLoadedState(recipeModel: recipeModel));
          } else {
            emit(RecipeErrorState(message: 'No categories found'));
          }
        } else {
          emit(RecipeErrorState(message: 'No categories found'));
        }
      } catch (e) {
        emit(RecipeErrorState(message: 'No categories found'));
      }
    });
  }
}

abstract class RecipeEvent extends Equatable {}

class FetchRecipeEvent extends RecipeEvent {
  Map<String, dynamic>? data;

  FetchRecipeEvent({required this.data});

  @override
  List<Object?> get props => throw UnimplementedError();
}

abstract class RecipeState extends Equatable {
  const RecipeState();
}

class RecipeLoadingState extends RecipeState {
  @override
  List<Object> get props => [];
}

class RecipeLoadedState extends RecipeState {
  // loaded will have a a state depending on the model so we will keep this
  RecipeModel recipeModel;

  RecipeLoadedState({required this.recipeModel});

  @override
  List<Object> get props => [recipeModel];
}

class RecipeErrorState extends RecipeState {
  String message;

  RecipeErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class RecipeInitialState extends RecipeState {
  @override
  List<Object> get props => [];
}

abstract class RecipeRepository {
  Future<RecipeModel> sendOtpDealer(Map<String, dynamic>? data);
}

class RecipeRepositoryImpl extends RecipeRepository {
  @override
  Future<RecipeModel> sendOtpDealer(Map<String, dynamic>? data) async {
    final Response response =
        await ApiService().post(AppConstants.categories, data: data);
    if (response.statusCode == 200) {
      var data = json.decode('$response');
      RecipeModel model = RecipeModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
