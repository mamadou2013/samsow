import 'package:auto_route/auto_route.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samsow/models/product.dart';
import 'package:samsow/models/rate.dart';
import 'package:samsow/route/router.gr.dart';
import 'package:samsow/screens/similar_product.dart';
import 'package:samsow/services/product_service.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({@required this.product});
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ProductService productService = ProductService();

  Map product ={};

  String _quantity = 'quantity';
  Map sizes = {};
  Map colors = {};
  String _sizes = 'size';
  String _colors = 'color';
  int starMoyen = 0;
  int rate = 0;

  @override
  void initState() {
    getRate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    sizes = this.widget.product.sizes;
    colors = this.widget.product.colors;

    return Container(
      color: Colors.grey[100],
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
               ExtendedNavigator.root.pop();
              },
            ),
            title: Text(
              'Detail of product',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: (product == null ) ? Center(child: CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 5.0,
            progressColor: Colors.redAccent,
          )
          )
              :ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 3.0, top: 3.0, right: 3.0),
                    height: 150,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: Carousel(
                          boxFit: BoxFit.cover,
                          dotSize: 3.0,
                          autoplayDuration: Duration(milliseconds: 7000),
                          dotBgColor: Colors.transparent,
                          images: [
                            Image.network('${this.widget.product.productPicture1}'),
                            Image.network('${this.widget.product.productPicture2}'),
                            Image.network('${this.widget.product.productPicture3}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100.0,
                    padding: EdgeInsets.only(left: 1.0, top: 3.0, right: 3.0),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(
                          '${this.widget.product.productPicture2}',
                          width: 70.0,
                          height: 100,
                        ),
                        title: Text('${this.widget.product.productName}'),
                        trailing: Text(
                          '25%',
                          style: TextStyle(
                              color: Colors.redAccent, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('\$${this.widget.product.productOldPrice}'),
                            ),
                            Expanded(
                              child: Text(
                                '\$${this.widget.product.productNewPrice}',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Description:'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 1.0, top: 3.0, right: 3.0),
                    child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${this.widget.product.productDescription}'),
                        )
                    ),
                  ),

                Card(
                   child: new Container(
                        padding: EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.favorite,color: Colors.redAccent,size: 30.0,),
                              onPressed: ()async{
                                final result = await productService.likeProduct(this.widget.product.productId);
                                if(result == null){
                                  Fluttertoast.showToast(
                                      msg: 'The product is added to your favorite',
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white
                                  );
                                  print('success !');
                                }else{
                                  Fluttertoast.showToast(
                                      msg: 'Network error, please try again later',
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white
                                  );
                                  print('error !');
                                }
                              },
                              color: Colors.red,
                            )
                          ],
                        )
                    ),
                 ),
                  Container(
                    padding: EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 0.0),
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Choose your own below',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 5.0, 3.0, 2.0),
                              child: DropdownButton(
                                items: buildSizes(sizes),
                                hint: Text('$_sizes'),
                                onChanged: (value) {
                                  setState(() {
                                    _sizes = value;
                                  });
                                },
                              )),
                            ),
                            Expanded(
                              child: new Padding(
                                padding: EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 2.0),
                                child: DropdownButton(
                                  items: buildColors(colors),
                                  hint: Text('$_colors'),
                                  onChanged: (value) {
                                    setState(() {
                                      _colors = value;
                                    });
                                  },
                                )
                              ),
                            ),
                            Expanded(
                              child: new Padding(
                                padding: EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 2.0),
                                child: DropdownButton(
                                  items: buildQuantyties(5),
                                  hint: Text('$_quantity'),
                                  onChanged: (value) {
                                    setState(() {
                                      _quantity = value;
                                    });
                                  },
                                )
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 5.0),
                    child: Text(
                      'Similar products',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  SimilarProduct(category: this.widget.product.category,)
                ],
              ),
        persistentFooterButtons: [

        FlatButton.icon(
          icon: Icon(Icons.add_shopping_cart),
          onPressed: () async {
            final Product prod= Product(
                productId: product['id'],
                productName: product['name'],
                productOldPrice: '',
                productNewPrice: product['price'],
                productPicture1: '',
                productPicture2: '',
                productPicture3: '',
                productDescription: '',
                productQtite: product['quantity'],
                ownerEmail: product['email']
            );
            if(prod != null){
             final status = await productService.checkProductStatus(prod.productId);
              if(status){
                productService.orderProduct(prod, int.parse(_quantity),_sizes, _colors);
                Fluttertoast.showToast(
                    msg: 'We receive your request and will deliver your product very soon',
                    backgroundColor: Colors.green,
                    textColor: Colors.white
                );
                ExtendedNavigator.root.push(Routes.myHome);
              }else{
                Fluttertoast.showToast(
                    msg: 'This product is not available currently so we will check and let you know',
                    backgroundColor: Colors.green,
                    textColor: Colors.white
                );
                ExtendedNavigator.root.push(Routes.myHome);
              }
            }else{
              Fluttertoast.showToast(
                  msg: 'Network error, please try again later',
                  backgroundColor: Colors.green,
                  textColor: Colors.white
              );
              ExtendedNavigator.root.push(Routes.myHome);
            }
          },
          color: Colors.redAccent,
          textColor: Colors.white,
          label: Text(
            'Add to cart',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
          FlatButton.icon(
            color:Colors.redAccent,
            icon: Icon(Icons.phone, color: Colors.white),
            label: Text('Call',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 20.0),),
            onPressed: () {},
          ),
          FlatButton.icon(
            color:Colors.redAccent,
            icon: Icon(Icons.message_outlined, color: Colors.white),
            label: Text('WhatsApp',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 20.0),),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> buildSizes(Map listSizes) {
    List<DropdownMenuItem<String>> items =[];
    listSizes.forEach((key, value) {
        items.add(
          DropdownMenuItem(
            value: value,
            child: Text('$value'),
          )
        );
    });
    return items;
  }

  List<DropdownMenuItem<String>> buildColors(Map listColors) {
    List<DropdownMenuItem<String>> items =[];
    listColors.forEach((key, value) {
      items.add(
          DropdownMenuItem(
            value: value,
            child: Text('$value'),
          )
      );
    });
    //print(items.length);
    return items;
  }

  List<DropdownMenuItem<String>> buildQuantyties(int i) {
    List<DropdownMenuItem<String>> items =[];
    for(int j =1 ; j<=i; j++){
      items.add(
          DropdownMenuItem(
            value: j.toString(),
            child: Text('$j'),
          )
      );
    }
    //print(items.length);
    return items;
  }

  void getRate() async{
    await _getRate();
  }

  _getRate() async{
    List<Rate> rateList = await productService.getRate(this.widget.product.productId);
    rateList.forEach((element) {
      starMoyen += element.starNumber;
    });
    rate = rateList.length;
    starMoyen = starMoyen ~/ rate;
  }


}



