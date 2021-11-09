import 'package:intl/intl.dart';

class User {
  String? name;
  String? email;
  String? phonenumber;
  String? countrycode;
  String? updated_on;
  User(this.name, this.email, this.phonenumber, this.countrycode,
      this.updated_on);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        countrycode = json['countrycode'],
        phonenumber = json['phonenumber'],
        updated_on=json['updated_on']??DateFormat('EEE, MMM d, ''yy').format(DateTime.now()).toString();

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'countrycode': countrycode,
        'phonenumber': phonenumber,
        'updated_on':updated_on
      };
}
