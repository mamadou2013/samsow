import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samsow/models/advertisment.dart';
import 'package:samsow/services/advertisement_service.dart';

class MyCarousel extends StatelessWidget {
  List<Advertisement> adverts;
  final AdvertisementService advertisementService = AdvertisementService();
  @override
  Widget build(BuildContext context) {
    adverts = Provider.of<List<Advertisement>>(context);
    return (adverts == null)
        ? Center(child: CircularProgressIndicator())
        : Container(
            //width: 150.0,
            //height: 150.0,
            child: Carousel(
                boxFit: BoxFit.cover,
                dotSize: 5.0,
                autoplayDuration: Duration(milliseconds: 7000),
                dotBgColor: Colors.grey[300].withOpacity(0.6),
                dotColor: Colors.white,
                dotIncreasedColor: Colors.redAccent,
                images: displayImages()),
          );
  }

  List<Image> displayImages() {
    List<Image> images = [];
    adverts.forEach((element) {
      Image image = Image.network('${element.advertImage}',
          fit: BoxFit.fitWidth,
          height: 180.0,
          //scale: 0.5,
          filterQuality: FilterQuality.high);
      images.add(image);
    });
    return images;
  }
}
