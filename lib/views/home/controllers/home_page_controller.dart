import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TabModel {
  int id;
  String value;

  TabModel(this.id, this.value);
}

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  int addedNumber = 0;
  RxBool isLoading = false.obs;

  RxList<TabModel> listItems = <TabModel>[].obs;

  List<AnimationEffect> animations = [ScaleInTop(), ScaleInBottom()];

  ScrollController scrollController = ScrollController();

  void initProcess() {
    ///
    listItems.add(TabModel(addedNumber, ""));
  }

  void addNewItemToList() {
    addedNumber++;
    listItems.insert(0, TabModel(addedNumber, ""));

    // if (listItems.length == 1) {
    //   listItems.insert(0, TextEditingController());
    // } else {
    //   listItems.add(TextEditingController());
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
