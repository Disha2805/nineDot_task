import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ninedot_task/api/repo/home_repo.dart';
import 'package:ninedot_task/models/joblist_response_model.dart';
import 'package:ninedot_task/models/response_item.dart';
import 'package:ninedot_task/utils/shared_prefs.dart';
import 'package:ninedot_task/widgets/app_snackbar.dart';

class HomeController extends GetxController {
  PageController pageController = PageController();

  bool isLoading = false;

  JobListResponseModel? jobListResponseModel;

  static const pageSize = 10;
  final PagingController<int, Datum> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getJobListData(pageKey);
    });
  }

  /// GET JOB LIST DATA
  Future<void> getJobListData(int pageKey) async {
    Map<String, dynamic> body = {
      "user_id": "${preferences.getString(SharedPreference.userId)}",
      "page": "$pageKey",
      "search": "",
      "location": "",
      "job_type": "",
      "view_list": 0,
    };

    isLoading = true;
    ResponseItem result = await HomeRepo.jobList(body: body);
    try {
      if (result.status) {
        if (result.data != null) {
          jobListResponseModel = JobListResponseModel.fromJson(result.data);
          if (jobListResponseModel!.status!) {
            try {
              final newItems = jobListResponseModel!.data;
              final isLastPage = newItems!.length < pageSize;
              if (isLastPage) {
                pagingController.appendLastPage(newItems);
              } else {
                final nextPageKey = pageKey + 1;
                pagingController.appendPage(
                    newItems, int.parse(nextPageKey.toString()));
              }
            } catch (error) {
              pagingController.error = error;
            }
          }
          isLoading = false;
          update();
        } else {
          isLoading = false;
          showSnackBar(message: result.message.toString());
          update();
        }
      } else {
        isLoading = false;
        showSnackBar(message: result.message.toString());
        update();
      }
    } catch (e) {
      isLoading = false;
      showSnackBar(message: result.message.toString());
      update();
    }
    update();
  }
}
