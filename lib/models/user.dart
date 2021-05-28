class Users {
  final String username;
  final String email;
  final String phone;


  Users({this.username, this.email, this.phone});

  //this method turn a map to an object
  Users.fromFirestore(Map<String, dynamic> firestore)
      : username = firestore['name'],
        email = firestore['email'],
        phone = firestore['phone'];

}
