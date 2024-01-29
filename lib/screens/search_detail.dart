import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/data/model/recipeModel.dart' as RecipeMODEL;

class SearchDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? data;

  SearchDetailScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<SearchDetailScreen> createState() => _SearchDetailScreenState();
}

class _SearchDetailScreenState extends State<SearchDetailScreen> {
  RecipeMODEL.Categories? recipeModel;

  @override
  void initState() {
    super.initState();
    // Decode the data in initState to avoid decoding multiple times
    if (widget.data != null) {
      setState(() {
        recipeModel = RecipeMODEL.Categories.fromJson(
          jsonDecode(widget.data!['data']),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: recipeModel != null
              ? Card(
                  elevation: 4.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        recipeModel!.strCategoryThumb!,
                        width: 0.8.sw,
                        height: 0.3.sh,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        recipeModel!.strCategory!,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        recipeModel!.strCategoryDescription!,
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
