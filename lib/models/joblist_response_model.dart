import 'dart:convert';

JobListResponseModel jobListResponseModelFromJson(String str) => JobListResponseModel.fromJson(json.decode(str));

String jobListResponseModelToJson(JobListResponseModel data) => json.encode(data.toJson());

class JobListResponseModel {
  int? totalJobs;
  int? todayOpeningJob;
  List<JobType>? jobTypes;
  List<StateWise>? stateWise;
  List<Datum>? data;
  int? unreadNotificationCount;
  String? message;
  bool? status;

  JobListResponseModel({
    this.totalJobs,
    this.todayOpeningJob,
    this.jobTypes,
    this.stateWise,
    this.data,
    this.unreadNotificationCount,
    this.message,
    this.status,
  });

  factory JobListResponseModel.fromJson(Map<String, dynamic> json) => JobListResponseModel(
    totalJobs: json["total_jobs"],
    todayOpeningJob: json["today_opening_job"],
    jobTypes: List<JobType>.from(json["job_types"].map((x) => JobType.fromJson(x))),
    stateWise: List<StateWise>.from(json["state_wise"].map((x) => StateWise.fromJson(x))),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    unreadNotificationCount: json["unread_notification_count"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "total_jobs": totalJobs,
    "today_opening_job": todayOpeningJob,
    "job_types": List<dynamic>.from(jobTypes!.map((x) => x.toJson())),
    "state_wise": List<dynamic>.from(stateWise!.map((x) => x.toJson())),
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "unread_notification_count": unreadNotificationCount,
    "message": message,
    "status": status,
  };
}

class Datum {
  int? id;
  String? jobName;
  String? jobTypeName;
  String? jobLocation;
  String? salary;
  String? salaryType;
  String? stateName;
  String? cityName;
  String? createdAt;
  int? favoriteType;

  Datum({
    this.id,
    this.jobName,
    this.jobTypeName,
    this.jobLocation,
    this.salary,
    this.salaryType,
    this.stateName,
    this.cityName,
    this.createdAt,
    this.favoriteType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    jobName: json["job_name"],
    jobTypeName: json["job_type_name"],
    jobLocation: json["job_location"],
    salary: json["salary"],
    salaryType: json["salary_type"],
    stateName: json["state_name"],
    cityName: json["city_name"],
    createdAt: json["created_at"],
    favoriteType: json["favorite_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_name": jobName,
    "job_type_name": jobTypeName,
    "job_location": jobLocation,
    "salary": salary,
    "salary_type": salaryType,
    "state_name": stateName,
    "city_name": cityName,
    "created_at": createdAt,
    "favorite_type": favoriteType,
  };
}

class JobType {
  int? id;
  String? jobTypeName;

  JobType({
    this.id,
    this.jobTypeName,
  });

  factory JobType.fromJson(Map<String, dynamic> json) => JobType(
    id: json["id"],
    jobTypeName: json["job_type_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_type_name": jobTypeName,
  };
}

class StateWise {
  String? state;
  String? stateName;
  int? jobs;
  String? stateFlag;

  StateWise({
    this.state,
    this.stateName,
    this.jobs,
    this.stateFlag,
  });

  factory StateWise.fromJson(Map<String, dynamic> json) => StateWise(
    state: json["state"],
    stateName: json["state_name"],
    jobs: json["jobs"],
    stateFlag: json["state_flag"],
  );

  Map<String, dynamic> toJson() => {
    "state": state,
    "state_name": stateName,
    "jobs": jobs,
    "state_flag": stateFlag,
  };
}
