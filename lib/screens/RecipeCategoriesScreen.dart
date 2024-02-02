import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/routes/route.dart';
import 'package:recipe/utils/common_widget.dart';

import '../Provider/provider_declaration.dart';
import '../bloc/CategoryBloc.dart';
import '../bloc/SearchMealBloc.dart';
import '../data/model/SearchNameModel.dart';
import '../data/model/recipeModel.dart';

class RecipeHomeScreen extends ConsumerStatefulWidget {
  const RecipeHomeScreen({super.key});

  @override
  ConsumerState<RecipeHomeScreen> createState() => _RecipeHomeScreenState();
}

class _RecipeHomeScreenState extends ConsumerState<RecipeHomeScreen> {
  // CategoryBloc? categoryBloc;
  CategoryModel? categoryModel;
  // SearchMealBloc? searchMealBloc;
  SearchMealModel? searchMealModel;
  bool onAppClose = false;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // categoryBloc = BlocProvider.of<CategoryBloc>(context);
    // searchMealBloc = BlocProvider.of<SearchMealBloc>(context);
    // calling bloc events
    // categoryBloc!.add(FetchCategoryEvent(data: {}));

    initView();
  }

  initView() async{

    await ref.read(mainScreenApiData).categoriesData({});
    await ref.read(mainScreenApiData).searchMealData({});

  }

  // void _showBackDialog() {
  //   showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Are you sure?'),
  //         content: const Text(
  //           'Are you sure you want to leave this App?',
  //         ),
  //         actions: [
  //           TextButton(
  //             style: TextButton.styleFrom(
  //               textStyle: Theme.of(context).textTheme.labelLarge,
  //             ),
  //             child: const Text('Nevermind'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //           TextButton(
  //             style: TextButton.styleFrom(
  //               textStyle: Theme.of(context).textTheme.labelLarge,
  //             ),
  //             child: const Text('Leave'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    categoryModel  = ref.watch(mainScreenApiData).modal;
    return  PopScope(
      canPop: false,
      onPopInvoked: (value) {
        showDialog(
            context: context,
            builder: (BuildContext contaxt) {
              return AlertDialog(
                title: const Text('Exit?'),
                content: const Text("Do you want to exit app?"),
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        onbackpress(context, isdialog: true);
                        await SystemChannels.platform
                            .invokeListMethod<void>('SystemNavigator.pop');
                      },
                      child: const Text('Yes')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No')),
                ],
              );
            });
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Recipes Categories',
            style: TextStyle(fontSize: 20.sp),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  sendRoute(context, RoutesNames.likedrecipe);
                },
                icon: const Icon(Icons.favorite_outlined))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: text_form_field(
                      'Search',
                      searchController,
                      onChanged: (p0) {
                        // searchMealBloc?.add(FetchSearchMealEvent(
                        //     data: {'s': searchController.text}));
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () {
                      // searchMealBloc?.add(
                      //   FetchSearchMealEvent(
                      //       data: {'s': searchController.text}),
                      // );
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
              else if (categoryModel != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: categoryModel!.categories!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          sendRoute(
                            context,
                            RoutesNames.searchMealdetail,
                            data: {
                              "data": jsonEncode(
                                categoryModel!.categories![index],
                              ),
                            },
                          );
                        },
                        child: Card(
                          child: Row(
                            children: [
                              Image.network(
                                categoryModel!
                                    .categories![index].strCategoryThumb!,
                                height: 30.h,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                categoryModel!.categories![index].strCategory!,
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
    );
    // return MultiBlocListener(
    //   listeners: [
    //     BlocListener<CategoryBloc, CategoryState>(
    //       listener: (context, state) {
    //         if (state is CategoryLoadingState) {
    //           toast('loading');
    //         } else if (state is CategoryLoadedState) {
    //           setState(() {
    //             categoryModel = state.categoryModel;
    //           });
    //         }
    //       },
    //     ),
    //     BlocListener<SearchMealBloc, SearchMealState>(
    //       listener: (context, state) {
    //         if (state is SearchMealLoadingState) {
    //           toast('searching');
    //         } else if (state is SearchMealLoadedState) {
    //           setState(() {
    //             searchMealModel = state.searchMealModel;
    //           });
    //         }
    //       },
    //     ),
    //   ],
    //
    //   // PopScope(
    //   //   canPop: false,
    //   //   onPopInvoked: (bool didPop) {
    //   //     if (didPop) {
    //   //       return;
    //   //     }
    //   //     _showBackDialog();
    //   //   },
    //   //   child: TextButton(
    //   //     onPressed: () {
    //   //       _showBackDialog();
    //   //     },
    //   //     child: const Text('Go back'),
    //   //   ),
    //   // ),
    //   child: PopScope(
    //     canPop: false,
    //     onPopInvoked: (value) {
    //       showDialog(
    //           context: context,
    //           builder: (BuildContext contaxt) {
    //             return AlertDialog(
    //               title: Text('Exit?'),
    //               content: Text("Do you want to exit app?"),
    //               actions: [
    //                 ElevatedButton(
    //                     onPressed: () async {
    //                       onbackpress(context, isdialog: true);
    //                       await SystemChannels.platform
    //                           .invokeListMethod<void>('SystemNavigator.pop');
    //                     },
    //                     child: Text('Yes')),
    //                 ElevatedButton(
    //                     onPressed: () {
    //                       Navigator.pop(context);
    //                     },
    //                     child: Text('No')),
    //               ],
    //             );
    //           });
    //     },
    //     child: Scaffold(
    //       appBar: AppBar(
    //         automaticallyImplyLeading: false,
    //         title: Text(
    //           'Recipes Categories',
    //           style: TextStyle(fontSize: 20.sp),
    //         ),
    //         actions: [
    //           IconButton(
    //               onPressed: () {
    //                 sendRoute(context, RoutesNames.likedrecipe);
    //               },
    //               icon: Icon(Icons.favorite_outlined))
    //         ],
    //       ),
    //       body: Padding(
    //         padding: const EdgeInsets.all(10.0),
    //         child: Column(
    //           // crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Expanded(
    //                   child: text_form_field(
    //                     'Search',
    //                     searchController,
    //                     onChanged: (p0) {
    //                       searchMealBloc?.add(FetchSearchMealEvent(
    //                           data: {'s': searchController.text}));
    //                     },
    //                   ),
    //                 ),
    //                 SizedBox(width: 10.w),
    //                 ElevatedButton(
    //                   onPressed: () {
    //                     searchMealBloc?.add(
    //                       FetchSearchMealEvent(
    //                           data: {'s': searchController.text}),
    //                     );
    //                   },
    //                   child: const Icon(Icons.search),
    //                 ),
    //               ],
    //             ),
    //             SizedBox(height: 20.h),
    //             if (searchMealModel != null)
    //               Expanded(
    //                 child: ListView.builder(
    //                   itemCount: searchMealModel!.meals!.length,
    //                   itemBuilder: (context, index) {
    //                     return GestureDetector(
    //                       onTap: () {
    //                         sendRoute(
    //                           context,
    //                           RoutesNames.recipedetail,
    //                           data: {
    //                             "data": jsonEncode(
    //                               searchMealModel!.meals![index],
    //                             ),
    //                           },
    //                         );
    //                       },
    //                       child: Card(
    //                         child: Row(
    //                           children: [
    //                             Image.network(
    //                               searchMealModel!.meals![index].strMealThumb!,
    //                               height: 30.h,
    //                             ),
    //                             SizedBox(width: 10.w),
    //                             Expanded(
    //                               child: Text(
    //                                 searchMealModel!.meals![index].strMeal!,
    //                                 style: TextStyle(fontSize: 20.sp),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                 ),
    //               )
    //             else if (categoryModel != null)
    //               Expanded(
    //                 child: ListView.builder(
    //                   itemCount: categoryModel!.categories!.length,
    //                   itemBuilder: (context, index) {
    //                     return GestureDetector(
    //                       onTap: () {
    //                         sendRoute(
    //                           context,
    //                           RoutesNames.searchMealdetail,
    //                           data: {
    //                             "data": jsonEncode(
    //                               categoryModel!.categories![index],
    //                             ),
    //                           },
    //                         );
    //                       },
    //                       child: Card(
    //                         child: Row(
    //                           children: [
    //                             Image.network(
    //                               categoryModel!
    //                                   .categories![index].strCategoryThumb!,
    //                               height: 30.h,
    //                             ),
    //                             SizedBox(width: 10.w),
    //                             Text(
    //                               categoryModel!.categories![index].strCategory!,
    //                               style: TextStyle(fontSize: 20.sp),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                 ),
    //               )
    //             else
    //               const Center(child: CircularProgressIndicator()),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    //
    //   // Scaffold(
    //   //     appBar: AppBar(
    //   //       title: Text(
    //   //         'Recipes',
    //   //         style: TextStyle(fontSize: 20.sp),
    //   //       ),
    //   //     ),
    //   //     body: Padding(
    //   //       padding: const EdgeInsets.all(10.0),
    //   //       child: Column(
    //   //         children: [
    //   //           Row(
    //   //             children: [
    //   //               Expanded(child: text_form_field('search', searchController)),
    //   //               ElevatedButton(onPressed: () {
    //   //                 searchMealBloc?.add(FetchSearchMealEvent(data: {'s': searchController.text }));
    //   //               }, child: Icon(Icons.search))
    //   //             ],
    //   //           ),
    //   //           SizedBox(
    //   //             height: 20.h,
    //   //           ),
    //   //           searchMealModel != null
    //   //               ? Expanded(
    //   //                   child:
    //   //                   ListView.builder(
    //   //                       itemCount: searchMealModel!.meals!.length,
    //   //                       itemBuilder: (context, index) {
    //   //                         return GestureDetector(
    //   //                           onTap: () {
    //   //                             // encoding the index and sending it to next page as encoded json from this screen inside Map data
    //   //                             sendRoute(context, RoutesNames.recipedetail,
    //   //                                 // this is build inside sendRoute to take a Map<String, dynamic>? data
    //   //                                 data: {
    //   //                                   "data": jsonEncode(
    //   //                                       searchMealModel!.meals![index])
    //   //                                 });
    //   //                           },
    //   //                           child: Card(
    //   //                             child: Row(
    //   //                               children: [
    //   //                                 Image.network(
    //   //                                   searchMealModel!.meals![index].strMealThumb!,
    //   //                                   height: 30.h,
    //   //                                 ),
    //   //                                 Expanded(
    //   //                                   child: Text(
    //   //                                     searchMealModel!.meals![index].strMeal!,
    //   //                                     style: TextStyle(fontSize: 20.sp),
    //   //                                   ),
    //   //                                 )
    //   //                               ],
    //   //                             ),
    //   //                           ),
    //   //                         );
    //   //                       }),
    //   //                 )
    //   //               : categoryModel != null
    //   //                   ? Expanded(
    //   //                       child: ListView.builder(
    //   //                           itemCount: categoryModel!.categories!.length,
    //   //                           itemBuilder: (context, index) {
    //   //                             return GestureDetector(
    //   //                               onTap: () {
    //   //                                 // encoding the index and sending it to next page as encoded json from this screen inside Map data
    //   //                                 sendRoute(
    //   //                                     context, RoutesNames.recipedetail,
    //   //                                     // this is build inside sendRoute to take a Map<String, dynamic>? data
    //   //                                     data: {
    //   //                                       "data": jsonEncode(
    //   //                                           categoryModel!.categories![index])
    //   //                                     });
    //   //                               },
    //   //                               child: Card(
    //   //                                 child: Row(
    //   //                                   children: [
    //   //                                     Image.network(
    //   //                                       categoryModel!.categories![index]
    //   //                                           .strCategoryThumb!,
    //   //                                       height: 30.h,
    //   //                                     ),
    //   //                                     Text(
    //   //                                       categoryModel!.categories![index]
    //   //                                           .strCategory!,
    //   //                                       style: TextStyle(fontSize: 20.sp),
    //   //                                     )
    //   //                                   ],
    //   //                                 ),
    //   //                               ),
    //   //                             );
    //   //                           }),
    //   //                     )
    //   //                   : const Center(child: CircularProgressIndicator())
    //   //         ],
    //   //       ),
    //   //     )),
    // );
  }
}

