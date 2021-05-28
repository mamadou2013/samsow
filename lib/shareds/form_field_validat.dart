import 'package:flux_validator_dart/flux_validator_dart.dart';

class FormFieldValidate {
  static final RegExp re = RegExp(r'^[a-zA-Z0-9]+$');

  static String isFieldValid(String value, String fieldName){
    if(value.isEmpty){
      return 'The '+fieldName+' is required';
    }else if(value.contains(" ")){
      return null;
    }else if(!re.hasMatch(value)){
      return 'Try to enter a valid '+fieldName+' please!';
    }
    return  null;
  }

  static String isEmailValid(String email){
    if(email.isEmpty){
      return 'The email is required';
    }else if(Validator.email(email)){
      return 'Please enter a valid email';
    }else{
      return null;
    }
  }

  static String isPasswordValid(String password, [String passwordConfirm]){
    if (password.isEmpty) {
      return 'the password is required';
    } else if(password.length < 8 ){
      return 'the password must have at least 8 characters';
    }else if (passwordConfirm != null && passwordConfirm.compareTo(password) != 0) {
      return 'please give the same password';
    } else {
      return null;
    }
  }

}