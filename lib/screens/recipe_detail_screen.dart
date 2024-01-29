import 'dart:convert';

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
    // checkLikedStatus();
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
          if (isAlreadyLiked) {
            isLiked = true;
          } else {
            isLiked = false;
          }
          // if (likedRecipe.contains(searchMealModel!)) {
          //   isLiked = true;
          // } else {
          //   isLiked = false;
          // }
        }
      });
    }
  }

  // Future<void> checkLikedStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     isLiked = prefs.getBool(widget.data!['idMeal']) ?? false;
  //   });
  // }
  //
  Future<void> toggleLikedStatus() async {
    print(
        'Before toggleLikedStatus: isLiked=$isLiked, likedRecipe=$likedRecipe');

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
        } else {
          isLiked = true;
          likedRecipe.add(searchMealModel!);
          prefs!.setString("isLiked", jsonEncode(likedRecipe));
        }

        //   if (likedRecipe.contains(searchMealModel!)) {
        //     isLiked = false;
        //     likedRecipe.remove(searchMealModel!.idMeal!);
        //
        //     prefs!.setString("isLiked", jsonEncode(likedRecipe));
        //     // prefs!.setString("isLiked", likedRecipe);
        //   }
        //
        //   else {
        //     isLiked = true;
        //     likedRecipe.add(searchMealModel!);
        //     prefs!.setString("isLiked", jsonEncode(likedRecipe));
        //   }
        // } else {
        //   likedRecipe.add(searchMealModel!);
        //   isLiked = true;
        //   prefs!.setString("isLiked", jsonEncode(likedRecipe));
        // }
      } else {
        likedRecipe.add(searchMealModel!);
        isLiked = true;
        prefs!.setString("isLiked", jsonEncode(likedRecipe));
      }
    });
    print(
        'After toggleLikedStatus: isLiked=$isLiked, likedRecipe=$likedRecipe');
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
              },
              icon: Icon(Icons.tab_sharp)),
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
