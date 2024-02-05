import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:bramzo_lite/common/db_helper/objectbox_class.dart';
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

  void initProcess() async {
    listItems.clear();

    List<TabModel> allTabsModelList = await ObjectBox.getAllObjects<TabModel>();

    if (allTabsModelList.isNotEmpty) {
      listItems.assignAll(List<TabModel>.generate(
        allTabsModelList.length,
        (index) {
          var item =
              allTabsModelList.firstWhere((element) => element.index == index);
          item.focusNode = FocusNode();
          item.localId = item.id!;
          return item;
        },
      ));

      selectedTabModel = listItems.first;
      selectedTabModel?.focusNode?.requestFocus();
      addedNumber = allTabsModelList.last.id ?? 1000;
    } else {
      addNewItemToList();
    }
  }

  Future<void> addNewItemToList() async {
    addedNumber = addedNumber + 1;

    TabModel model = TabModel(
      localId: addedNumber,
      value: "",
      focusNode: FocusNode(),
    );
    if (listItems.isEmpty) {
      listItems.insert(0, model);
    } else if (listItems.length == 1) {
      listItems.insert(0, model);
    } else if (listItems.length == 2) {
      listItems.insert(1, model);
    } else {
      int index = listItems.indexOf(selectedTabModel);
      if (index == 0) {
        listItems.insert(1, model);
      } else {
        listItems.insert(index, model);
      }
    }
    selectedTabModel = model;
    model.focusNode?.requestFocus();
    updateAllObjectBox(modelList: listItems);
  }

  getDelBtnColor({required TabModel model}) {
    if (model.isCheckedOff) {
      return AppColors.orangeBox2;
    } else {
      if (model.localId == selectedTabModel?.localId) {
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
      if (model.localId == selectedTabModel?.localId) {
        //it is selected
        return AppColors.lightGrey2;
      } else {
        //not selected
        return AppColors.lightGrey;
      }
    }
  }

  void updateObjectBoxModel({required TabModel model}) async {
    TabModel? objModel =
        await ObjectBox.getSingleWithLocalId(localId: model.localId);
    if (objModel != null) {
      await ObjectBox.insertData<TabModel>(model);
    }
  }

  void updateAllObjectBox({required List<TabModel> modelList}) async {
    int result = await ObjectBox.deleteAllObjects<TabModel>();
    int index = 0;
    for (var element in modelList) {
      element.index = index;
      await ObjectBox.insertData<TabModel>(element);
      index++;
    }
  }
}
