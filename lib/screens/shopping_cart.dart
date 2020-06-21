import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodsNepal/bloc/auth/auth_bloc.dart';
import 'package:foodsNepal/bloc/cart/cartitem_bloc.dart';
import 'package:foodsNepal/bloc/order/orderBloc.dart';
import 'package:foodsNepal/models/product.dart';
import 'package:foodsNepal/services/dbservice.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCard extends StatefulWidget {
  @override
  _ShoppingCardState createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {
  @override
  void initState() {
    BlocProvider.of<CartitemBloc>(context).add(LoadCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return BlocBuilder<CartitemBloc, CartitemState>(builder: (context, state) {
      if (state is CartLoadedState) {
        if (state.products == null || state.products.length == 0) {
          return Center(child: Text("No  items are addded to your cart"));
        }
        return BlocListener<OrderBloc,OrderState>(
          listener: (context,orderState){
            if(orderState is OrderMakingState){
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please wait processing.."),));
            }
            else if(orderState is OrderSuccesState){
              BlocProvider.of<CartitemBloc>(context).add(ClearCart());
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Order Success"),backgroundColor: Colors.green[400],));

            }
            else if(orderState is OrderFailedState){
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(orderState.messagae),backgroundColor: Colors.red,));
            }
          },
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    height: 35.0,
                    width: 150.0,
                   // margin: const EdgeInsets.only(left: 5),
                    child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, authstate) {
                      return RaisedButton(
                          // color: Colors.teal,
                          color: Theme.of(context).primaryColor,
                          child: Center(
                              child: Text(
                            "Order Now",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          )),
                          onPressed: () {
                            if (authstate is AuthLoggedInState) {
                              BlocProvider.of<OrderBloc>(context).add(
                                  MakeOrder(orders: state.products, token: authstate.user.token));
                            } else {
                              Navigator.pushNamed(context, "login");
                            }
                          });
                    }),
                  ),
                  Container(
                    height: 35.0,
                    width: 150.0,
                    color: Theme.of(context).primaryColor,
                    child: Builder(builder: (context){
                      int price=0;
                      for(var p in state.products){
                        price+=p.price*p.quantity;
                      }
                      return Center(child:Text("Total Rs:$price",style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 20.0,
                        
                      ),));

                    }),
                  )
                  // Text("Total:rs")
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.products != null ? state.products.length : 0,
                  itemBuilder: (context, index) {
                    Product product = state.products[index];
                    return Container(
                        height: 120.0,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          height: 100.0,
                          margin: EdgeInsets.all(5.0),
                          width: deviceSize.width - 10,
                          color: Colors.blueGrey,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl: product.photos[0],
                                    height: 120.0,
                                    width: 120.0,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Image.asset(
                                      "assets/images/loading.gif",
                                      height: 120.0,
                                      width: 120.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      ListTile(
                                          title: Text(
                                              "${product.name}(${product.quantity}) items"),
                                          subtitle: Text(
                                              "${product.price}*${product.quantity}=Rs:${product.price * product.quantity}"),
                                          trailing: IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                              ),
                                              onPressed: () async {
                                                var dbService =
                                                    DatabaseService.instance;
                                                try {
                                                  await dbService
                                                      .deleteItemsFromCart(
                                                          product);
                                                  BlocProvider.of<CartitemBloc>(
                                                          context)
                                                      .add(RemoveFromCart(
                                                          oldProduct: product));
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text("Item removed"),
                                                  ));
                                                } catch (e) {
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Error removing item"),
                                                  ));
                                                }
                                              })),
                                    ],
                                  ),
                                )
                              ]),
                        ));
                  },
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
