// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// // import 'package:http/http.dart' as http;
//
// part 'post_event.dart';
//
// part 'post_state.dart';
//
// class PostBloc extends Bloc<PostEvent, PostState> {
//   PostBloc() : super(PostInitial()) {
//     on<PostInitialFetchEvent>(postInitialFetchEvent);
//   }
//
//   FutureOr<void> postInitialFetchEvent(
//       PostInitialFetchEvent event, Emitter<PostState> emit) async {
//     var client = http.Client();
//     try {
//       var response = await client
//           .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/'));
//       print(response.body);
//     } catch (e) {
//       print(e.toString());
//     }
//     {}
//   }
// }
