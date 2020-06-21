part of 'cartitem_bloc.dart';

@immutable
abstract class CartitemState {}

class CartLoadingState extends CartitemState {}
class CartLoadedState extends CartitemState{
  final List<Product> products;
  CartLoadedState({this.products});
}
