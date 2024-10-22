

import 'package:ninedot_task/api/api_helpers.dart';
import 'package:ninedot_task/api/api_urls.dart';
import 'package:ninedot_task/models/response_item.dart';



class AuthRepo {
  /// Register
  static Future<ResponseItem> register({required Map<String, dynamic> body}) async {
    String requestUrl = ApiUrls.register;
    ResponseItem result = await BaseApiHelper.postRequest(requestUrl, body);
    return result;
  }


  /// Login
  static Future<ResponseItem> login({required Map<String, dynamic> body}) async {
    String requestUrl = ApiUrls.login;
    ResponseItem result = await BaseApiHelper.postRequest(requestUrl, body);
    return result;
  }

}
