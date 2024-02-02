import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/data/model/SearchNameModel.dart';

import '../data/api_services/api_service.dart';
import '../data/model/recipeModel.dart';
import '../utils/strings.dart';

class CounterNotifier extends ChangeNotifier {

  CategoryModel? modal;

  Future<CategoryModel> categoriesData(Map<String, dynamic>? data) async {
    final Response response =
    await ApiService().post(AppConstants.categories, data: data);
    if (response.statusCode == 200) {
      var data = json.decode('$response');
      modal = CategoryModel.fromJson(data);
      notifyListeners();
      return modal!;
    } else {
      throw Exception();
    }
  }
  // https://theninehertz.com/
  // for searching meal
  SearchMealModel? searchMealModel;

  Future<SearchMealModel> searchMealData(Map<String, dynamic>? data) async {
    final Response response =
    await ApiService().get(AppConstants.meals, queryParameters: data);
    if (response.statusCode == 200) {
      var data = json.decode('$response');
      SearchMealModel model = SearchMealModel.fromJson(data);
      return model;
    } else {
      throw Exception();
    }
  }

}

final mainScreenApiData = ChangeNotifierProvider<CounterNotifier>((ref) {
  return CounterNotifier();
}
);
