part of 'cartitem_bloc.dart';

@immutable
abstract class CartitemEvent {}
class LoadCart extends CartitemEvent{}
class AddToCart extends CartitemEvent{
  final Product newProduct;
  AddToCart({this.newProduct});
}
class ClearCart extends CartitemEvent{}
class RemoveFromCart extends CartitemEvent{
  final Product oldProduct;
  RemoveFromCart({this.oldProduct});
}
