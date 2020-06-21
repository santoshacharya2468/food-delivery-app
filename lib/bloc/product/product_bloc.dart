import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:foodsNepal/models/product.dart';
import 'package:meta/meta.dart';

import '../../conf.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  @override
  ProductState get initialState => ProductInitial();
  List<Product> products;
  @override
  Stream<ProductState> mapEventToState(

    ProductEvent event,
  ) async* {
    if (event is ProductLoadEvent) {
      if (products != null) {
        yield ProductLoadedState(products: products);
      } else {
        yield ProductLoadingState();
        Dio dio = Dio(BaseOptions(headers: {
          "apikey": apiKey,
        }, validateStatus: (status) => true, baseUrl: baseUrl));
        //make http request to server
        try {
          var response = await dio.get("products");
          if (response.statusCode == 200) {
            List<Product> tproducts = new List<Product>();
            for (var cat in response.data) {
              tproducts.add(Product.fromJson(cat));
            }
            products = tproducts;
            yield ProductLoadedState(products: products);
          } else {
            //yield ProductLoadingErrorState();
          }
        } catch (e) {}
      }
    }
  }
}
