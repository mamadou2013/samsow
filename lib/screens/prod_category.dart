import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:samsow/models/product.dart';
import 'package:samsow/route/router.gr.dart';
class ProductOfCategory extends StatelessWidget {
  final List<Product> prods;

  ProductOfCategory({this.prods});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          elevation: 0.0,
          leading: IconButton(
            onPressed:() {ExtendedNavigator.root.push(Routes.myHome);},
            icon: Icon(Icons.arrow_back,color: Colors.white,),
          ),
          title: Text('List of your favorite products'),
          centerTitle: true,
        ),
        body: (this.prods == null) ? Center(child: CircularProgressIndicator())
            :Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: ListView.builder(
                itemCount: this.prods.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: Image.network('${this.prods[index].productPicture2}'),
                      ),
                      title:  Text('${this.prods[index].productName}',style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                      trailing:FlatButton(
                        onPressed: (){

                        },
                        child: Text('Buy the Product',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                      ),
                      subtitle: Text('${this.prods[index].productNewPrice}',style: (
                          TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      onTap: (){
                        ExtendedNavigator.root.push(Routes.productDetail,
                          arguments: ProductDetailArguments(product: prods[index])
                        );
                      },
                    ),
                  );
                },
              ),
            )
        )
    );
  }
}
