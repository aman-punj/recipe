import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/bloc/recipe_bloc.dart';
import 'package:recipe/bloc/search_mealBloc.dart';
import 'package:recipe/demo/homepage_screen.dart';
import 'package:recipe/screens/likedRecipe_screen.dart';
import 'package:recipe/screens/recipe_detail_screen.dart';
import 'package:recipe/screens/search_detail.dart';
import 'package:recipe/demo/wishlist_screen.dart';
import 'package:recipe/utils/common_widget.dart';
import '../demo/cart_screen.dart';
import '../screens/RecipeCategoriesScreen.dart';
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
    //
    // case RoutesNames.homescreen:
    //   sendActivity(context, const HomePage(), clearstack: clearstack);
    //   break;
    // case RoutesNames.cart:
    //   sendActivity(context, const CartScreen());
    //   break;
    // case RoutesNames.wishlist:
    //   sendActivity(context, const WishlistScreen());
    //   break;

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
            child: const RecipeHomeScreen(),
          ),
          clearstack: clearstack);
      break;

    case RoutesNames.searchMealdetail:
      sendActivity(context, SearchDetailScreen(data: data));
      break;

    case RoutesNames.likedrecipe:
      sendActivity(context, const LikedRecipeScreen());
  }
  return widget;
}

enum RoutesNames {
  splash,
  // homescreen,
  // cart,
  // wishlist,
  recipescreen,
  recipedetail,
  searchMealdetail,
  likedrecipe
}
