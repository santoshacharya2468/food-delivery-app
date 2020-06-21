import '../conf.dart';

class Product{
  String id;
  String name;
  String descriptions;
  String categoryId;
  int price;
  int quantity;
  int rating;
  List<String> photos;
  Product.fromJson(Map<String,dynamic> map){
    this.id=map['_id'];
    this.name=map['name'];
    this.descriptions=map['descriptions'];
    this.categoryId=map['category'];
    this.price=map['price'];
    this.rating=map['rating'];
    photos=new List<String>();
    try{
    for(var p in map['photos']){
      photos.add(baseUrl+"/products/"+p.toString());
    }
    }
    catch(e){

      photos.add(map['imageUrl']);
      this.quantity=map['quantity'];
    }
  }
  //  "CREATE TABLE carts(id INTEGER PRIMARY KEY,name TEXT,category TEXT,_id TEXT,quantity INT,imageUrl TEXT,price INT,rating INT,descriptions TEXT)");
  Map<String,dynamic> toJson(){
    return {
      "name":this.name,
      "category":this.categoryId,
      "quantity":this.quantity,
      "imageUrl":this.photos[0],
      "price":this.price,
      "rating":this.rating,
      "descriptions":this.descriptions,
      "_id":this.id
    };
  }
}