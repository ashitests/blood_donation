// To parse this JSON data, do
//
//     final donorModel = donorModelFromJson(jsonString);

import 'dart:convert';

DonorModel donorModelFromJson(String str) =>
    DonorModel.fromJson(json.decode(str));

String donorModelToJson(DonorModel data) => json.encode(data.toJson());

class DonorModel {
  DonorModel({
    this.name,
    this.lastname,
    this.email,
    this.phone,
    this.city,
    this.gender,
    this.bloodType,
    this.profession,
  });

  String name;
  String lastname;
  String email;
  String phone;
  String city;
  String gender;
  String bloodType;
  String profession;

  factory DonorModel.fromJson(Map<String, dynamic> json) => DonorModel(
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        city: json["city"],
        gender: json["gender"],
        bloodType: json["bloodType"],
        profession: json["profession"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "city": city,
        "gender": gender,
        "bloodType": bloodType,
        "profession": profession,
      };
}
