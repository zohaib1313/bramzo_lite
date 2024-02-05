import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:bramzo_lite/common/app_constants.dart';
import 'package:bramzo_lite/common/app_utils.dart';
import 'package:bramzo_lite/common/common_widgets.dart';
import 'package:bramzo_lite/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import '../../common/db_helper/objectbox_class.dart';
import '../../common/styles.dart';
import 'controllers/home_page_controller.dart';
import 'models/tab_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const id = '/homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetX<HomePageController>(
      init: HomePageController(),
      autoRemove: false,
      initState: (state) {
        state.controller?.initProcess();
      },
      builder: (controller) {
        controller.isLoading.value;
        return Scaffold(
            backgroundColor: AppColors.primaryBlueColor,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ///app-bar
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8, horizontal: AppConstants.leftRightPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        SizedBox(
                          height: 35.h,
                          child: RichText(
                            text: TextSpan(
                              style: AppTextStyles.textStyleBoldSubTitleLarge
                                  .copyWith(color: AppColors.lightGrey),
                              children: [
                                const TextSpan(text: "Bramzo"),
                                const WidgetSpan(child: SizedBox(width: 2)),
                                TextSpan(
                                  text: "Lite",
                                  style: AppTextStyles
                                      .textStyleBoldSubTitleLarge
                                      .copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.lightGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            AppUtils.playTapSound();
                            await ObjectBox.deleteAllObjects<TabModel>();
                            controller.initProcess();
                          },
                          child: Container(
                            height: 35.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.blueBoxUnSelected),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "RESET",
                              style: AppTextStyles.textStyleBoldSubTitleLarge
                                  .copyWith(
                                      color: AppColors.primaryBlueColor,
                                      fontSize: 22.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  ///
                  SizedBox(height: AppConstants.listItemHeight * 2),
                  Expanded(
                    child: Obx(
                      () => AnimatedReorderableListView<TabModel>(
                        items: controller.listItems.value,
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return _getListItem(
                              index: index,
                              homeController: controller,
                              model: controller.listItems.elementAt(index));
                        },
                        enterTransition: controller.animations,
                        exitTransition: controller.animations,
                        insertDuration: const Duration(milliseconds: 300),
                        removeDuration: const Duration(milliseconds: 300),
                        onReorderStart: (index) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          print("reorder");
                          final TabModel item =
                              controller.listItems.removeAt(oldIndex);
                          controller.listItems.insert(newIndex, item);

                          controller.updateAllObjectBox(
                              modelList: controller.listItems);
                        },
                        proxyDecorator: proxyDecorator,
                      ),
                    ),
                  ),

                  ///
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          AppUtils.playTapSound();
                          controller.addNewItemToList();
                        },
                        child: Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.blueBoxUnSelected),
                          alignment: Alignment.center,
                          child: SvgViewer(
                            svgPath: Assets.svgsAddBtnSvf,
                            height: 28.sp,
                            width: 28.sp,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  Widget _getListItem(
      {required int index,
      required TabModel model,
      required HomePageController homeController}) {
    return SizedBox(
      key: ValueKey(model.localId),
      height: AppConstants.listItemHeight + 10,
      child: GetBuilder<HomePageController>(
          assignId: true,
          id: "tab",
          autoRemove: false,
          builder: (context) {
            return Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      GestureDetector(
                        onVerticalDragUpdate: (details) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          homeController.scrollController.jumpTo(
                              homeController.scrollController.offset -
                                  details.primaryDelta!);
                        },
                        onTap: () async {
                          AppUtils.playTapSound();
                          if (homeController.listItems.length > 1) {
                            if (homeController.selectedTabModel?.localId ==
                                homeController.listItems
                                    .elementAt(index)
                                    .localId) {
                              if (index != 0) {
                                homeController.selectedTabModel = homeController
                                    .listItems
                                    .elementAt(index - 1);
                              } else {
                                homeController.selectedTabModel = homeController
                                    .listItems
                                    .elementAt(index + 1);
                              }
                            }

                            homeController.listItems.removeAt(index);
                            homeController.listItems = homeController.listItems;
                            homeController.updateAllObjectBox(
                                modelList: homeController.listItems);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgViewer(
                            svgPath: Assets.svgsDelBtnSvg,
                            height: 18.sp,
                            width: 18.sp,
                            color: homeController.getDelBtnColor(model: model),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: CustomTextField(
                          homeController: homeController,
                          focusNode: model.focusNode!,
                          onBoxLongPress: () {
                            AppUtils.playTapSound();
                            model.isCheckedOff = !model.isCheckedOff;
                            Vibration.vibrate(duration: 55);
                            homeController.update(["tab"]);
                          },
                          onBoxTap: () {
                            AppUtils.playTapSound();
                            FocusManager.instance.primaryFocus?.unfocus();
                            //if (!model.isCheckedOff) {
                            homeController.selectedTabModel = model;
                            homeController.update(["tab"]);
                            //}
                          },
                          model: model,
                          onTextChanged: (text) {
                            model.value = text;
                            homeController.updateObjectBoxModel(model: model);
                          },
                        ),
                      ),

                      ///right margin
                      GestureDetector(
                        onVerticalDragUpdate: (details) {
                          homeController.scrollController.jumpTo(
                              homeController.scrollController.offset -
                                  details.primaryDelta!);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Container(
                            color: AppColors.primaryBlueColor,
                            height: double.infinity,
                            width: AppConstants.leftRightPadding),
                      )
                    ],
                  ),
                ),

                ///bottom margin
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    homeController.scrollController.jumpTo(
                        homeController.scrollController.offset -
                            details.primaryDelta!);
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Container(
                      color: Colors.transparent,
                      height: 10,
                      width: double.infinity),
                )
              ],
            );
          }),
    );
  }
}
