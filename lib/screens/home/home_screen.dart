import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:ninedot_task/constant/app_color.dart';
import 'package:ninedot_task/constant/app_strings.dart';
import 'package:ninedot_task/constant/app_text_styles.dart';
import 'package:ninedot_task/models/joblist_response_model.dart';
import 'package:ninedot_task/screens/home/controller/home_controller.dart';
import 'package:ninedot_task/services/notification_services.dart';
import 'package:ninedot_task/utils/app_routes.dart';
import 'package:ninedot_task/utils/extensions.dart';
import 'package:ninedot_task/utils/shared_prefs.dart';
import 'package:ninedot_task/widgets/app_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Palette.primary,
        title: AppStrings.homePage
            .semiBold(fontColor: Palette.white, fontSize: 21),
        actions: [

          ///Logout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: () {
                preferences.logOut();
                Get.offAllNamed(Routes.login);
              },
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              child: const Icon(
                Icons.logout,
                color: Palette.white,
                size: 23,
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            ///Home JobList Data
            PagedListView<int, Datum>(
              pagingController: controller.pagingController,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              builderDelegate: PagedChildBuilderDelegate<Datum>(
                noItemsFoundIndicatorBuilder: (context) => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.25),
                  child: Center(
                    child: AppStrings.noDataText.regular(fontSize: 15),
                  ),
                ),
                firstPageErrorIndicatorBuilder: (context) => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.25),
                  child: Center(
                    child: AppStrings.errorDataText.regular(fontSize: 15),
                  ),
                ),
                itemBuilder: (context, item, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Job Name
                          (item.jobName ?? "").semiBold(fontSize: 22),
                          const SizedBox(height: 10),

                          ///Job Type
                          detailsRow(Icons.work, item.jobTypeName ?? ""),

                          ///Job Location
                          detailsRow(Icons.location_on,
                              "${item.jobLocation ?? ""}, ${item.stateName ?? ""}"),

                          ///Job Salary
                          detailsRow(Icons.attach_money,
                              "${item.salary ?? ""} ${item.salaryType ?? ""}"),

                          ///Job Date
                          Text(
                            "Posted on: ${DateFormat("dd/MM/yyyy hh:mm a").format(DateTime.parse(item.createdAt ?? ""))}",
                            style: CommonTextStyles.kGrey16Medium
                                .copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            ///Bottom Notification
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppFilledButton(
                      onPressed: () {
                        AppNotificationHandler.sendMessage(
                            message: "This is Foreground Test Notification",
                            receiverFcmToken: preferences
                                .getString(SharedPreference.fcmToken));
                      },
                      width: Get.width * 0.38,
                      fontSize: 15,
                      icon: const Icon(Icons.notification_add_outlined),
                      title: "Foreground",
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    AppFilledButton(
                      onPressed: () {
                        AppNotificationHandler.sendMessage(
                            isLater: true,
                            message: "This is Background Test Notification",
                            receiverFcmToken: preferences
                                .getString(SharedPreference.fcmToken));
                      },
                      width: Get.width * 0.38,
                      fontSize: 15,
                      icon: const Icon(Icons.notification_add_outlined),
                      title: "Background",
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  ///Common Job Details Widgets
  Widget detailsRow(IconData icon, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Palette.primary, size: 23),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: CommonTextStyles.kBlack16Medium.copyWith(fontSize: 15),
          ),
        ),
      ],
    ).paddingOnly(bottom: 8);
  }
}
