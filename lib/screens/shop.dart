import 'package:flutter/material.dart';
class Shop extends StatelessWidget {
  final List<String> shops;

  Shop({this.shops});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          elevation: 0.0,
          leading: IconButton(
            onPressed:() {Navigator.pop(context);},
            icon: Icon(Icons.arrow_back,color: Colors.white,),
          ),
          title: Text('List of shops and supermarket'),
          centerTitle: true,
        ),
        body: (this.shops == null) ? Center(child: CircularProgressIndicator())
            :Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: ListView.builder(
                itemCount: this.shops.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.shop,color: Colors.brown,)
                      ),
                      title:  Text('${this.shops[index]}',style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                      trailing:Text(
                        'Anything you need search it'
                      )
                    ),
                  );
                },
              ),
            )
        )
    );
  }
}
