import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:samsow/models/product.dart';
import 'package:samsow/route/router.gr.dart';
import 'package:samsow/screens/carousel.dart';
import 'package:samsow/screens/category.dart';
import 'package:samsow/screens/product.dart';
import 'package:samsow/screens/shop.dart';
import 'package:samsow/services/product_service.dart';
import 'package:samsow/services/user_service.dart';

List<Product> searchProduct =[];
List<String> recentSearch = [];
List<Product> suggestions = [];

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int selectedIndex = 0;
  final ProductService productService = ProductService();
  final UserService userService = UserService();

  @override
  void initState(){
    getRecentSearchProduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    searchProduct = Provider.of<List<Product>>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        title: Text('SamSow'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchProduct());
            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart, color: Colors.white),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 5.0),
        color: Colors.grey[100],
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
              child: Container(
                  height: 180.0,
                  child: MyCarousel()
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 0.0),
              child: FlatButton(
                onPressed: (){
                    ExtendedNavigator.root.push(Routes.userAdvertisement);
                },
                child: Text(
                  'Do your advertisement here',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white
                  ),
                ),
                color: Colors.redAccent,
              )
            ),
            Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 0.0),
              child: Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
            ),
            Container(
              height: 80.0,
              child: ProductCategory(),
            ),
            Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 0.0),
              child: Text(
                'Products',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 0.0),
              child: Products(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 3.0),
        child: BottomNavigationBar(
          selectedItemColor: Colors.redAccent,
          iconSize: 20.0,
          currentIndex: selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop_two),
              label: 'Shops',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
          onTap: (index) async{
            setState(() {
              selectedIndex = index;
            });
            switch (selectedIndex) {
              case 0:
                ExtendedNavigator.root.push(Routes.myHome);
                break;
              case 1:
                final List<String> shop = await userService.getShops();
                if(shop != null){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context)=> Shop(shops: shop,)
                  ));
                }else{
                  Fluttertoast.showToast(
                      msg: 'Network error, please rty again later',
                    backgroundColor: Colors.green,
                    textColor: Colors.white
                  );
                }
                break;
              case 2:
                ExtendedNavigator.root.push(Routes.userHome);
                break;
            }
          },
        ),
      ),
    );
  }
  Future getRecentSearchProduct() async {
    recentSearch.clear();
    suggestions.clear();
    recentSearch = await productService.searchSuggestion();
    if(recentSearch.isNotEmpty){
      recentSearch.forEach((element) {
        _fetchData(element);
      });
    }
  }

  Future _getRecentProduct(String productId) async{
    Product prod = await productService.getProduct(productId);
    suggestions.add(prod);
  }

  Future _fetchData(String id) async{
    await _getRecentProduct(id);
  }
}

class SearchProduct extends SearchDelegate {
  List<Product> lsitProducts = searchProduct;
  Product _product;
  final ProductService productService = ProductService();

  @override
  List<Widget> buildActions(BuildContext context) {
    // getRecentSearchProduct();
    return [
      IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.blueGrey,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.blueGrey,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.network('${_product.productPicture2}'),
            ),
            title:  Text('${_product.productName}',style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
            trailing:FlatButton(
              onPressed: (){
                ExtendedNavigator.root.push(Routes.productDetail,
                    arguments: ProductDetailArguments(product: _product)
                );
              },
              child: Text('Buy the Product',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),),
              color: Colors.redAccent,
              textColor: Colors.white,
            ),
            subtitle: Text('${_product.productNewPrice}',style: (
                TextStyle(fontWeight: FontWeight.bold)),
            ),
            onTap: (){
            },
          ),
        )
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> prods = query.isEmpty ?
                    suggestions :
                    lsitProducts.where((element) => element.productName.startsWith(query)).toList();
    return ListView.builder(
        itemCount: prods.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
                _product = prods[index];
                query = prods[index].productName;
                showResults(context);
                await productService.createSearchHistory('${prods[index].productId}');
            },
            leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.network('${prods[index].productPicture2}')
            ),
            title: RichText(text: TextSpan(
                text: prods[index].productName.substring(0, query.length),
                style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                    text: prods[index].productName.substring(query.length),
                    style: TextStyle(color: Colors.grey)
                )
              ]
            ),),
            trailing: Text('${prods[index].productNewPrice}'),
          );
        });
  }

}
