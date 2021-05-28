class Product {
  final String productId;
  final String productName;
  final String productOldPrice;
  final String productNewPrice;
  final String productQtite;
  final String productPicture1;
  final String productPicture2;
  final String productPicture3;
  final String productDescription;
  final String ownerEmail;
  final String category;
  final Map sizes;
  final Map colors;



  Product(
      {this.productId,
        this.productName,
        this.productOldPrice,
        this.productNewPrice,
        this.productQtite,
        this.productPicture1,
        this.productPicture2,
        this.productPicture3,
        this.productDescription,
        this.ownerEmail,
        this.category,
        this.sizes,
        this.colors});

  //this method will turn the map fetch from cloud fire store to a product
  Product.fromFirestore(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        productName = firestore['productName'],
        productOldPrice = firestore['productOldPrice'],
        productNewPrice = firestore['productNewPrice'],
        productQtite = firestore['quantity'],
        productPicture1 = firestore['productPicture1'],
        productPicture2 = firestore['productPicture2'],
        productPicture3 = firestore['productPicture3'],
        productDescription = firestore['description'],
        ownerEmail = firestore['emailPartner'],
        category = firestore['category'],
        sizes = firestore['sizes'],
        colors = firestore['colors'];
}
