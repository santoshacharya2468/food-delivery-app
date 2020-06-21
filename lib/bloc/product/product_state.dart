part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}
class ProductLoadingState extends ProductState{}
class ProductLoadedState extends ProductState{
  final List<Product> products;
  ProductLoadedState({this.products});
}
