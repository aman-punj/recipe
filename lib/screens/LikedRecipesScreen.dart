import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/routes/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/SearchNameModel.dart' as SearchMealMODAL;
import 'RecipieDetailScreen.dart';

class LikedRecipeScreen extends StatefulWidget {
  const LikedRecipeScreen({super.key});

  @override
  State<LikedRecipeScreen> createState() => _LikedRecipeScreenState();
}

class _LikedRecipeScreenState extends State<LikedRecipeScreen> {
  List<SearchMealMODAL.Meals> likedRecipes = [];

  @override
  void initState() {
    super.initState();
    loadLikedRecipes();
  }

  void loadLikedRecipes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('isLiked') != null) {
      List<dynamic> decodedList = jsonDecode(prefs.getString('isLiked')!);

      setState(() {
        likedRecipes = decodedList.map((item) {
          return SearchMealMODAL.Meals.fromJson(item);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Recipes'),
      ),
      body: buildLikedRecipesList(),
    );
  }

  Widget buildLikedRecipesList() {
    if (likedRecipes.isEmpty) {
      return Center(
        child: Text('No liked recipes yet.'),
      );
    } else {
      return ListView.builder(
        itemCount: likedRecipes.length,
        itemBuilder: (context, index) {
          // SearchMealMODAL.Meals recipe = likedRecipes[index];
          return GestureDetector(
              onTap: () {
                sendRoute(
                  context,
                  RoutesNames.recipedetail,
                  data: {
                    "data": jsonEncode(
                      likedRecipes![index],
                    ),
                  },
                );
              },
              child: Card(
                child: Row(
                  children: [
                    Image.network(
                      likedRecipes![index].strMealThumb!,
                      height: 30.h,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        likedRecipes![index].strMeal!,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                  ],
                ),
              ));
        },
      );
    }
  }
}
