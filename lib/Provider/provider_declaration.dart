import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recipe/data/model/SearchNameModel.dart';
import 'package:recipe/data/model/recipeModel.dart';
import '../data/api_services/api_service.dart';
import '../utils/strings.dart';

class RecipeResponseProvider extends ChangeNotifier {

  CategoryModel? modal;

  Future<CategoryModel> categoriesData() async {
    final Response response =
    await ApiService().get(AppConstants.categories);
    if (response.statusCode == 200) {
      var data = json.decode('$response');
      modal = CategoryModel.fromJson(data);
      notifyListeners();
      return modal!;
    } else {
      throw Exception();
    }
  }

  // for searching meal
  SearchMealModel? searchMealModel;

  Future<SearchMealModel> searchMealData(Map<String, dynamic>? data) async {
    final Response response =
    await ApiService().post(AppConstants.meals, queryParameters: data);
    if (response.statusCode == 200) {
      var data = json.decode('$response');
      SearchMealModel modal = SearchMealModel.fromJson(data);
      searchMealModel = modal;
      notifyListeners();
      return modal;
    } else {
      throw Exception();
    }
  }

}


