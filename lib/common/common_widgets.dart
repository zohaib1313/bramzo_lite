import 'package:bramzo_lite/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class MyTextField extends StatelessWidget {
  final Color? fillColor;

  final String? hintText;
  final Color? hintColor;
  final String? prefixIcon;
  final String? suffixIcon;
  final Color? focusBorderColor;
  final Color? unfocusBorderColor;
  final double? contentPadding;
  final bool? enable;
  final String? text;
  final String? sufixLabel;

  final onFieldSubmit;
  final double? leftPadding;
  final double? rightPadding;
  final TextEditingController? controller;
  final Function? focusListner;
  final FocusNode? focusNode;
  final FieldValidator? validator;
  final TextInputType? keyboardType;
  final inputFormatters;
  final Color textColor;
  final bool? obsecureText;
  final Widget? suffixIconWidet;
  final Widget? prefixIconWidget;
  int minLines = 1;
  int maxLines = 1;
  TextDirection? textDirection;
  double borderRadius;
  final bool? readOnly;
  final bool? autofocus;
  TextStyle? textStyle;
  TextAlign? textAlign;

  MyTextField({
    Key? key,
    this.textDirection,
    this.borderRadius = 30,
    this.textColor = Colors.black,
    this.obsecureText,
    this.readOnly,
    this.autofocus,
    this.fillColor,
    this.maxLines = 1,
    this.minLines = 1,
    this.hintText,
    this.hintColor,
    this.prefixIcon,
    this.inputFormatters,
    this.suffixIcon,
    this.focusBorderColor,
    this.unfocusBorderColor,
    this.onFieldSubmit,
    this.contentPadding,
    this.enable = true,
    this.text,
    this.sufixLabel,
    this.leftPadding,
    this.rightPadding,
    this.controller,
    this.focusListner,
    this.validator,
    this.focusNode,
    this.suffixIconWidet,
    this.prefixIconWidget,
    this.keyboardType,
    this.textStyle,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding ?? 0,
        right: rightPadding ?? 0,
      ),
      child: TextFormField(
        readOnly: readOnly ?? false,
        obscureText: obsecureText ?? false,
        style: textStyle ??
            AppTextStyles.textStyleNormalBodySmall.copyWith(color: textColor),
        controller: controller ?? TextEditingController(),
        initialValue: text,
        minLines: minLines,
        maxLines: maxLines,
        textAlign: textAlign ?? TextAlign.start,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType ?? TextInputType.text,
        enabled: enable,
        onFieldSubmitted: onFieldSubmit,
        focusNode: focusNode,
        validator: validator,
        autofocus: autofocus ?? false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(contentPadding ?? 12.h),
          fillColor: fillColor,
          alignLabelWithHint: true,
          hintText: hintText ?? '',
          filled: fillColor != null,
          hintStyle: AppTextStyles.textStyleNormalBodyXSmall
              .copyWith(color: hintColor ?? AppColors.black),
          prefixIconConstraints: BoxConstraints(
              maxHeight: 44, minHeight: 44, maxWidth: 55.w, minWidth: 34),
          prefixIcon: (prefixIcon != null)
              ? Padding(
                  padding: EdgeInsets.all(contentPadding ?? 28),
                  child: SvgViewer(
                    svgPath: prefixIcon!,
                    width: 40.w,
                    height: 14.h,
                    color: hintColor ?? AppColors.black,
                  ),
                )
              : prefixIconWidget,
          suffixIcon: sufixLabel != null
              ? Padding(
                  padding: EdgeInsets.all(2.h),
                  child: Text(
                    sufixLabel ?? '',
                    style: AppTextStyles.textStyleBoldBodySmall,
                  ),
                )
              : (suffixIcon != null)
                  ? Padding(
                      padding: EdgeInsets.all(8.h),
                      child: SvgViewer(
                        svgPath: suffixIcon!,
                      ),
                    )
                  : (suffixIconWidet),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
            borderSide: BorderSide(color: focusBorderColor ?? AppColors.black),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
            borderSide: BorderSide(color: focusBorderColor ?? AppColors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
            borderSide:
                BorderSide(color: unfocusBorderColor ?? AppColors.black),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
            borderSide: const BorderSide(color: AppColors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
            borderSide: BorderSide(
                color: focusBorderColor ?? AppColors.primaryBlueColor),
          ),
        ),
      ),
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
          borderRadius: BorderRadius.circular(radius ?? 16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
