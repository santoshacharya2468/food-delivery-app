import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:foodsNepal/models/category.dart';
import 'package:meta/meta.dart';

import '../../conf.dart';

part 'categorybloc_event.dart';
part 'categorybloc_state.dart';

class CategoryblocBloc extends Bloc<CategoryblocEvent, CategoryblocState> {
  @override
  CategoryblocState get initialState => CategoryblocInitial();
  List<Category> categories;
  @override
  Stream<CategoryblocState> mapEventToState(
    CategoryblocEvent event,
  ) async* {
    if (event is CategoryLoadEvent) {
      if (categories != null) {
        yield CategoryLoadedState(categories: categories);
      } else {
        yield CategoryLoadingState();
        Dio dio = Dio(BaseOptions(headers: {
          "apikey": apiKey,
        }, validateStatus: (status) => true, baseUrl: baseUrl));
        //make http request to server
        try {
          var response = await dio.get("categories");
          if (response.statusCode == 200) {
            List<Category> tcategories = new List<Category>();
            for (var cat in response.data) {
              tcategories.add(Category.fromJson(cat));
            }
            categories = tcategories;
            yield CategoryLoadedState(categories: categories);
          } else {
            yield CategoryLoadingErrorState();
          }
        } catch (e) {}
      }
    }
  }
}
