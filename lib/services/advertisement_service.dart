import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:samsow/models/advertisment.dart';
import 'package:uuid/uuid.dart';

class AdvertisementService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Uuid uuid = Uuid();
  //method to create an advertisement
  Future createAdvertisement(Advertisement advertisement, File file) async {
    var taskSnapshotUpload1;
    String downloadUrl1 = '';
    try {
      final firebaseStorageTask = _firebaseStorage
          .ref('advertisement')
          .child('${_firebaseAuth.currentUser.email}')
          .child(advertisement.advertName);
      taskSnapshotUpload1 = await firebaseStorageTask.putFile(file);
      downloadUrl1 = await taskSnapshotUpload1.ref.getDownloadURL();

      var id = uuid.v4();
      //store product in cloud fire store with its picture represented by the ulr from firebase storage
      final result =
          await _firebaseFirestore.collection('advertisements').doc(id).set({
        'advertId': id,
        'advertName': advertisement.advertName,
        'advertDescription': advertisement.advertDescription,
        'advertImage': downloadUrl1,
        'advertStatus': advertisement.status,
        'advertPeriod': 0,
      });
      return result;
    } catch (e) {
      return null;
    }
  }

  Stream<List<Advertisement>> getAllAdvertisement(){
    try {
      return _firebaseFirestore.collection('advertisements').snapshots()
          .map((snapshot) => snapshot.docs
          .map((document) => Advertisement.fromCloud(document.data()))
          .toList()
      );
    } catch (e) {
      return null;
    }
  }
}
