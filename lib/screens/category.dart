import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:samsow/models/category.dart';
import 'package:samsow/models/product.dart';
import 'package:samsow/screens/category_detail.dart';
import 'package:samsow/services/product_service.dart';

class ProductCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Category> category = Provider.of<List<Category>>(context);
    final ProductService productService = ProductService();
    final List<CircleAvatar> icons = [
      CircleAvatar(
        backgroundColor: Colors.brown,
        child: Icon(Icons.smartphone,color: Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.phone_iphone,color:Colors.white),
     ),
      CircleAvatar(
        backgroundColor: Colors.black54,
        child: Icon(Icons.laptop,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.accessibility,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.devices_other,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.people,color:Colors.lightBlue),
      ),
      CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.accessibility_sharp,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.cyan,
        child: Icon(Icons.tv_outlined,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.people_outline,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.local_cafe,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(Icons.food_bank_outlined,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.grey[400],
        child: Icon(Icons.local_drink,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.brown[400],
        child: Icon(Icons.hourglass_top,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.deepOrangeAccent[200],
        child: Icon(Icons.watch,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.black54,
        child: Icon(Icons.headset,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.night_shelter,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.brown,
        child: Icon(Icons.add_shopping_cart_sharp,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.lightGreenAccent,
        child: Icon(Icons.format_underline_outlined,color:Colors.white),
      ),
      CircleAvatar(
        backgroundColor: Colors.pinkAccent,
        child: Icon(Icons.sports_hockey_outlined,color:Colors.white),
      ),
    ];

    return (category == null )? Center(child: CircularProgressIndicator())
        :ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
            itemBuilder: (context, index) {
              return Container(
                 width: 100.0,
                 child: InkWell(
                    onTap: () async{
                      final List<Product> prods =
                            await productService.getProductCategory(category[index].categoryName);
                      if(prods.isNotEmpty){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context)=> CategoryDetail(products: prods,)
                        ));
                      }else{
                        Fluttertoast.showToast(
                            msg: 'This category has not been used yet',
                            backgroundColor: Colors.green,
                            textColor: Colors.white
                        );
                      }
                    },
                    child: ListTile(
                        title: icons[index],
                        subtitle: Text(
                            '${category[index].categoryName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey
                              ),
                        ),
                 ),
              ),
          );
        });
  }
}

