import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ninedot_task/api/api_exception.dart';
import 'package:ninedot_task/api/api_extension.dart';
import 'package:ninedot_task/models/response_item.dart';

class BaseApiHelper {

  /// Post
  static Future<ResponseItem> postRequest(
      String requestUrl, Map<String, dynamic> requestData) async {
    return await http
        .post(Uri.parse(requestUrl),
            body: json.encode(requestData),
            headers: requestHeader())
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  /// Get
  static Future<dynamic> getRequest(String requestUrl,
      ) async {
    return await http
        .get(Uri.parse(requestUrl), headers: requestHeader())
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }


  /// On Value
  static Future<ResponseItem> onValue(http.Response response) async {
    final ResponseItem result =
        ResponseItem(status: false, message: "Something went wrong.");

    dynamic data = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      result.status = true;
      result.data = data;
      result.message = data["message"];
      result.statusCode = response.statusCode;
    } else if (response.statusCode == 400) {
      result.data = data;
      result.message = data["message"];
      result.statusCode = response.statusCode;
    } else {
      result.data = data;
      result.message = data["message"];
      result.statusCode = response.statusCode;
    }

    return result;
  }

  /// On Error
  static onError(error) {
    log("Error caused: $error");
    String message = "Unsuccessful request";
    if (error is SocketException) {
      message = ResponseException("No internet connection").toString();
    } else if (error is FormatException) {
      message = ResponseException("Something wrong in response.").toString() +
          error.toString();
    }
    return ResponseItem(data: null, message: message, status: false);
  }
}
