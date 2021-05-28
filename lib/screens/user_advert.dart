import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:samsow/route/router.gr.dart';


class UserAdvertisement extends StatefulWidget {
  @override
  _UserAdvertisementState createState() => _UserAdvertisementState();
}

class _UserAdvertisementState extends State<UserAdvertisement> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        leading: IconButton(
          onPressed:() {ExtendedNavigator.root.push(Routes.myHome);},
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        title: Text('Advertisement'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
        child: Container(
          padding: EdgeInsets.all(5.0),
          color: Colors.green,
          child: Text('Please contact us through this phone number in order to allow us '
              'to do your advertisement: 652312456789',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            color: Colors.white,
          ),
          ),
        )
        /*Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Choose below how do you want to join us :',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 5.0,),
            FlatButton.icon(
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/advert');
              },
              label: Text(
                'Send us an email here',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white
                ),
              ),
              icon: Icon(Icons.email,color: Colors.white,),
              color: Colors.brown[300],
            ),
            SizedBox(height: 5.0,),
            FlatButton.icon(
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/advert');
              },
              label: Text(
                'WhatsApp us here',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white
                ),
              ),
              icon: Icon(Icons.message_outlined,color: Colors.white,),
              color: Colors.brown[300],
            ),
            SizedBox(height: 5.0,),
            FlatButton.icon(
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/advert');
              },
              label: Text(
                'Contact us on messenger ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white
                ),
              ),
              icon: Icon(Icons.messenger,color: Colors.white,),
              color: Colors.brown[300],
            ),
            SizedBox(height: 5.0,),
            FlatButton.icon(
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/advert');
              },
              label: Text(
                'Call us directly here',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white
                ),
              ),
              icon: Icon(Icons.phone,color: Colors.white,),
              color: Colors.brown[300],
            )
          ],
        ),*/
      ),
    );
  }
  /*final _formKey=GlobalKey<FormState>();
  TextEditingController advertName=TextEditingController();
  TextEditingController advertDescription=TextEditingController();
  TextEditingController period=TextEditingController();

  File _image;
  final UserService userService=UserService();
  final AdvertisementService advertisementService = AdvertisementService();

  Future getImage() async {
    print('\n-----inside image picker------');
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          icon: Icon(Icons.close, color: Colors.white,),
        ),
        title: Text('Product Forms'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.grey[200],
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Add a new Product', textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 115.0,
                  child: OutlineButton(
                    borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                    width: 2.5),
                    onPressed: ()async{
                      await getImage();
                    },
                    child: displayChild(),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  cursorColor: Colors.grey,
                  controller: advertName,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.pink, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    return value.isEmpty
                        ? 'The name of the product is required'
                        : null;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  cursorColor: Colors.grey,
                  controller: advertDescription,
                  decoration: InputDecoration(
                    hintText: 'Product Price',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.pink, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    return value.isEmpty
                        ? 'The price of the product is required'
                        : null;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  cursorColor: Colors.grey,
                  controller: period,
                  decoration: InputDecoration(
                    hintText: 'Number of days',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.pink, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {},
                  validator: (value) {
                    return value.isEmpty
                        ? 'Try to give a duration for your advertisement'
                        : null;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),

                Container(
                  width: double.infinity,
                  child: FlatButton(
                      child : Text(
                        'Validate',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0),
                      ),
                      color: Colors.redAccent,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Advertisement ad = Advertisement(
                            '',
                            advertName.text,
                            advertDescription.text,
                            false,
                            '',
                            int.parse(period.text)
                          );
                          advertisementService.createAdvertisement(ad, _image);
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget displayChild() {
    if (_image != null) {
      return Image.file(_image);
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 20.0),
        child: Icon(
          Icons.add_a_photo,
          size: 50.0,
        ),
      );
    }
  }*/
}
