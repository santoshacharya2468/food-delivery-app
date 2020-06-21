
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodsNepal/models/category.dart';
import 'package:foodsNepal/screens/productwithcategory.dart';
import 'package:shimmer/shimmer.dart';
class CategoryView extends StatelessWidget {
  final List<Category> categories;
  CategoryView({this.categories});
  @override
  Widget build(BuildContext context) {
    final deviceSize= MediaQuery.of(context).size;
    return Container(
      height: 100.0,
      width:deviceSize.width,
      child: Card(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories!=null? categories.length:0,
          itemBuilder: (context,index){
            final Category category=categories[index];
            return InkWell(
              onTap: (){
                Navigator.push(
                  context,new MaterialPageRoute(builder:(context)=>ProductWithCategory(category.id)));

              },
              child: Column(
                children: <Widget>[
                  Container(
                    height: 70.0,
                    margin: const EdgeInsets.only(right:5.0),
                    child: CircleAvatar(
                      maxRadius: 35.0,
                      //radius: 40.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: CachedNetworkImageProvider(
                        category.imageUrl,
                      ),
                  
                    ),
                  ),
                  Container(
                    height: 20,
                    child: Text(category.name),
                  )
                ],
              ),
            );

          },
        ),
      ),
      
    );
  }
}
class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize= MediaQuery.of(context).size;
    return Container(
      height: 100.0,
      width:deviceSize.width,
      child: Card(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[350],
          period: Duration(milliseconds:800),
          highlightColor: Colors.grey,
                  child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context,index){
              return Column(
                children: <Widget>[
                  Container(
                    height: 70.0,
                    margin: const EdgeInsets.only(right:5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      maxRadius: 35.0,

                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 7.0,
                    color: Colors.grey,
                    width: 60.0,
                  ),
                  SizedBox(height: 5),
                ],
              );

            },
          ),
        ),
      ),
      
    );
  }
}