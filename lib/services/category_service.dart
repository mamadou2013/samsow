import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:samsow/models/category.dart';

class CategoryService {
  final FirebaseFirestore database = FirebaseFirestore.instance;
  //get all categories from fire store
  Stream<List<Category>> getAllCategories() {
    try{
      return database.collection('category').snapshots()
          .map((snapshot) => snapshot.docs
          .map((document) => Category.fromCloud(document.data()))
          .toList()
      );
    }catch(er){
      return null;
    }
  }
}
