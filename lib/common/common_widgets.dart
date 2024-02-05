import 'package:bramzo_lite/common/styles.dart';
import 'package:bramzo_lite/views/home/controllers/home_page_controller.dart';
import 'package:bramzo_lite/views/home/models/tab_model.dart';
import 'package:ensure_visible_when_focused/ensure_visible_when_focused.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef FieldValidator = String? Function(String? data);

class SvgViewer extends StatelessWidget {
  final String svgPath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const SvgViewer(
      {Key? key,
      required this.svgPath,
      this.height,
      this.width,
      this.color,
      this.fit = BoxFit.contain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      key: key,
      color: color,
      height: height ?? 30.h,
      width: width ?? 30.w,
      fit: fit,
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TabModel model;
  final ValueChanged<String>? onTextChanged;
  final FocusNode focusNode;


  final HomePageController homeController;
  final Null Function() onBoxLongPress;
  final Null Function() onBoxTap;

  const CustomTextField({
    super.key,
    this.onTextChanged,
    required this.model,
    required this.homeController,
    required this.onBoxLongPress,
    required this.onBoxTap,
    required this.focusNode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (widget.needRequestFocus) {
    //     primaryFocus?.requestFocus(focusNode);
    //     print("focusingon : ${widget.model.id}");
    //   }
    // });
    textEditingController
      ..text = widget.model.value
      ..selection = TextSelection.collapsed(offset: widget.model.value.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.homeController
                    .getTextFieldBgColor(model: widget.model),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        widget.homeController.scrollController.jumpTo(
                            widget.homeController.scrollController.offset -
                                details.primaryDelta!);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: EnsureVisibleWhenFocused(
                        focusNode: widget.focusNode,
                        child: TextField(
                          focusNode: widget.focusNode,
                          onTap: () {
                            if (!widget.model.isCheckedOff) {
                              widget.homeController.selectedTabModel =
                                  widget.model;
                              widget.homeController.update(["tab"]);
                            }
                            //  widget.textEditController.selection=TextSelection.collapsed(offset: offset)
                            //   focusNode.requestFocus();
                          },
                          onChanged: widget.onTextChanged,
                          controller: textEditingController,
                          style: AppTextStyles.textStyleBoldBodyMedium.copyWith(
                              color: widget.model.isCheckedOff
                                  ? AppColors.orangeText
                                  : Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onLongPress: widget.onBoxLongPress,
                    onTap: widget.onBoxTap,
                    child: Container(
                      color: widget.model.isCheckedOff
                          ? AppColors.orangeBox1
                          : AppColors.blueBoxUnSelected,
                      width: 50.0,
                      height: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  final Color? borderColor;

  final double? radius;

  const MyCard(
      {Key? key,
      required this.child,
      this.bgColor,
      this.radius,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: bgColor,
      // margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: borderColor ?? bgColor ?? Colors.transparent, width: 0.1),
          borderRadius: BorderRadius.circular(radius ?? 6)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: child,
      ),
    );
  }
}

Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
  return AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      return Material(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: child,
      );
    },
    child: child,
  );
}
