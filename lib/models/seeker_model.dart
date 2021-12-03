// To parse this JSON data, do
//
//     final seekerModel = seekerModelFromJson(jsonString);

import 'dart:convert';

SeekerModel seekerModelFromJson(String str) =>
    SeekerModel.fromJson(json.decode(str));

String seekerModelToJson(SeekerModel data) => json.encode(data.toJson());

class SeekerModel {
  SeekerModel({
    this.name,
    this.lastname,
    this.email,
    this.phone,
    this.city,
    this.gender,
    this.profession,
  });

  String name;
  String lastname;
  String email;
  String phone;
  String city;
  String gender;
  String profession;

  factory SeekerModel.fromJson(Map<String, dynamic> json) => SeekerModel(
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        city: json["city"],
        gender: json["gender"],
        profession: json["profession"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "city": city,
        "gender": gender,
        "profession": profession,
      };
}
