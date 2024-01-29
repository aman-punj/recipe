// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:recipe/features/posts/post_bloc.dart';
// import 'package:recipe/utils/strings.dart';
//
// import '../features/posts/post_bloc.dart';
// import '../features/posts/post_event.dart';
//
// class ApiHomeScreen extends StatefulWidget {
//   const ApiHomeScreen({super.key});
//
//   @override
//   State<ApiHomeScreen> createState() => _ApiHomeScreenState();
// }
//
// class _ApiHomeScreenState extends State<ApiHomeScreen> {
//
//   final PostBloc postBloc = PostBloc();
//
//   @override
//   void initState() {
//     postBloc.add(PostInitialFetchEvent());
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppConstants.appname , style: TextStyle(
//           fontSize: 22.sp
//         ),),
//       ),
//       body: Center(
//         child: ElevatedButton(onPressed: (){} , child: Icon(Icons.add)),
//       ),
//     );
//   }
// }
