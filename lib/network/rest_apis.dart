// import 'package:storyapp/models/category_model.dart';
// import '../models/story_model.dart';
// import 'end_points.dart';
// import 'network_utils.dart';
//
// Future<List<category_model>> getCategory() async {
//   Iterable it = await (handleResponse(await buildHttpResponse(endPoints.gets_categories, method: HttpMethod.POST)));
//   return it.map((e) => category_model.fromJson(e)).toList();
// }
//
// Future<List<story_model>> getBooks({Map? request, int? page}) async {
//   Iterable it = await (handleResponse(await buildHttpResponse(endPoints.gets_stories, request: request, method: HttpMethod.POST)));
//   return it.map((e) => story_model.fromJson(e)).toList();
// }