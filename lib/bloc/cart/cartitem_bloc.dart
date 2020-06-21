import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foodsNepal/models/product.dart';
import 'package:foodsNepal/services/dbservice.dart';
import 'package:meta/meta.dart';

part 'cartitem_event.dart';
part 'cartitem_state.dart';

class CartitemBloc extends Bloc<CartitemEvent, CartitemState> {
  @override
  CartitemState get initialState => CartLoadingState();
  List<Product> products;
  @override
  Stream<CartitemState> mapEventToState(
    CartitemEvent event,
  ) async* {
    if (event is LoadCart) {
      if (products != null) {
        yield CartLoadedState(products: products);
      } else {
        yield CartLoadingState();
        var dbService = DatabaseService.instance;
        var result = await dbService.getCartItems();
        products = result;
        yield CartLoadedState(products: products);
      }
    } 
    else if(event is ClearCart){
      products=null;
      yield CartLoadedState(products: products);
    }
    else if (event is AddToCart) {
      if (products != null) {
        products.add(event.newProduct);
        yield CartLoadedState(products: products);
      } else {
        var productss = new List<Product>();
        products = productss;
        products.add(event.newProduct);
        yield CartLoadedState(products: products);
      }
    } else if (event is RemoveFromCart) {
      products.remove(event.oldProduct);
      yield CartLoadedState(products: products);
    }
  }
}
