import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../data/api_services/api_service.dart';
import '../data/model/SearchNameModel.dart';
import '../utils/strings.dart';

class SearchMealBloc extends Bloc<SearchMealEvent, SearchMealState> {
  SearchMealRepository repository;

  SearchMealBloc({required this.repository}) : super(SearchMealInitialState()) {
    on<FetchSearchMealEvent>((event, emit) async {
      emit(SearchMealInitialState());
      try {
        SearchMealModel searchMealModel = await repository.sendOtpDealer(event.data);
        if (searchMealModel.meals != null) {
          if (searchMealModel.meals!.isNotEmpty) {
            emit(SearchMealLoadedState(searchMealModel: searchMealModel));
          } else {
            emit(SearchMealErrorState(message: 'No meals found'));
          }
        } else {
          emit(SearchMealErrorState(message: 'No meals found'));
        }
      } catch (e) {
        emit(SearchMealErrorState(message: 'No meals found'));
      }
    });
  }
}

abstract class SearchMealEvent extends Equatable {}

class FetchSearchMealEvent extends SearchMealEvent {
  Map<String, dynamic>? data;

  FetchSearchMealEvent({required this.data});

  @override
  List<Object?> get props => throw UnimplementedError();
}

abstract class SearchMealState extends Equatable {
  const SearchMealState();
}

class SearchMealLoadingState extends SearchMealState {
  @override
  List<Object> get props => [];
}

class SearchMealLoadedState extends SearchMealState {
  SearchMealModel searchMealModel;

  SearchMealLoadedState({required this.searchMealModel});

  @override
  List<Object> get props => [searchMealModel];
}

class SearchMealErrorState extends SearchMealState {
  String message;

  SearchMealErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SearchMealInitialState extends SearchMealState {
  @override
  List<Object> get props => [];
}

abstract class SearchMealRepository {
  Future<SearchMealModel> sendOtpDealer(Map<String, dynamic>? data);
}

class SearchMealRepositoryImpl extends SearchMealRepository {
  @override
  Future<SearchMealModel> sendOtpDealer(Map<String, dynamic>? data) async {
    final Response response =
    await ApiService().get(AppConstants.meals , queryParameters: data);
    if (response.statusCode == 200) {
      var data = json.decode('$response');
      SearchMealModel model = SearchMealModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }
}
