import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samsow/models/product.dart';
import 'package:samsow/route/router.gr.dart';
import 'package:samsow/services/product_service.dart';
import 'package:transparent_image/transparent_image.dart';

class SimilarProduct extends StatefulWidget {

  final String category;
  SimilarProduct({this.category});

  @override
  _SimilarProductState createState() => _SimilarProductState();
}

class _SimilarProductState extends State<SimilarProduct> {
  final ProductService productService = ProductService();
  List<Product> products;
  List<Product> product;



  @override
  Widget build(BuildContext context) {
    product = Provider.of<List<Product>>(context);
    products = getProducts(product);
    return Container(
      height: 300.0,
      child:(products == null) ? Center(child: CircularProgressIndicator(
        backgroundColor: Colors.redAccent,
      ))
          : GridView.builder(
          itemCount: products.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5.0,crossAxisSpacing: 5.0),
          itemBuilder: (context, index) {
            return Card(
                borderOnForeground: true,
                child: Material(
                  child: InkWell(
                    onTap: () {
                     ExtendedNavigator.root.push(Routes.productDetail,
                         arguments: ProductDetailArguments(product: products[index])
                     );
                    },
                    child: GridTile(
                      child: ListTile(
                        trailing: Container(
                          color: Colors.redAccent,
                          child: Text(
                            '-25%',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        title: Stack(
                          children: <Widget>[
                            Center(child: CircularProgressIndicator()),
                            FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: '${products[index].productPicture2}',
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                      footer: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${products[index].productName}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 8.0, 2.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '\$${products[index].productOldPrice}'.toString(),
                                    style: TextStyle(decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                                Text(
                                  '\$${products[index].productNewPrice}'.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            );
          }),
    );
  }

  List<Product> getProducts(List<Product> prod){
    List<Product> p = [];
    for(int i = 0; i<prod.length; i++){
      if(this.widget.category == prod[i].category){
        //print(prod[i].productName);
        p.add(prod[i]);
      }
    }
    //print(p.length);
    return p;
  }

}
