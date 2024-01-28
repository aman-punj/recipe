import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/data/model/recipeModel.dart';
import 'package:recipe/routes/route.dart';
import 'package:recipe/utils/common_widget.dart';

import '../bloc/recipe_bloc.dart';
import '../bloc/search_mealBloc.dart';
import '../data/model/SearchNameModel.dart';

class RecipeHomeScreen extends StatefulWidget {
  const RecipeHomeScreen({super.key});

  @override
  State<RecipeHomeScreen> createState() => _RecipeHomeScreenState();
}

class _RecipeHomeScreenState extends State<RecipeHomeScreen> {
  RecipeBloc? recipeBloc;
  RecipeModel? recipeModel;

  SearchMealBloc? searchMealBloc;
  SearchMealModel? searchMealModel;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    recipeBloc = BlocProvider.of<RecipeBloc>(context);
    searchMealBloc = BlocProvider.of<SearchMealBloc>(context);

    // calling bloc events
    recipeBloc!.add(FetchRecipeEvent(data: {}));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RecipeBloc, RecipeState>(
          listener: (context, state) {
            if (state is RecipeLoadingState) {
              toast('loading');
            } else if (state is RecipeLoadedState) {
              setState(() {
                recipeModel = state.recipeModel;
              });
            }
          },
        ),
        BlocListener<SearchMealBloc, SearchMealState>(
          listener: (context, state) {
            if (state is SearchMealLoadingState) {
              toast('searching');
            } else if (state is SearchMealLoadedState) {
              setState(() {
                searchMealModel = state.searchMealModel;
              });
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Recipes',
            style: TextStyle(fontSize: 20.sp),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: text_form_field('Search', searchController),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () {
                      searchMealBloc?.add(
                        FetchSearchMealEvent(
                            data: {'s': searchController.text}),
                      );
                    },
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              if (searchMealModel != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: searchMealModel!.meals!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          sendRoute(
                            context,
                            RoutesNames.recipedetail,
                            data: {
                              "data": jsonEncode(
                                searchMealModel!.meals![index],
                              ),
                            },
                          );
                        },
                        child: Card(
                          child: Row(
                            children: [
                              Image.network(
                                searchMealModel!.meals![index].strMealThumb!,
                                height: 30.h,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  searchMealModel!.meals![index].strMeal!,
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              else if (recipeModel != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: recipeModel!.categories!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          sendRoute(
                            context,
                            RoutesNames.recipedetail,
                            data: {
                              "data": jsonEncode(
                                recipeModel!.categories![index],
                              ),
                            },
                          );
                        },
                        child: Card(
                          child: Row(
                            children: [
                              Image.network(
                                recipeModel!
                                    .categories![index].strCategoryThumb!,
                                height: 30.h,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                recipeModel!.categories![index].strCategory!,
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              else
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),

      // Scaffold(
      //     appBar: AppBar(
      //       title: Text(
      //         'Recipes',
      //         style: TextStyle(fontSize: 20.sp),
      //       ),
      //     ),
      //     body: Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Column(
      //         children: [
      //           Row(
      //             children: [
      //               Expanded(child: text_form_field('search', searchController)),
      //               ElevatedButton(onPressed: () {
      //                 searchMealBloc?.add(FetchSearchMealEvent(data: {'s': searchController.text }));
      //               }, child: Icon(Icons.search))
      //             ],
      //           ),
      //           SizedBox(
      //             height: 20.h,
      //           ),
      //           searchMealModel != null
      //               ? Expanded(
      //                   child:
      //                   ListView.builder(
      //                       itemCount: searchMealModel!.meals!.length,
      //                       itemBuilder: (context, index) {
      //                         return GestureDetector(
      //                           onTap: () {
      //                             // encoding the index and sending it to next page as encoded json from this screen inside Map data
      //                             sendRoute(context, RoutesNames.recipedetail,
      //                                 // this is build inside sendRoute to take a Map<String, dynamic>? data
      //                                 data: {
      //                                   "data": jsonEncode(
      //                                       searchMealModel!.meals![index])
      //                                 });
      //                           },
      //                           child: Card(
      //                             child: Row(
      //                               children: [
      //                                 Image.network(
      //                                   searchMealModel!.meals![index].strMealThumb!,
      //                                   height: 30.h,
      //                                 ),
      //                                 Expanded(
      //                                   child: Text(
      //                                     searchMealModel!.meals![index].strMeal!,
      //                                     style: TextStyle(fontSize: 20.sp),
      //                                   ),
      //                                 )
      //                               ],
      //                             ),
      //                           ),
      //                         );
      //                       }),
      //                 )
      //               : recipeModel != null
      //                   ? Expanded(
      //                       child: ListView.builder(
      //                           itemCount: recipeModel!.categories!.length,
      //                           itemBuilder: (context, index) {
      //                             return GestureDetector(
      //                               onTap: () {
      //                                 // encoding the index and sending it to next page as encoded json from this screen inside Map data
      //                                 sendRoute(
      //                                     context, RoutesNames.recipedetail,
      //                                     // this is build inside sendRoute to take a Map<String, dynamic>? data
      //                                     data: {
      //                                       "data": jsonEncode(
      //                                           recipeModel!.categories![index])
      //                                     });
      //                               },
      //                               child: Card(
      //                                 child: Row(
      //                                   children: [
      //                                     Image.network(
      //                                       recipeModel!.categories![index]
      //                                           .strCategoryThumb!,
      //                                       height: 30.h,
      //                                     ),
      //                                     Text(
      //                                       recipeModel!.categories![index]
      //                                           .strCategory!,
      //                                       style: TextStyle(fontSize: 20.sp),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ),
      //                             );
      //                           }),
      //                     )
      //                   : const Center(child: CircularProgressIndicator())
      //         ],
      //       ),
      //     )),
    );
  }
}
