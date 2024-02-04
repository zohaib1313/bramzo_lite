import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:bramzo_lite/common/app_constants.dart';
import 'package:bramzo_lite/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/styles.dart';
import 'controllers/home_page_controller.dart';

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
                        horizontal: AppConstants.leftRightPadding),
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
                        Container(
                          height: 35.h,
                          decoration: const BoxDecoration(
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
                        onReorder: (int oldIndex, int newIndex) {
                          final TabModel item =
                              controller.listItems.removeAt(oldIndex);
                          controller.listItems.insert(newIndex, item);
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
                          controller.addNewItemToList();
                        },
                        child: Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.blueBoxUnSelected),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add,
                            color: AppColors.primaryBlueColor,
                            size: 40,
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
      key: ValueKey(model.id),
      height: AppConstants.listItemHeight + 10,
      child: Column(
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
                  onTap: () {
                    homeController.listItems.removeAt(index);
                    homeController.listItems = homeController.listItems;
                  },
                  child: Icon(
                    Icons.close_outlined,
                    size: AppConstants.leftRightPadding,
                    color: AppColors.lightGrey,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: CustomTextField(
                    homeController: homeController,
                    needRequestFocus: false,
                    controller: TextEditingController(text: model.value),
                    onTextChanged: (text) {
                      model.value = text;
                    },
                  ),
                ),
              ],
            ),
          ),
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
                  width: double.infinity))
        ],
      ),
    );
  }
}
