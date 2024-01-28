import 'dart:convert';
RecipeModel recipeModelFromJson(String str) => RecipeModel.fromJson(json.decode(str));
String recipeModelToJson(RecipeModel data) => json.encode(data.toJson());
class RecipeModel {
  RecipeModel({
      List<Categories>? categories,}){
    _categories = categories;
}

  RecipeModel.fromJson(dynamic json) {
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
  }
  List<Categories>? _categories;

  List<Categories>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));
String categoriesToJson(Categories data) => json.encode(data.toJson());
class Categories {
  Categories({
      String? idCategory, 
      String? strCategory, 
      String? strCategoryThumb, 
      String? strCategoryDescription,}){
    _idCategory = idCategory;
    _strCategory = strCategory;
    _strCategoryThumb = strCategoryThumb;
    _strCategoryDescription = strCategoryDescription;
}

  Categories.fromJson(dynamic json) {
    _idCategory = json['idCategory'];
    _strCategory = json['strCategory'];
    _strCategoryThumb = json['strCategoryThumb'];
    _strCategoryDescription = json['strCategoryDescription'];
  }
  String? _idCategory;
  String? _strCategory;
  String? _strCategoryThumb;
  String? _strCategoryDescription;

  String? get idCategory => _idCategory;
  String? get strCategory => _strCategory;
  String? get strCategoryThumb => _strCategoryThumb;
  String? get strCategoryDescription => _strCategoryDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idCategory'] = _idCategory;
    map['strCategory'] = _strCategory;
    map['strCategoryThumb'] = _strCategoryThumb;
    map['strCategoryDescription'] = _strCategoryDescription;
    return map;
  }

}