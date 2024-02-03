import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingWidget extends StatelessWidget {
  final width = Get.width;
  final height = Get.height;
  final Color? loaderColor;
  void Function()? onCancel;

  LoadingWidget({Key? key, this.loaderColor, this.onCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(10),
      color: loaderColor ?? Get.theme.secondaryHeaderColor.withOpacity(0.5),
      child: Stack(
        children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          InkWell(
            onTap: onCancel ??
                () {
                  print("aaa");
                },
            child: const Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      // child: SpinKitCubeGrid(
      //   color: Get.theme.primaryColorDark,
      //   size: height * 0.08,
      //   duration: const Duration(milliseconds: 1000),
      // )
    );
  }
}
