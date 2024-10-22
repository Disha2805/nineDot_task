
import 'dart:convert';

SignUpResModel signUpResModelFromJson(String str) => SignUpResModel.fromJson(json.decode(str));

String signUpResModelToJson(SignUpResModel data) => json.encode(data.toJson());

class SignUpResModel {
  Data? data;
  bool? status;
  String? message;

  SignUpResModel({
    this.data,
    this.status,
    this.message,
  });

  factory SignUpResModel.fromJson(Map<String, dynamic> json) => SignUpResModel(
    data: Data.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "status": status,
    "message": message,
  };
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? emailId;
  int? otp;
  String? token;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.emailId,
    this.otp,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    emailId: json["email_id"],
    otp: json["otp"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email_id": emailId,
    "otp": otp,
    "token": token,
  };
}
