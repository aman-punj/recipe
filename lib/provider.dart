

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Provider/provider_declaration.dart';

final mainScreenApiData = ChangeNotifierProvider<RecipeResponseProvider>((ref) {
  return RecipeResponseProvider();
});

final searchMealProvider = ChangeNotifierProvider<RecipeResponseProvider>((ref) {
  return RecipeResponseProvider();
});