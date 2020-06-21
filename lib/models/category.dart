import '../conf.dart';

class Category{
  String id;
  String name;
  String imageUrl;
  Category.fromJson(Map<String,dynamic> map){
    this.id=map['_id'];
    this.name=map['name'];
    this.imageUrl=baseUrl+"categories/"+map['photo'];
  }
}