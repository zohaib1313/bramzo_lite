import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:bramzo_lite/common/app_constants.dart';
import 'package:bramzo_lite/common/app_utils.dart';
import 'package:bramzo_lite/common/common_widgets.dart';
import 'package:bramzo_lite/generated/assets.dart';
import 'package:flutter/material.dart';
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
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.leftRightPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          style:
                              AppTextStyles.textStyleBoldSubTitleLarge.copyWith(
                            color: AppColors.lightGrey,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            const TextSpan(text: "Bramzo"),
                            const WidgetSpan(child: SizedBox(width: 2)),
                            TextSpan(
                              text: "Lite",
                              style: AppTextStyles.textStyleBoldSubTitleLarge
                                  .copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.lightGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          AppUtils.playTapSound();
                          FocusManager.instance.primaryFocus?.unfocus();
                          await ObjectBox.deleteAllObjects<TabModel>();
                          controller.initProcess();
                        },
                        child: Container(
                          height: 36.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.blueBoxUnSelected),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 6),
                          padding:
                              const EdgeInsets.only(left: 6, right: 6, top: 2),
                          child: Text(
                            "RESET",
                            style: AppTextStyles.textStyleBoldSubTitleLarge
                                .copyWith(
                                    color: AppColors.primaryBlueColor,
                                    fontSize: 22.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///
                SizedBox(height: AppConstants.listItemHeight * 2),
                Expanded(
                  child: Obx(() => AnimatedReorderableListView<TabModel>(
                        items: controller.listItems.value,
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller.scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return controller.listItems.isNotEmpty

                              ///checking is Emptylist, because sometimes it gives exception
                              ///while clearing list...
                              ? _getListItem(
                                  index: index,
                                  key: ValueKey(controller.listItems
                                      .elementAt(index)
                                      .localId),
                                  homeController: controller,
                                  model: controller.listItems.elementAt(index))
                              : SizedBox(key: UniqueKey());
                        },
                        enterTransition: controller.animations,
                        exitTransition: controller.animations,
                        insertDuration: const Duration(milliseconds: 750),
                        removeDuration: const Duration(milliseconds: 750),
                        removeItemBuilder: (widget, animation) {
                          final curvedAnimation = CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          );

                          return SizeTransition(
                            sizeFactor: curvedAnimation,
                            child: ScaleTransition(
                                scale: curvedAnimation, child: widget),
                          );
                        },
                        insertItemBuilder: (widget, animation) {
                          final curvedAnimation = CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          );
                          return SizeTransition(
                            sizeFactor: curvedAnimation,
                            child: ScaleTransition(
                                scale: curvedAnimation, child: widget),
                          );
                        },
                        onReorderStart: (index) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          final TabModel item =
                              controller.listItems.removeAt(oldIndex);
                          controller.listItems.insert(newIndex, item);

                          controller.updateAllObjectBox(
                              modelList: controller.listItems);
                        },
                        proxyDecorator: proxyDecorator,
                      )),
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
          ),
        );
      },
    );
  }

  Widget _getListItem(
      {required int index,
      required TabModel model,
      required Key key,
      required HomePageController homeController}) {
    return !(model.isVisible)
        ? SizedBox(height: AppConstants.listItemHeight + 20.h, key: key)
        : SizedBox(
            key: key,
            height: AppConstants.listItemHeight + 20.h,
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
                                if (homeController.listItems.length > 1) {
                                  if (homeController
                                          .selectedTabModel?.localId ==
                                      homeController.listItems
                                          .elementAt(index)
                                          .localId) {
                                    if (index != 0) {
                                      homeController.selectedTabModel =
                                          homeController.listItems
                                              .elementAt(index - 1);
                                    } else {
                                      homeController.selectedTabModel =
                                          homeController.listItems
                                              .elementAt(index + 1);
                                    }
                                  }
                                  homeController.listItems.removeAt(index);
                                  homeController.addAndRemoveInvisibleItem();
                                  homeController.updateAllObjectBox(
                                      modelList: homeController.listItems);
                                  AppUtils.playTapSound();
                                }
                              },
                              child: Container(
                                width: AppConstants.leftRightPadding,
                                padding: const EdgeInsets.all(6),
                                child: SvgViewer(
                                  height: double.infinity,
                                  svgPath: Assets.svgsDelBtnSvg,
                                  color: homeController.getDelBtnColor(
                                      model: model),
                                ),
                              ),
                            ),

                            Expanded(
                              child: CustomTextField(
                                homeController: homeController,
                                focusNode: model.focusNode!,
                                onBoxLongPress: () {
                                  AppUtils.playTapSound();
                                  model.isCheckedOff = !model.isCheckedOff;
                                  homeController.listItems[index] = model;
                                  homeController.updateObjectBoxModel(
                                      model: model);

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
                                  homeController.updateObjectBoxModel(
                                      model: model);
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
                            height: 20.h,
                            width: double.infinity),
                      )
                    ],
                  );
                }),
          );
  }
}
