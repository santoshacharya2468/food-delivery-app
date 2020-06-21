part of 'productwithcategorybloc_bloc.dart';

@immutable
abstract class ProductwithcategoryblocState {}

class ProductwithcategoryblocInitial extends ProductwithcategoryblocState {}
class ProductWithCategoryLoadingState extends ProductwithcategoryblocState{}
class ProductWithCategoryLoadedState extends ProductwithcategoryblocState{
  final List<Product> products;
  ProductWithCategoryLoadedState(this.products);
}
