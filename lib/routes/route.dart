import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/bloc/recipe_bloc.dart';
import 'package:recipe/bloc/search_mealBloc.dart';
import 'package:recipe/screens/homepage_screen.dart';
import 'package:recipe/screens/likedRecipe_screen.dart';
import 'package:recipe/screens/recipe_detail_screen.dart';
import 'package:recipe/screens/search_detail.dart';
import 'package:recipe/screens/wishlist_screen.dart';
import 'package:recipe/utils/common_widget.dart';
import '../screens/cart_screen.dart';
import '../screens/recipe_Screen.dart';
import '../screens/splash_screen.dart';

dynamic? sendRoute(BuildContext context, RoutesNames s,
    {bool isreplace = false,
    bool clearstack = false,
    Function? onrefresh,
    Map<String, dynamic>? data}) {
  dynamic widget = null;
  switch (s) {
    case RoutesNames.splash:
      widget = SplashScreen();
      break;

    case RoutesNames.homescreen:
      sendActivity(context, HomePage(), clearstack: clearstack);
      break;
    case RoutesNames.cart:
      sendActivity(context, CartScreen());
      break;
    case RoutesNames.wishlist:
      sendActivity(context, WishlistScreen());
      break;

    case RoutesNames.recipedetail:
      sendActivity(context, RecipeDetailScreen(data: data));
      break;

    case RoutesNames.recipescreen:
      sendActivity(
          context,
          MultiBlocProvider(
            providers: [
              BlocProvider<RecipeBloc>(
                create: (context) => RecipeBloc(
                  repository: RecipeRepositoryImpl(),
                ),
              ),
              BlocProvider<SearchMealBloc>(
                create: (context) =>
                    SearchMealBloc(repository: SearchMealRepositoryImpl()),
              ),
            ],
            child:  const RecipeHomeScreen(),
          ));
      break;

    case RoutesNames.searchMealdetail:
      sendActivity(context, SearchDetailScreen(data: data));
      break;

    case RoutesNames.likedrecipe:
      sendActivity(context, LikedRecipeScreen());
  }
  return widget;
}

enum RoutesNames {
  splash,
  homescreen,
  cart,
  wishlist,
  recipescreen,
  recipedetail,
  searchMealdetail, likedrecipe
}
