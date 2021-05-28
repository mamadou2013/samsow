
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:samsow/models/user.dart';
import 'package:test/test.dart';


void main() {
  group('test user service method', (){
    final instance = MockFirestoreInstance();
    test('should register the user', ()async{
      await instance.collection('users').doc('sowdd@gmail.com').set({
        'email': 'sowdd@gmail.com',
        'username': 'Sow',
        'phone': '023355982527',
        'gender': 'male'
      });
    });
    test('should register the user', ()async{
      await instance.collection('users').doc('sowdd20@gmail.com').set({
        'email': 'sowdd20@gmail.com',
        'username': 'Bella',
        'phone': '023355982527',
        'gender': 'female'
      });
    });
    test('should register the user', ()async{
      await instance.collection('users').doc('sowdd2020@gmail.com').set({
        'email': 'sowdd2020@gmail.com',
        'username': 'Mamadou Sow',
        'phone': '023355982527',
        'gender': 'male'
      });
    });

    test('should get the user data',()async{
      final user = await instance.collection('users').get();
      expect(user.docs.length, 3);
      print(user.docs.first.get('email'));
    });
  });

}
