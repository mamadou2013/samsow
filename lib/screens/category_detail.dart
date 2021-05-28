import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:samsow/models/product.dart';
import 'package:samsow/route/router.gr.dart';

class CategoryDetail extends StatelessWidget {
  final List<Product> products;

  CategoryDetail({this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color:Colors.white),
            onPressed: (){
              ExtendedNavigator.root.pop();
            }
        ),
        title: Text("${this.products.first.category} categories available",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body:  Container(
        color: Colors.grey[200],
        padding: EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 2.0),
        height: 300.0,
        child:(this.products == null) ? Center(child: CircularProgressIndicator(
          backgroundColor: Colors.redAccent,
        ))
            : GridView.builder(
            itemCount: this.products.length,
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
                          title: (this.products[index].productPicture2 == null ) ? Center(child: CircularProgressIndicator())
                              :Image.network(
                            '${this.products[index].productPicture2}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        footer: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${this.products[index].productName}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 8.0, 2.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '\$${this.products[index].productOldPrice}'.toString(),
                                      style: TextStyle(decoration: TextDecoration.lineThrough),
                                    ),
                                  ),
                                  Text(
                                    '\$${this.products[index].productNewPrice}'.toString(),
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
                  ));
            }),
      ),

    );
  }
}

