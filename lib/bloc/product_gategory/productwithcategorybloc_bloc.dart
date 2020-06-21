import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:foodsNepal/models/product.dart';
import 'package:meta/meta.dart';

import '../../conf.dart';

part 'productwithcategorybloc_event.dart';
part 'productwithcategorybloc_state.dart';

class ProductwithcategoryblocBloc extends Bloc<ProductwithcategoryblocEvent, ProductwithcategoryblocState> {
  @override
  ProductwithcategoryblocState get initialState => ProductwithcategoryblocInitial();
  @override
  Stream<ProductwithcategoryblocState> mapEventToState(
    ProductwithcategoryblocEvent event,
  ) async* {
    if (event is LoadProductWithCategory ) {
        yield ProductWithCategoryLoadingState();
        Dio dio = Dio(BaseOptions(headers: {
          "apikey": apiKey,
        }, validateStatus: (status) => true, baseUrl: baseUrl));
        //make http request to server
        try {
          var response = await dio.get("products/"+event.categoryId);
          if (response.statusCode == 200) {
            List<Product> tproducts = new List<Product>();
            for (var cat in response.data) {
              tproducts.add(Product.fromJson(cat));
            }
            yield ProductWithCategoryLoadedState(tproducts);
          } else {
            //yield ProductLoadingErrorState();
          }
        } catch (e) {}
      }
    }
}
