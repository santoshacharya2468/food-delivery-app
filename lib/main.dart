import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodsNepal/bloc/auth/auth_bloc.dart';
import 'package:foodsNepal/bloc/cart/cartitem_bloc.dart';
import 'package:foodsNepal/bloc/category/categorybloc_bloc.dart';
import 'package:foodsNepal/bloc/product/product_bloc.dart';
import 'package:foodsNepal/bloc/product_gategory/productwithcategorybloc_bloc.dart';
import 'package:foodsNepal/conf.dart';
import 'package:foodsNepal/screens/order_screen.dart';
import 'package:foodsNepal/screens/shopping_cart.dart';
import 'package:foodsNepal/widgets/appbar.dart';
import 'package:foodsNepal/widgets/productview.dart';
import 'bloc/order/orderBloc.dart';
import 'widgets/categoryview.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => CategoryblocBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
          create: (context) => CartitemBloc(),
        ),
        BlocProvider(
          create: (context) => ProductwithcategoryblocBloc(),
        ),
         BlocProvider(
          create: (context) => OrderBloc(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
          primaryColor: Colors.teal,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = new TabController(length: tabs.length,vsync: this);
    BlocProvider.of<ProductBloc>(context).add(ProductLoadEvent());
    BlocProvider.of<CategoryblocBloc>(context).add(CategoryLoadEvent());
    BlocProvider.of<AuthBloc>(context).add(InitializeAuth());
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
final List<String> tabs=['Home','Cart',"Orders"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(appName),
          leading: IconButton(icon: Icon(Icons.person_pin), onPressed: () {
            Navigator.pushNamed(context, "profile");
          }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchData());
              },
            )
          ],
          bottom: TabBar(
            onTap: (index){
            },
            controller: tabController,
            indicatorColor:Colors.white,
            
            tabs:tabs.map((e) => Text(e,style: TextStyle(fontSize: 18.0),)).toList(),
            ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          HomeScreen(),
          ShoppingCard(),
          OrderScreen(),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize=MediaQuery.of(context).size;
    return Container(
      height:deviceSize.height,
      width: deviceSize.width,
      child: Column(
        children: <Widget>[
          BlocBuilder<CategoryblocBloc,CategoryblocState>(
            builder: (context,state){
              if(state is CategoryLoadingState){
               return CategoryShimmer();
              }
              else if(state is CategoryLoadedState){
              //    return CategoryShimmer();
              return CategoryView(categories:state.categories);
              }
              else{
                return CategoryShimmer();
              }
            },
          ),
          BlocBuilder<ProductBloc,ProductState>(
            builder:(context,state){
              if(state is ProductLoadingState){
                return Expanded(child: ProductShimmerView());
              }
              else if(state is ProductLoadedState){
               // return Expanded(child: ProductShimmerView());
                return Expanded(
                  //height: deviceSize.height-100,
                  child:
                   ProductView(state.products)
                   );
              }
              else{
                return Expanded(child: ProductShimmerView());

              }
            } ,)

        ],
      ),
    );
  }

}
