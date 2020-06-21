part of 'productwithcategorybloc_bloc.dart';

@immutable
abstract class ProductwithcategoryblocEvent {}
class LoadProductWithCategory extends ProductwithcategoryblocEvent{
 final  String categoryId;
  LoadProductWithCategory(this.categoryId);

}
