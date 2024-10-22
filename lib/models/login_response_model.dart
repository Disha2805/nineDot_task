// To parse this JSON data, do
//
//     final loginResModel = loginResModelFromJson(jsonString);

import 'dart:convert';

LoginResModel loginResModelFromJson(String str) => LoginResModel.fromJson(json.decode(str));

String loginResModelToJson(LoginResModel data) => json.encode(data.toJson());

class LoginResModel {
  Data? data;

  LoginResModel({
    this.data,
  });

  factory LoginResModel.fromJson(Map<String, dynamic> json) => LoginResModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Data {
  int? id;
  int? userType;
  String? firstName;
  String? lastName;
  String? deviceToken;
  String? emailId;
  String? mobileNo;
  dynamic language;
  dynamic profession;
  dynamic visaStatus;
  dynamic expiredDate;
  dynamic qualification;
  dynamic bio;
  dynamic dob;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic nativeCountry;
  dynamic presentCity;
  dynamic presentState;
  dynamic resume;
  dynamic profileImage;
  dynamic bannerImage;
  dynamic lastLogin;
  String? status;
  String? isBlock;
  int? isDeleted;
  int? isPremium;
  String? createdAt;
  String? updatedAt;
  dynamic reason;
  String? token;

  Data({
    this.id,
    this.userType,
    this.firstName,
    this.lastName,
    this.deviceToken,
    this.emailId,
    this.mobileNo,
    this.language,
    this.profession,
    this.visaStatus,
    this.expiredDate,
    this.qualification,
    this.bio,
    this.dob,
    this.countryId,
    this.stateId,
    this.cityId,
    this.nativeCountry,
    this.presentCity,
    this.presentState,
    this.resume,
    this.profileImage,
    this.bannerImage,
    this.lastLogin,
    this.status,
    this.isBlock,
    this.isDeleted,
    this.isPremium,
    this.createdAt,
    this.updatedAt,
    this.reason,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userType: json["user_type"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    deviceToken: json["device_token"],
    emailId: json["email_id"],
    mobileNo: json["mobile_no"],
    language: json["language"],
    profession: json["profession"],
    visaStatus: json["visa_status"],
    expiredDate: json["expired_date"],
    qualification: json["qualification"],
    bio: json["bio"],
    dob: json["dob"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    nativeCountry: json["native_country"],
    presentCity: json["present_city"],
    presentState: json["present_state"],
    resume: json["resume"],
    profileImage: json["profile_image"],
    bannerImage: json["banner_image"],
    lastLogin: json["last_login"],
    status: json["status"],
    isBlock: json["is_block"],
    isDeleted: json["is_deleted"],
    isPremium: json["is_premium"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    reason: json["reason"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_type": userType,
    "first_name": firstName,
    "last_name": lastName,
    "device_token": deviceToken,
    "email_id": emailId,
    "mobile_no": mobileNo,
    "language": language,
    "profession": profession,
    "visa_status": visaStatus,
    "expired_date": expiredDate,
    "qualification": qualification,
    "bio": bio,
    "dob": dob,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
    "native_country": nativeCountry,
    "present_city": presentCity,
    "present_state": presentState,
    "resume": resume,
    "profile_image": profileImage,
    "banner_image": bannerImage,
    "last_login": lastLogin,
    "status": status,
    "is_block": isBlock,
    "is_deleted": isDeleted,
    "is_premium": isPremium,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "reason": reason,
    "token": token,
  };
}
