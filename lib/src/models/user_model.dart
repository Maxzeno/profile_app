import 'dart:convert';

const String notAvailable = 'Not Available';

class UserModel {
  final int id;
  final String email;
  final String phone;
  final String username;
  final String address;
  final String image;

  const UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.username,
    required this.address,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return UserModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? notAvailable,
      phone: json['phone'] ?? notAvailable,
      username: json['username'] ?? notAvailable,
      address: json['address'] ?? notAvailable,
      image: json['image'] ?? "",
    );
  }
}

UserModel modelUser(String data) {
  return UserModel.fromJson(jsonDecode(data));
}
