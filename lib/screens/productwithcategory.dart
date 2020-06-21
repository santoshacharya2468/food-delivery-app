import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodsNepal/bloc/product_gategory/productwithcategorybloc_bloc.dart';
import 'package:foodsNepal/widgets/productview.dart';
import 'package:foodsNepal/conf.dart';
import 'package:google_fonts/google_fonts.dart';
class ProductWithCategory extends StatefulWidget {
  final String categoryId;
  ProductWithCategory(this.categoryId);
  @override
  _ProductWithCategoryState createState() => _ProductWithCategoryState();
}

class _ProductWithCategoryState extends State<ProductWithCategory> {
  @override
  void initState() {
    BlocProvider.of<ProductwithcategoryblocBloc>(context)
        .add(LoadProductWithCategory(widget.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(appName,style: GoogleFonts.lato(),)
      ),
      body: BlocBuilder<ProductwithcategoryblocBloc,
        ProductwithcategoryblocState>(builder: (context, state) {
      if (state is ProductWithCategoryLoadingState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is ProductWithCategoryLoadedState) {
        return ProductView(state.products);
      } else {
        return Center(child: Icon(Icons.error_outline));
      }
    })
    );
  }
}
