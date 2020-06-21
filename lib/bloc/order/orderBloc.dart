import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodsNepal/models/product.dart';
import 'package:foodsNepal/services/dbservice.dart';

import '../../conf.dart';

abstract class OrderEvent {}

class MakeOrder extends OrderEvent {
  List<Product> orders;
  String token;
  MakeOrder({this.orders, this.token});
}

abstract class OrderState {}

class OrderMakingState extends OrderState {}

class OrderSuccesState extends OrderState {}

class OrderFailedState extends OrderState {
  String messagae;
  OrderFailedState({this.messagae});
}

class OrderInitialState extends OrderState {}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  @override
  OrderState get initialState => OrderInitialState();

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is MakeOrder) {
      yield OrderMakingState();
      try {
        //{product:[{id:1,quanitity:4}]} this format of order should be post to server
        Dio dio = Dio(BaseOptions(
            baseUrl: baseUrl,
            validateStatus:(s)=> true,
            headers: {"apikey": apiKey, "Authorization": event.token}));
        List<Map<String, dynamic>> data = new List<Map<String, dynamic>>();
        for (var p in event.orders) {
          data.add({"product": p.id, "quantity": p.quantity});
        }
        var result = await dio.post("orders", data: data);
        if (result.statusCode == 201) {
          yield OrderSuccesState();
          var dbservice=DatabaseService.instance;
          for(var p in event.orders){
            dbservice.deleteItemsFromCart(p);
          }
        } else {
          yield OrderFailedState(messagae: "Order failed");
        }
      } catch (e) {
        yield OrderFailedState(messagae: "Internet Error");
      }
    } else {
      yield OrderInitialState();
    }
  }
}
