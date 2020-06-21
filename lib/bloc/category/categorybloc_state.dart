part of 'categorybloc_bloc.dart';

@immutable
abstract class CategoryblocState {}
class CategoryblocInitial extends CategoryblocState {}
class CategoryLoadingState extends CategoryblocState{}
class CategoryLoadingErrorState extends CategoryblocState{}
class CategoryLoadedState extends CategoryblocState{
  final List<Category> categories;
   CategoryLoadedState({this.categories});
}
