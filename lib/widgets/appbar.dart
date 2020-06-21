import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodsNepal/bloc/product/product_bloc.dart';
import 'package:foodsNepal/widgets/productview.dart';
import '../conf.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Text(appName),
    leading: IconButton(icon: Icon(Icons.person_pin), onPressed: (){
    }),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(context: context, delegate: SearchData());
        },
      )
    ],
  );
}

class SearchData extends SearchDelegate<String> {
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoadedState) {
        final resutls = state.products
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return ProductView(resutls);
      } else {
        return Container();
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoadedState) {
        final resutls = state.products
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return ListView.builder(
          itemCount: resutls != null ? resutls.length : 0,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                query = resutls[index].name;
              },
              title: Text(resutls[index].name),
            );
          },
        );
      } else {
        return Container();
      }
    });
  }
}
