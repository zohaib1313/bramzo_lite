import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:bramzo_lite/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/tab_model.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  int addedNumber = 0;
  RxBool isLoading = false.obs;
  TabModel? selectedTabModel;
  RxList<TabModel> listItems = <TabModel>[].obs;

  List<AnimationEffect> animations = [ScaleInTop(), ScaleInBottom()];

  ScrollController scrollController = ScrollController();

  void initProcess() {
    listItems.clear();
    addNewItemToList();
  }

  void addNewItemToList() {
    addedNumber++;
    TabModel model = TabModel(id: addedNumber, value: "");
    if (listItems.isEmpty) {
      listItems.insert(0, model);
    } else if (listItems.length == 1) {
      listItems.insert(0, model);
    } else if (listItems.length == 2) {
      listItems.insert(1, model);
    } else {
      int index = listItems.indexOf(selectedTabModel);
      listItems.insert(index, model);
    }
    selectedTabModel = model;

    print(listItems.length);
  }

  getDelBtnColor({required TabModel model}) {
    if (model.isCheckedOff) {
      return AppColors.orangeBox2;
    } else {
      if (model.id == selectedTabModel?.id) {
        //it is selected
        return AppColors.lightGrey2;
      } else {
        //not selected
        return AppColors.lightGrey;
      }
    }
  }

  getTextFieldBgColor({required TabModel model}) {
    if (model.isCheckedOff) {
      return AppColors.orangeBox2;
    } else {
      if (model.id == selectedTabModel?.id) {
        //it is selected
        return AppColors.lightGrey2;
      } else {
        //not selected
        return AppColors.lightGrey;
      }
    }
  }
}
