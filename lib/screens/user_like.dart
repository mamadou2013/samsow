
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samsow/models/like.dart';
import 'package:samsow/models/product.dart';
import 'package:samsow/route/router.gr.dart';
import 'package:samsow/services/user_service.dart';

class MyLike extends StatelessWidget {

  final UserService userService = UserService();
  final List<Like> likes;

  MyLike(this.likes);

  @override
  Widget build(BuildContext context) {
    final List<Product> products = Provider.of<List<Product>>(context);
    List<Product> prod = getProductsLikes(products);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          elevation: 0.0,
          leading: IconButton(
            onPressed:() {ExtendedNavigator.root.push(Routes.userHome);},
            icon: Icon(Icons.arrow_back,color: Colors.white,),
          ),
          title: Text('List of your favorite products'),
          centerTitle: true,
        ),
        body: (prod == null) ? Center(child: CircularProgressIndicator())
            :Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: ListView.builder(
                itemCount: prod.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: Image.network('${prod[index].productPicture2}'),
                      ),
                      title:  Text('${prod[index].productName}',style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      trailing:FlatButton(
                        onPressed: (){
                         ExtendedNavigator.root.push(Routes.productDetail,
                           arguments: ProductDetailArguments(product: prod[index])
                         );
                        },
                        child: Text('Buy the Product',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      ),
                      subtitle: Text('${prod[index].productNewPrice}',style: (
                          TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      onTap: (){
                      },
                    ),
                  );
                },
              ),
            )
        )
    );
  }

  List<Product> getProductsLikes(List<Product> prod) {
    List<Product> products =[];
    for(int i = 0; i < this.likes.length; i++){
      for(int j = 0; j < prod.length; j++){
        if(this.likes[i].productId == prod[j].productId){
          products.add(prod[j]);
          break;
        }
      }
    }
    return products;
  }
}
