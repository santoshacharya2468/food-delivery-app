import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodsNepal/bloc/cart/cartitem_bloc.dart';
import 'package:foodsNepal/models/product.dart';
import 'package:foodsNepal/services/dbservice.dart';
class ProductView extends StatefulWidget {
  final List<Product> products;
  ProductView(this.products);
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: false,
      itemCount: widget.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (MediaQuery.of(context).size.width / 2)/200,
        ),
        itemBuilder:(context,index) {
          Product p=widget.products[index];
          return Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width / 2 - 10,
            // margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Container(
                    height: 100.0,
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    child: Hero(
                      tag: p.name,
                      child: CachedNetworkImage(
                          imageUrl: p.photos[0],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(
                              "assets/images/loading.gif",
                              fit: BoxFit.cover)),
                    )
                    ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  padding: EdgeInsets.only(left:5.0),
                  child: Text(
                    p.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                RatingBar(
                  initialRating: p.rating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Text(" Rs:${p.price}",
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
                Container(
                  height: 30.0,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(15.0))
                  // ),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text("Add to cart",
                          style: TextStyle(color: Colors.white)),
                    ),
                    onPressed: () async {
                      p.quantity = 1;
                      showaDialog(context,p);
                    },
                  ),
                ),
              ],
            )),
          );
        });
  }
  showaDialog(context,Product p){
    var ctx=context;
 showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                                  builder: (context, setState) {
                              
                                    return CupertinoAlertDialog(
                                    title:
                                        Center(child: Text("Add item to cart")),
                                    content: Container(
                                    //  height: 100.0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(p.name),
                                           Text(p.descriptions),
                                           SizedBox(height:10),
                                           
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Container(
                                                    color: Colors.black87,
                                                    height: 30,
                                                    width: 50,
                                                    child: FlatButton(
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      )),
                                                      splashColor: Colors.grey,
                                                      onPressed: p.quantity < 2
                                                          ? null
                                                          : () {
                                                              setState(() {
                                                                p.quantity--;
                                                              });
                                                              // setState(() {
                                                              //   if (itemSelected < 2) {
                                                              //   } else {
                                                              //     itemSelected--;
                                                              //   }
                                                              // });
                                                            },
                                                    ),
                                                  ),
                                                  Text(
                                                    '${p.quantity.toString()}',
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7),
                                                    color: Colors.black87,
                                                    height: 30,
                                                    width: 50,
                                                    child: FlatButton(
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      )),
                                                      splashColor: Colors.grey,
                                                      onPressed: () {
                                                        setState(() {
                                                          p.quantity++;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )),
                                              
                                        ],
                                      ),
                                    ),
                                    
                                    actions: <Widget>[
                                      CupertinoButton(
                                            onPressed: ()async {
                                              var dbService = DatabaseService.instance;
                                             await dbService.insertIntoCart(p);
                                             //first close snackbar if showing;
                                             Scaffold.of(ctx).hideCurrentSnackBar();
                                              Scaffold.of(ctx).showSnackBar(
                                                SnackBar(content:Text("Item added to cart"),
                                                backgroundColor: Colors.green[400],
                                                duration: Duration(seconds:1),
                                                ));
                                                BlocProvider.of<CartitemBloc>(context).add(AddToCart(newProduct:p));
                                               Navigator.pop(context);
                                            },
                                            child: Center(child: Text("Ok")
                                            ),
                                      ),
                                      CupertinoButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Center(child: Text("Cancel"))),
                                    ],
                                  );
                                  },
                                ));
  }
}
class ProductShimmerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        
      
        childAspectRatio: (MediaQuery.of(context).size.width / 2)/200,
        ),
        itemBuilder:(context,index) {
          return Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width / 2 - 10,
            // margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Card(
                child: Column(
             
              children: <Widget>[
                Container(
                      height: 116.0,
                      color: Colors.grey,
                     
                      width: MediaQuery.of(context).size.width / 2 - 10,
                      child: Image.asset("assets/images/ripple.gif",fit:BoxFit.cover,),
                              ),
                // Container(
                //   width: MediaQuery.of(context).size.width / 2 - 10,
                //   height: 16.0,
                //   //color: Colors.grey,
                 
                // ),
                RatingBar(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                  onRatingUpdate: (rating) {
                   
                  },
                ),
                Container(
                      height: 20.0,
                    ),
                Container(
                  height: 30.0,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(15.0))
                  // ),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Text("",
                          style: TextStyle(color: Colors.white)),
                    ),
                  onPressed: null,
                  ),
                ),
              ],
            )),
          );
        });
  }
}
