

import 'package:ninedot_task/api/api_helpers.dart';
import 'package:ninedot_task/api/api_urls.dart';
import 'package:ninedot_task/models/response_item.dart';


class HomeRepo {
  /// JobList
  static Future<ResponseItem> jobList(
      {required Map<String,dynamic> body}) async {
    String url = ApiUrls.jobList;
    ResponseItem result = await BaseApiHelper.postRequest(url,body);
    return result;
  }


}
