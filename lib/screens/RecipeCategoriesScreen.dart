import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/routes/route.dart';
import 'package:recipe/utils/common_widget.dart';

import '../Provider/provider_declaration.dart';
import '../data/model/SearchNameModel.dart';
import '../data/model/recipeModel.dart';
import '../provider.dart';

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
// Call the provider to trigger the data fetching
    await ref.read(mainScreenApiData).categoriesData();

    // await ref.read(mainScreenApiData).searchMealData();

    // Use the watch function to access the data from the provider
    // categoryModel = ref.watch(mainScreenApiData).modal;

    // Set the state to trigger a rebuild
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    categoryModel  = ref.watch(mainScreenApiData).modal;
    searchMealModel = ref.watch(searchMealProvider).searchMealModel;
    return  PopScope(
      canPop: false,
      onPopInvoked: (value) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
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
                      onChanged: (p) async {
                        await ref.read(searchMealProvider).searchMealData({'s': searchController.text});

                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(searchMealProvider).searchMealData({'s': searchController.text});
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

  }
}

