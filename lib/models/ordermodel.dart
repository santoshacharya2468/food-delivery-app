
import 'package:foodsNepal/models/product.dart';

class Order{
  int status;
  int quantity;
  Product product;
  Order.fromJson(Map<String,dynamic>order){
    this.status=order['status'];
    this.quantity=order["quantity"];
    if (this.quantity==null){
      this.quantity=1;
    }
    this.product=Product.fromJson(order['product']);
  }
  
}