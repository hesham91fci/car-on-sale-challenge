import 'package:car_on_sale_challenge/base/base_model.dart';

class User extends BaseModel<User> {
  final String? firstName;
  final String? lastName;
  final String? email;

  User({this.firstName, this.lastName, this.email});

  @override
  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
  };
}
