// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:fooddelivery/models/product.dart';
// import 'package:fooddelivery/widgets/appbar.dart';
// class ProductDetail extends StatefulWidget {
//   final Product product;
//   ProductDetail(this.product);
//   @override
//   _ProductDetailState createState() => _ProductDetailState();
// }

// class _ProductDetailState extends State<ProductDetail> {
//   int itemSelected = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: Container(

//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Hero(
//                 tag: widget.product.name,
//                 child: CarouselSlider(
//                   options: CarouselOptions(
//                     height: 200,
//                     aspectRatio: 2.0,
//                     viewportFraction: 1,
//                     initialPage: 0,
//                     enableInfiniteScroll: true,
//                     reverse: false,
//                     autoPlay: true,
//                     autoPlayInterval: Duration(seconds: 3),
//                     autoPlayAnimationDuration: Duration(milliseconds: 800),
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     enlargeCenterPage: true,
//                     scrollDirection: Axis.horizontal,
//                   ),
//                   items: widget.product.photos
//                       .map((e) => CachedNetworkImage(
//                             imageUrl: e,
//                             fit: BoxFit.cover,
//                           ))
//                       .toList(),
//                 ),
//               ),
//               ClayContainer(
//                 spread: 2.0,
//                 curveType: CurveType.convex,
//                               child: Container(
//                   height: MediaQuery.of(context).size.height-200,
//                   decoration: BoxDecoration(
//                   //  color: Colors.teal,
//                     // borderRadius: BorderRadius.only(
//                     //   topLeft:Radius.circular(30.0),
//                     //   topRight:Radius.circular(30.0), 
//                     //   )
//                   ),
//                   child: Column(
           
//                     children: <Widget>[
//                       Text(
//                         widget.product.name,
//                         style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         "Rs" + widget.product.price.toString(),
//                         style: TextStyle(fontSize: 20.0),
//                       ),
//                       Text(
//                         widget.product.descriptions,
//                         style: TextStyle(fontSize: 18.0),
//                       ),
//                       SizedBox(
//                         height: 15.0,
//                       ),
//                       Padding(
//                           padding: const EdgeInsets.only(left: 0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: <Widget>[
//                               Text(
//                                 ' Quantity:',
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                               Container(
//                                 color: Colors.black87,
//                                 height: 30,
//                                 width: 50,
//                                 child: FlatButton(
//                                   child: Center(
//                                       child: Icon(
//                                     Icons.remove,
//                                     color: Colors.white,
//                                   )),
//                                   splashColor: Colors.grey,
//                                   onPressed: () {
//                                     setState(() {
//                                       if (itemSelected < 2) {
//                                       } else {
//                                         itemSelected--;
//                                       }
//                                     });
//                                   },
//                                 ),
//                               ),
//                               Text(
//                                 '$itemSelected',
//                                 style: TextStyle(
//                                     fontSize: 30, fontWeight: FontWeight.bold),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 7),
//                                 color: Colors.black87,
//                                 height: 30,
//                                 width: 50,
//                                 child: FlatButton(
//                                   child: Center(
//                                       child: Icon(
//                                     Icons.add,
//                                     color: Colors.white,
//                                   )),
//                                   splashColor: Colors.grey,
//                                   onPressed: () {
//                                     setState(() {
//                                       itemSelected++;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           )),
//                     ],
//                   ),
//                 ),
//               ),

//               // Container(
//               //   height: 50.0,
//               //   width: 200.0,
//               //  color: Colors.grey,
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.center,
//               //     children:[
//               //      IconButton(icon: Icon(Icons.remove),onPressed:itemSelected>1? (){
//               //         setState(() {
//               //           itemSelected-=1;
//               //         });
//               //       }:null,),
//               //        IconButton(icon: Text(itemSelected.toString()),onPressed: (){},),
//               //       IconButton(icon: Icon(Icons.add),onPressed: (){
//               //         setState(() {
//               //           itemSelected+=1;
//               //         });
//               //       },)

//               //     ]
//               //   ),
//               // ),
//               Divider()
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             RaisedButton(
//               child: Text("Order Now"),
//               onPressed: () {
                
//               },
//               color: Colors.teal,
//             ),
//             RaisedButton(
//               child: Text("Add to Cart"),
//               onPressed: () {},
//               color: Colors.indigo,
//             ),
//             RaisedButton(
//               child: Text("Inquery"),
//               onPressed: () {},
//               color: Colors.amber,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
