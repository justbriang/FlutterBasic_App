import 'package:email_validator/email_validator.dart';

class Validation{
    final RegExp nameRegExp = RegExp('[a-zA-Z]');
      final RegExp telregExp =
      RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

   checker (String? label, var value){
    switch(label){
      case 'Email':
        if (value.isEmpty) {
          return 'Please write something in $label';
        } else {
          return EmailValidator.validate(value) ? null : 'Enter a valid email';
        }
      case 'Name':
        if (value.isEmpty) {
          return 'Please write something in $label';
        } else if (value.length < 4) {
          return 'Name is too short, ';
        } else {
          return (nameRegExp.hasMatch(value)) ? null : 'Enter a valid name';
        }
 
      case 'Phonenumber':
        if (value.isEmpty) {
          return 'Please write something in $label';
        } else {
          return (telregExp.hasMatch(value))
              ? null
              : 'Enter a valid Phone Number';
        }
      
    }
  }
}