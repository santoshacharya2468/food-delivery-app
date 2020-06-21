import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodsNepal/bloc/auth/auth_bloc.dart';
import 'package:foodsNepal/conf.dart';
import 'package:foodsNepal/models/ordermodel.dart';
class OrderScreen extends StatelessWidget {
  Future<List<Order>> getOrders(String token)async{
    List<Order> orders=new List<Order>();
    Dio dio=Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          "apikey":apiKey,
          "Authorization":token
        }
      )
    );
      var response=await dio.get("orders");
      if(response.statusCode==200){
        
        for(var order in response.data){
          orders.add(Order.fromJson(order));
        }
      }
      return orders;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(
     builder: (context,state){
       if(state is AuthLoggedInState){
         return FutureBuilder(
           future: getOrders(state.user.token),
           builder: (context,AsyncSnapshot<List<Order>> snapshot){
             if(snapshot.connectionState==ConnectionState.done){
               if(snapshot.data.length==0){
                 return Center(child: Text("You have no orders"),);
               }
               else{
                 return ListView.builder(
                  //  reverse: true,
                   itemCount: snapshot.data.length,
                   itemBuilder: (context,int index){
                     final Order order=snapshot.data[index];
                     return Container(
                       height: 120.0,
                       color: Colors.blueGrey,
                       margin: EdgeInsets.symmetric(vertical:2.0),
                       width: MediaQuery.of(context).size.width,
                       child: Column(
                         children: <Widget>[
                           
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Container(
                               height: 120.0,
                              width:120,
                               child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                 imageUrl: order.product.photos[0],
                                 placeholder: (context,ulr)=>Image.asset("assets/images/loading.gif",fit:BoxFit.cover)
                                 ),
                             ),
                                           Container(
                                             height:120.0,
                                             width: MediaQuery.of(context).size.width-120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              ListTile(
                                  title: Text(
                                      "${order.product.name}(${order.quantity}) items"),
                                  subtitle: Text("${order.product.price}*${order.quantity}=Rs:${order.product.price*order.quantity}"),

                                      ),
                                      renderOrderStatus(order.status)

                            ],
                          ),
                        )

                           ],)
                       ],),
                     );
                   },
                 );
               }

             }
             else{
               return Center(child:CircularProgressIndicator());
             }
           },
           );

       }
       else{
         return Center(
           child: Container(
             height: 45.0,
             width: 200.0,
             child: RaisedButton(
               color:Theme.of(context).primaryColor,
               child:Text("Login to continue",
               style:TextStyle(color: Colors.white,fontSize:20.0)
               ),
               onPressed: (){
                 Navigator.pushNamed(context, 'login');
               },
               ),
           ),
         );
         
       }
       
     },
      
    );
  }
Widget renderOrderStatus(int status) {
  switch (status) {
    case 0:
      return Container(
          height: 40.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.deepOrange,
                Colors.orangeAccent,
              ]),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(8.0), right: Radius.circular(8.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text("Order is ready to deliver",style: TextStyle(color:Colors.white)),
              ),
             
            ],
          ));
      break;
    case 1:
      return Container(
          height: 40.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.purple,
                Colors.purpleAccent,
              ]),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(8.0), right: Radius.circular(8.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text("Order Placed",style: TextStyle(color:Colors.white),),
              ),
             
            ],
          ));
      break;
    case 2:
      return Container(
          height: 40.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.greenAccent,
                ],
              ),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(8.0), right: Radius.circular(8.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text("Order Success",style: TextStyle(color:Colors.white)),
              ),
             
            ],
          ));
      break;
    default:
      return Text("Unknown",style: TextStyle(color:Colors.white));
  }
}
}