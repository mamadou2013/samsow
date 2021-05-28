
import 'package:samsow/shareds/form_field_validat.dart';
import 'package:test/test.dart';

main(){
  group('email test', (){

    test('the empty email', (){
      var emailValid = FormFieldValidate.isEmailValid('');
      expect(emailValid, 'The email is required');

    });

    test('the invalid email', (){
      var emailValid1 = FormFieldValidate.isEmailValid('sow2020@gamail');
      expect(emailValid1, 'Please enter a valid email');
    });

    test('the valid email', (){
      var emailValid1 = FormFieldValidate.isEmailValid('sow2020@gamail.com');
      expect(emailValid1, null);
    });
  });

}