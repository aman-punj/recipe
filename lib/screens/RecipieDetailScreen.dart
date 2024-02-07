import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/data/model/SearchNameModel.dart' as SearchMealMODAL;
import 'package:recipe/routes/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:recipe/data/model/recipeModel.dart' as RecipeMODEL;

class RecipeDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? data;

  RecipeDetailScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  SearchMealMODAL.Meals? searchMealModel;
  List<SearchMealMODAL.Meals> likedRecipe = [];

  bool isLiked = false;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();

    initview();
  }

  void initview() async {
    prefs = await SharedPreferences.getInstance();

    // Decode the data in initState to avoid decoding multiple times
    if (widget.data != null) {
      setState(() {
        searchMealModel = SearchMealMODAL.Meals.fromJson(
          jsonDecode(widget.data!['data']),
        );
        if (prefs!.getString('isLiked') != null) {
          List<dynamic> decodedList = jsonDecode(prefs!.getString('isLiked')!);

          likedRecipe = decodedList.map((item) {
            return SearchMealMODAL.Meals.fromJson(item);
          }).toList();
          bool isAlreadyLiked = false;

          for (SearchMealMODAL.Meals meal in likedRecipe) {
            if (meal.idMeal == searchMealModel!.idMeal) {
              isAlreadyLiked = true;
              break;
            }
          }

          // bool isAlreadyLiked =
          //     likedRecipe.any((meal) => meal.idMeal == searchMealModel!.idMeal);

          if (isAlreadyLiked) {
            isLiked = true;
          } else {
            isLiked = false;
          }
        }
      });
    }
  }

  Future<void> toggleLikedStatus() async {
    if (kDebugMode) {
      print(
          'Before toggleLikedStatus: isLiked=$isLiked, likedRecipe=$likedRecipe');
    }

    setState(() {
      if (prefs!.getString('isLiked') != null) {
        List<dynamic> decodedList = jsonDecode(prefs!.getString('isLiked')!);
        likedRecipe = decodedList.map((item) {
          return SearchMealMODAL.Meals.fromJson(item);
        }).toList();

        bool isAlreadyLiked = false;

        for (SearchMealMODAL.Meals meal in likedRecipe) {
          if (meal.idMeal == searchMealModel!.idMeal) {
            isAlreadyLiked = true;
            break;
          }
        }
        if (isAlreadyLiked) {
          isLiked = false;
          likedRecipe.remove(searchMealModel!);
          prefs!.setString("isLiked", jsonEncode(likedRecipe));
          // final updatedLikedRecipe = List.from(likedRecipe)..remove(searchMealModel!);
          // prefs!.setString("isLiked", jsonEncode(updatedLikedRecipe));

        } else {
          isLiked = true;
          likedRecipe.add(searchMealModel!);
          prefs!.setString("isLiked", jsonEncode(likedRecipe));
          // final updatedLikedRecipe = List.from(likedRecipe)..add(searchMealModel!);
          // prefs!.setString("isLiked", jsonEncode(updatedLikedRecipe));

        }
      } else {
        likedRecipe.add(searchMealModel!);
        isLiked = true;
        prefs!.setString("isLiked", jsonEncode(likedRecipe));
      }
    });
    if (kDebugMode) {
      print(
        'After toggleLikedStatus: isLiked=$isLiked, likedRecipe=$likedRecipe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Recipe Detail'),
        actions: [
          IconButton(
              onPressed: () {
                toggleLikedStatus();
              },
              icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border)),
          IconButton(
              onPressed: () {
                sendRoute(context, RoutesNames.likedrecipe);
                // Navigator.of(context).pushReplacement()
              },
              icon: const Icon(Icons.tab_sharp)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: searchMealModel != null
              ? Card(
                  elevation: 4.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        searchMealModel!.strMealThumb!,
                        width: 0.8.sw,
                        height: 0.3.sh,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        searchMealModel!.strMeal!,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        searchMealModel!.strInstructions!,
                        style: TextStyle(fontSize: 18.sp),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16.0),
                      Text(
                        'Loading Recipe...',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
