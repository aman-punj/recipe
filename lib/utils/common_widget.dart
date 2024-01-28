import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CustomTextWidget.dart';
import 'colors.dart';
import 'font_family.dart';

log(var s1) {
  String s = s1.toString();
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(s).forEach((match) => print(match.group(0)));
}

toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

showSnackbar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: CustomTextWidget(msg),
    duration: Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

mediumText(text, color, double size, [align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.ROBOTO_MEDIUM,
          fontSize: size,
          color: color),
    );

boldText(text, color, double size, [align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.ROBOTO_BOLD, fontSize: size, color: color),
    );

blackText(text, color, double size, [align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.ROBOTO_BLACK,
          fontSize: size,
          color: color),
    );

lightText(text, color, double size, [align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.ROBOTO_LIGHT,
          fontSize: size,
          color: color),
    );

regularText(text, color, double size, [align]) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: TextFontFamily.ROBOTO_REGULAR,
          fontSize: size,
          color: color),
    );

containerButton(onTap, text) => InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        //width: Get.width,
        width: 1.sw,
        decoration: BoxDecoration(
          color: ColorResources.pinkDB4,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: boldText(text, ColorResources.white, 16),
        ),
      ),
    );

// textField(hintText, icon) => TextFormField(
//       cursorColor: ColorResources.black,
//       style: TextStyle(
//         color: ColorResources.black,
//         fontSize: 16,
//         fontFamily: TextFontFamily.ROBOTO_REGULAR,
//       ),
//       decoration: InputDecoration(
//         prefixIcon: Padding(
//           padding: EdgeInsets.all(15),
//           child: SvgPicture.asset(icon),
//         ),
//         hintText: hintText,
//         hintStyle: TextStyle(
//           color: ColorResources.grey9CA,
//           fontSize: 16,
//           fontFamily: TextFontFamily.ROBOTO_REGULAR,
//         ),
//         filled: true,
//         fillColor: ColorResources.greyF9F,
//         border: OutlineInputBorder(
//           borderSide: BorderSide(color: ColorResources.greyF9F, width: 1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: ColorResources.greyF9F, width: 1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: ColorResources.greyF9F, width: 1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     );

textField1(hintText) => TextFormField(
      cursorColor: ColorResources.black,
      style: TextStyle(
        color: ColorResources.black,
        fontSize: 16,
        fontFamily: TextFontFamily.ROBOTO_REGULAR,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorResources.grey9CA,
          fontSize: 16,
          fontFamily: TextFontFamily.ROBOTO_REGULAR,
        ),
        filled: true,
        fillColor: ColorResources.greyF6F,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyAEA, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyAEA, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResources.greyAEA, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

/*InputDecoration textfielddecoration(
  String s, {
  Color border_color = ColorResources.greyEDE,
  double border_round = 20,
  double border_width = 1,
  double text_size = 18,
  double height = 0,
  Color fill_color = ColorResources.greyEDE,
  bool isfilled = false,
  bool ishint = false,
  bool islabel = false,
  String? helper_txt,
  Widget? prefix_icon,
  Widget? suffix_icon,
  Color? icon_color,
  int? max_lines,
}) {
  return InputDecoration(
      isDense: true,
      */ /*constraints: max_lines != null
          ? null
          : BoxConstraints(maxHeight: 40.h, minHeight: 30.h),*/ /*
      constraints: height > 0
          ? BoxConstraints(maxHeight: height, minHeight: height)
          : max_lines != null
              ? null
              : BoxConstraints(maxHeight: 40.h, minHeight: 30.h),
      contentPadding:
          max_lines != null ? null : EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 5.h),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: border_width, color: border_color),
        borderRadius: BorderRadius.all(
          Radius.circular(border_round),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: border_width, color: border_color),
        borderRadius: BorderRadius.all(
          Radius.circular(border_round),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: border_width, color: border_color),
        borderRadius: BorderRadius.all(
          Radius.circular(border_round),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: border_width, color: border_color),
        borderRadius: BorderRadius.all(
          Radius.circular(border_round),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: border_width, color: Colors.red),
        borderRadius: BorderRadius.all(
          Radius.circular(border_round),
        ),
      ),
      labelText: islabel ? s : "",
      labelStyle: TextStyle(
        color: border_color,
        fontSize: 18,
        fontFamily: TextFontFamily.ROBOTO_REGULAR,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorStyle: TextStyle(color: Colors.red),
      counterStyle: TextStyle(color: border_color),
      prefixIcon: prefix_icon,
      prefixIconColor: icon_color != null ? icon_color : null,
      suffixIcon: suffix_icon,
      suffixIconColor: icon_color != null ? icon_color : null,
      hintText: ishint ? s : "",
      hintStyle: TextStyle(
        fontSize: 18,
        fontFamily: TextFontFamily.ROBOTO_REGULAR,
      ),
      helperText: helper_txt,
      fillColor: fill_color,
      filled: isfilled,
      counterText: "");
}*/

InputDecoration textfielddecoration(
  String s, {
  Color border_color = ColorResources.greyEDE,
  double border_round = 20,
  double border_width = 1,
  double text_size = 18,
  double height = 0,
  Color fill_color = ColorResources.greyEDE,
  bool isfilled = false,
  bool ishint = false,
  bool islabel = false,
  String? helper_txt,
  Widget? prefix_icon,
  bool prefix_icon_padded = true,
  Widget? suffix_icon,
  bool suffix_icon_padded = true,
  Color? icon_color,
  int? max_lines,
}) {
  return InputDecoration(
      isDense: true,
      constraints: height > 0
          ? BoxConstraints(maxHeight: height, minHeight: height)
          : max_lines != null
              ? null
              : BoxConstraints(maxHeight: 60.h, minHeight: 30.h),
      contentPadding: max_lines != null
          ? null
          : EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: border_width, color: border_color),
        borderRadius: BorderRadius.all(
          Radius.circular(border_round),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: border_width, color: border_color),
        borderRadius: BorderRadius.all(
          Radius.circular(border_round),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: border_width, color: border_color),
        borderRadius: BorderRadius.all(
          Radius.circular(border_round),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: border_width, color: border_color),
        borderRadius: BorderRadius.all(
          Radius.circular(border_round),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: border_width, color: Colors.red),
        borderRadius: BorderRadius.all(
          Radius.circular(border_round),
        ),
      ),
      labelText: islabel ? s : "",
      labelStyle: TextStyle(
        color: border_color,
        fontSize: 18.sp,
        fontFamily: TextFontFamily.ROBOTO_REGULAR,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorStyle: TextStyle(color: Colors.red, fontSize: 9.sp),
      counterStyle: TextStyle(color: border_color),
      prefixIcon: prefix_icon,
      prefixIconConstraints: prefix_icon_padded
          ? null
          : BoxConstraints(
              maxHeight: 20.h, minHeight: 20.h, maxWidth: 20.w, minWidth: 20.w),
      prefixIconColor: icon_color != null ? icon_color : null,
      suffixIcon: suffix_icon,
      suffixIconConstraints: suffix_icon_padded
          ? null
          : BoxConstraints(
              maxHeight: 30.h, minHeight: 30.h, maxWidth: 30.w, minWidth: 30.w),
      suffixIconColor: icon_color != null ? icon_color : null,
      hintText: ishint ? s : "",
      hintStyle: TextStyle(
        fontSize: 18.sp,
        fontFamily: TextFontFamily.ROBOTO_REGULAR,
      ),
      helperText: helper_txt,
      fillColor: fill_color,
      filled: isfilled,
      counterText: "");
}

InputDecoration textfielddecoration_nounderline(String s) {
  return InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintText: s,
      counterText: "");
}

/*Widget text_form_field(String title, TextEditingController controller,
    {Color border_color = ColorResources.greyAEA,
    double border_round = 10,
    double border_width = 1,
    double text_size = 15,
    double height = 0,
    Color fill_color = ColorResources.greyF6F,
    FocusNode? focusnode,
    bool enableInteractiveSelection = true,
    bool isfilled = true,
    bool ishint = false,
    bool isheading = true,
    bool islabel = false,
    bool isenabled = true,
    bool obscure = false,
    String? helper_txt,
    Widget? prefix_icon,
    Widget? suffix_icon,
    Color? icon_color,
    TextInputType textInputType = TextInputType.text,
    TextStyle? textStyle,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int? max_length,
    int? max_lines = 1,
    Function()? ontap,
    Function(String)? onChanged = null,
    String? Function(String?)? validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      isheading
          ? Container(
              margin: EdgeInsets.only(left: 10.w),
              child: CustomTextWidget(
                title,
                isbold: true,
                size_txt: 13.sp,
                color_txt: ColorResources.grey6B7,
              ),
            )
          : Container(),
      SizedBox(height: 5.h),
      TextFormField(
        controller: controller,
        decoration: textfielddecoration(
          title,
          height: height,
          border_color: border_color,
          border_round: border_round,
          border_width: border_width,
          text_size: text_size,
          fill_color: fill_color,
          isfilled: isfilled,
          ishint: ishint,
          islabel: islabel,
          prefix_icon: prefix_icon,
          suffix_icon: suffix_icon,
          icon_color: icon_color,
          helper_txt: helper_txt,
        ),
        keyboardType: textInputType,
        style: textStyle ??
            TextStyle(
                fontFamily: TextFontFamily.ROBOTO_REGULAR,
                color: Colors.black,
                fontSize: text_size),
        maxLength: max_length,
        maxLines: max_lines,
        onTap: ontap,
        textCapitalization: textCapitalization,
        */ /*inputFormatters: [
          textInputType == TextInputType.phone ? FilteringTextInputFormatter.allow(RegExp(r'[0-9]')):
          textInputType == TextInputType.emailAddress ? FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z @-_]')),
        ],*/ /*
        enableInteractiveSelection: enableInteractiveSelection,
        focusNode: focusnode ?? FocusNode(canRequestFocus: false),
        enabled: isenabled,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscure,
      ),
    ],
  );
}*/

Widget text_form_field(String title, TextEditingController controller,
    {Color border_color = ColorResources.greyAEA,
    double border_round = 5,
    double border_width = 1,
    double text_size = 12,
    double height = 0,
    //Color fill_color = ColorResources.greyF6F,
    Color fill_color = ColorResources.greyF6F,
    Color? txt_color,
    FocusNode? focusnode,
    bool enableInteractiveSelection = true,
    bool isfilled = false,
    bool ishint = false,
    bool isheading = true,
    bool islabel = false,
    bool isenabled = true,
    bool obscure = false,
    String? helper_txt,
    Widget? prefix_icon,
    bool prefix_icon_padded = true,
    Widget? suffix_icon,
    bool suffix_icon_padded = true,
    Color? icon_color,
    TextInputType textInputType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters = null,
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int? max_length,
    int? max_lines = 1,
    Function()? ontap,
    Function(String)? onChanged = null,
    String? Function(String?)? validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      isheading
          ? Container(
              margin: EdgeInsets.only(left: 10.w),
              child: CustomTextWidget(
                title,
                isbold: true,
                size_txt: 11.sp,
                // color_txt: ColorResources.grey6B7,
              ),
            )
          : Container(),
      SizedBox(height: 5.h),
      TextFormField(
        controller: controller,
        decoration: textfielddecoration(title,
            height: height,
            border_color: border_color,
            border_round: border_round,
            border_width: border_width,
            text_size: text_size,
            fill_color: fill_color,
            isfilled: isfilled,
            ishint: ishint,
            islabel: islabel,
            prefix_icon: prefix_icon,
            suffix_icon: suffix_icon,
            icon_color: icon_color,
            helper_txt: helper_txt,
            prefix_icon_padded: prefix_icon_padded,
            suffix_icon_padded: suffix_icon_padded),
        keyboardType: textInputType,
        style: textStyle ??
            TextStyle(
                fontFamily: TextFontFamily.ROBOTO_REGULAR,
                color: txt_color,
                fontSize: text_size),
        maxLength: max_length,
        maxLines: max_lines,
        onTap: () {
          if (ontap != null) {
            FocusManager.instance.primaryFocus!.unfocus();
            ontap();
          }
        },
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters ??
            (textInputType == TextInputType.phone ||
                    textInputType == TextInputType.number
                ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
                : textInputType == TextInputType.name
                    ? [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))]
                    : textInputType == TextInputType.streetAddress
                        ? [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9a-zA-Z -_.,()]'))
                          ]
                        : textInputType == TextInputType.emailAddress
                            ? [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9a-zA-Z @-_.]')),
                              ]
                            : null),
        enableInteractiveSelection: enableInteractiveSelection,
        focusNode: focusnode ?? FocusNode(canRequestFocus: false),
        enabled: isenabled,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscure,
        textAlign: textAlign,
      ),
    ],
  );
}

/*Widget builddropdown(BuildContext context, List<String> data,
    String selectedstring, String title,
    {bool isfilled = true,
    bool isenabled = true,
    Function(String?)? onChanged,
    String? Function(String?)? validator}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w),
        child: CustomTextWidget(
          title,
          isbold: true,
          size_txt: 16.sp,
          color_txt: ColorResources.grey6B7,
        ),
      ),
      SizedBox(height: 10.h),
      new DropdownButtonFormField(
        isExpanded: true,
        isDense: true,
        menuMaxHeight: 400.h,
        decoration: InputDecoration(
            constraints: BoxConstraints(maxHeight: 60.h, minHeight: 40.h),
            contentPadding: EdgeInsets.fromLTRB(15.w, 5.h, 10.w, 5.h),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: ColorResources.greyAEA),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: ColorResources.greyAEA),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: ColorResources.greyAEA),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: ColorResources.greyAEA),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: ColorResources.greyAEA),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            filled: isfilled,
            fillColor: isfilled ? ColorResources.greyF6F : null),
        value: selectedstring,
        onChanged: isenabled ? onChanged : null,
        items: data.map((name) {
          return DropdownMenuItem(
            child: new CustomTextWidget(name,
                color_txt: Colors.black,
                size_txt: 14.sp,
                max_lines: 2,
                textOverflow: TextOverflow.visible),
            value: name,
          );
        }).toList(),
        itemHeight: null,
        validator: validator,
      ),
    ],
  );
}*/

Widget builddropdown(BuildContext context, List<String> data,
    String selectedstring, String title,
    {bool isfilled = true,
    bool isenabled = true,
    Function(String?)? onChanged,
    String? Function(String?)? validator}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 10.w),
        child: CustomTextWidget(
          title,
          isbold: true,
          size_txt: 11.sp,
          //color_txt: ColorResources.grey6B7,
        ),
      ),
      SizedBox(height: 5.h),
      DropdownButtonFormField(
        isExpanded: true,
        isDense: true,
        menuMaxHeight: 400.h,
        decoration: InputDecoration(
          isDense: true,
          constraints: BoxConstraints(maxHeight: 60.h, minHeight: 26.h),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: ColorResources.greyAEA),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: ColorResources.greyAEA),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: ColorResources.greyAEA),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: ColorResources.greyAEA),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: ColorResources.greyAEA),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          filled: isfilled,
          fillColor: Colors.transparent,
          errorStyle: TextStyle(color: Colors.red, fontSize: 9.sp),
        ),
        value: selectedstring,
        onChanged: isenabled ? onChanged : null,
        items: data.map((name) {
          return DropdownMenuItem(
            value: name,
            child: CustomTextWidget(name,
                max_lines: 2, textOverflow: TextOverflow.visible),
          );
        }).toList(),
        itemHeight: null,
        validator: validator,
      ),
    ],
  );
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {required Widget title,
      required FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool>? validator,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                contentPadding: EdgeInsets.zero,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => Text(
                          state.errorText!,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}

// Widget builddateLayout(
//     TextEditingController from_date, TextEditingController to_date) {
//   return Container(
//     margin: EdgeInsets.symmetric(vertical: 10.h),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           flex: 1,
//           child: InkWell(
//             onTap: () async {
//               DateTime? picked = await selectDate(
//                   PrefUtil.navKey.currentContext!, 'From Date');
//               try {
//                 String formattedDate = DateFormat('dd/MM/yyyy').format(picked!);
//                 from_date.text = formattedDate;
//               } catch (e) {
//                 print(e);
//               }
//             },
//             child: text_form_field("From Date", from_date,
//                 prefix_icon: Icon(Icons.calendar_today_outlined),
//                 isenabled: false),
//           ),
//         ),
//         SizedBox(width: 12.w),
//         Flexible(
//           flex: 1,
//           child: InkWell(
//             onTap: () async {
//               DateTime? picked =
//                   await selectDate(PrefUtil.navKey.currentContext!, 'To Date');
//               try {
//                 String formattedDate = DateFormat('dd/MM/yyyy').format(picked!);
//                 to_date.text = formattedDate;
//               } catch (e) {
//                 print(e);
//               }
//             },
//             child: text_form_field("To Date", to_date,
//                 prefix_icon: Icon(Icons.calendar_today_outlined),
//                 isenabled: false),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// selectDate(BuildContext context, String selectedDate) async {
//   final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1800, 8),
//       lastDate: DateTime.now());
//   if (picked != null && picked != selectedDate) {
//     return picked;
//   } else {
//     return null;
//   }
// }
//
// bool isAdult(String birthDateString, {String datePattern = "dd/MM/yyyy"}) {
//   //String datePattern = "dd/MM/yyyy";
//
//   DateTime today = DateTime.now();
//   DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
//
//   DateTime adultDate = DateTime(
//     birthDate.year + 18,
//     birthDate.month,
//     birthDate.day,
//   );
//
//   return adultDate.isBefore(today);
// }
//
// commonColumn(image, text, onTap) => Column(
//       children: [
//         Container(
//           height: 65,
//           width: 65,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(18),
//             color: ColorResources.blue1D3,
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(15),
//             child: InkWell(
//               onTap: onTap,
//               child: SvgPicture.asset(image),
//             ),
//           ),
//         ),
//         SizedBox(height: 5),
//         regularText(text, ColorResources.grey6B7, 13, TextAlign.center),
//       ],
//     );
//
// openLinks(url) async {
//   //final url = "";
//   if (await canLaunchUrl(Uri.parse(url))) {
//     launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
//
// class Custom_Dialog {
//   Custom_Dialog(
//       {required this.mcontext,
//       this.title,
//       required this.message,
//       this.dismissable = true,
//       this.positive_btn_text,
//       this.negative_btn_text,
//       this.onpress,
//       this.isClose = false,
//       this.isfinish = false,
//       this.dismissDialog = true,
//       this.onnegative_press});
//
//   bool dismissable = true;
//   bool isClose = false;
//
//   bool isfinish;
//   bool dismissDialog;
//   final BuildContext mcontext;
//   final String message;
//   String? title = "Message!!";
//   String? positive_btn_text = "Done";
//   String? negative_btn_text = "Cancel";
//   Function? onpress, onnegative_press;
//
//   void show() {
//     showDialog(
//         barrierDismissible: dismissable,
//         context: mcontext,
//         builder: (context) {
//           return WillPopScope(
//             onWillPop: () async => dismissable,
//             child: Container(
//               margin: EdgeInsets.only(
//                   top: 80.h, bottom: 56.h, left: 20.w, right: 20.w),
//               height: 1.sh,
//               alignment: Alignment.center,
//               child: Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 children: [
//                   Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.h)),
//                     elevation: 10.h,
//                     child: Container(
//                       padding: EdgeInsets.all(20.h),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.info_outline,
//                                 color: Colors.black,
//                               ),
//                               SizedBox(width: 10.w),
//                               CustomTextWidget(
//                                 title != null ? title : "Message!!",
//                                 color_txt: Colors.black,
//                                 size_txt: 18.sp,
//                                 isbold: true,
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 20.h),
//                           Container(
//                             margin: EdgeInsets.symmetric(horizontal: 30.w),
//                             child: CustomTextWidget(
//                               message,
//                               max_lines: 15,
//                               size_txt: 13.sp,
//                             ),
//                           ),
//                           SizedBox(height: 30.h),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               negative_btn_text != null
//                                   ? negative_btn_text!.isNotEmpty
//                                       ? TextButton(
//                                           child: Text(negative_btn_text!),
//                                           onPressed: () {
//                                             Navigator.of(context).pop();
//                                             if (onnegative_press != null) {
//                                               onnegative_press!();
//                                             }
//                                           })
//                                       : Container()
//                                   : Container(),
//                               TextButton(
//                                   child: Text(positive_btn_text!),
//                                   onPressed: () async {
//                                     if (dismissDialog) {
//                                       Navigator.of(context).pop();
//                                       if (isfinish) {
//                                         Navigator.of(mcontext).pop();
//                                       }
//                                     }
//
//                                     if (!isClose) {
//                                       if (onpress != null) {
//                                         onpress!();
//                                       }
//                                     } else {
//                                       SharedPreferences prefs =
//                                           await SharedPreferences.getInstance();
//                                       prefs.clear();
//                                       if (onpress != null) {
//                                         onpress!();
//                                       }
//                                     }
//                                   }),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
//
// class agreement_Dialog {
//   agreement_Dialog(
//       {required this.mcontext,
//       this.title,
//       required this.message,
//       this.dismissable = true,
//       this.positive_btn_text,
//       this.negative_btn_text,
//       required this.onpress,
//       this.isfinish = false,
//       this.dismissDialog = true,
//       required this.onnegative_press});
//
//   bool dismissable;
//   bool isfinish;
//   bool dismissDialog;
//   final BuildContext mcontext;
//   final String message;
//   String? title = "Message!!";
//   String? positive_btn_text = "Done";
//   String? negative_btn_text = "Cancel";
//   Function onpress, onnegative_press;
//
//   bool ischecked = false;
//   bool iserror = false;
//
//   void show() {
//     showDialog(
//         barrierDismissible: dismissable,
//         context: mcontext,
//         builder: (context) {
//           return PopScope(
//             canPop: dismissable,
//             child: Container(
//               margin: EdgeInsets.only(
//                   top: 80.h, bottom: 56.h, left: 30.w, right: 30.w),
//               height: 1.sh,
//               alignment: Alignment.center,
//               child: Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 children: [
//                   StatefulBuilder(// You need this, notice the parameters below:
//                       builder: (BuildContext context, StateSetter setState) {
//                     return Card(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(2.r)),
//                       elevation: 10.h,
//                       child: Container(
//                         padding: EdgeInsets.all(10.h),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.info_outline,
//                                   color: Colors.black,
//                                 ),
//                                 SizedBox(width: 10.w),
//                                 CustomTextWidget(
//                                   title != null ? title : "Message!!",
//                                   color_txt: Colors.black,
//                                   size_txt: 20.sp,
//                                   isbold: true,
//                                 )
//                               ],
//                             ),
//                             SizedBox(height: 20.h),
//                             Container(
//                               height: 280.h,
//                               margin: EdgeInsets.symmetric(horizontal: 20.w),
//                               child: SingleChildScrollView(
//                                 child: HtmlWidget(
//                                   message,
//                                   textStyle: TextStyle(
//                                       fontSize: 15.sp,
//                                       fontFamily: TextFontFamily.JOST_REGULAR),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20.h,
//                             ),
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               padding: EdgeInsets.only(left: 20.w),
//                               child: InkWell(
//                                 onTap: () {
//                                   openLinks(
//                                       "${AppConstants.Url}ReasonEntry.aspx");
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.only(bottom: 1),
//                                   decoration: BoxDecoration(
//                                       border: Border(
//                                           bottom: BorderSide(
//                                     color: Colors.blue,
//                                     width: 1.0, // Underline thickness
//                                   ))),
//                                   child: CustomTextWidget(
//                                     'Want to delete your data?',
//                                     color_txt: Colors.blue,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 30.h),
//                             Row(
//                               children: [
//                                 Checkbox(
//                                     value: ischecked,
//                                     onChanged: (bool? selected) {
//                                       setState(() {
//                                         ischecked = selected!;
//                                         if (iserror) {
//                                           iserror = false;
//                                         }
//                                       });
//                                     }),
//                                 Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CustomTextWidget(
//                                         ' By Continuing you agree to our ',
//                                       ),
//                                       Row(children: [
//                                         InkWell(
//                                             onTap: () {
//                                               openLinks(
//                                                   "${AppConstants.Url}privacy-policy.html");
//                                             },
//                                             child: Container(
//                                               padding: const EdgeInsets.only(
//                                                 bottom:
//                                                     1, // Space between underline and text
//                                               ),
//                                               decoration: BoxDecoration(
//                                                   border: Border(
//                                                       bottom: BorderSide(
//                                                 color: Colors.blue,
//                                                 width:
//                                                     1.0, // Underline thickness
//                                               ))),
//                                               child: CustomTextWidget(
//                                                 ' Privacy Policy',
//                                                 color_txt: Colors.blue,
//                                               ),
//                                             )),
//                                         CustomTextWidget(
//                                           ' & ',
//                                           size_txt: 14.sp,
//                                         ),
//                                         InkWell(
//                                           onTap: () {
//                                             openLinks(
//                                                 "${AppConstants.Url}terms-conditions.html");
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.only(
//                                               bottom:
//                                                   1, // Space between underline and text
//                                             ),
//                                             decoration: BoxDecoration(
//                                                 border: Border(
//                                                     bottom: BorderSide(
//                                               color: Colors.blue,
//                                               width: 1.0, // Underline thickness
//                                             ))),
//                                             child: CustomTextWidget(
//                                               'Terms and conditions.',
//                                               color_txt: Colors.blue,
//                                             ),
//                                           ),
//                                         ),
//                                       ]),
//                                     ]),
//                               ],
//                             ),
//                             iserror
//                                 ? Column(
//                                     children: [
//                                       SizedBox(height: 5.h),
//                                       CustomTextWidget(
//                                         '*** Please agree to conditions first.',
//                                         size_txt: 14.sp,
//                                         color_txt: Colors.red,
//                                       ),
//                                     ],
//                                   )
//                                 : Container(),
//                             SizedBox(height: 10.h),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 negative_btn_text != null
//                                     ? negative_btn_text!.isNotEmpty
//                                         ? TextButton(
//                                             child: Text(negative_btn_text!),
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                               onnegative_press();
//                                             })
//                                         : Container()
//                                     : Container(),
//                                 TextButton(
//                                     child: Text(positive_btn_text!),
//                                     onPressed: () {
//                                       if (ischecked) {
//                                         if (dismissDialog) {
//                                           setState(() {
//                                             iserror = false;
//                                           });
//                                           onpress();
//                                           onbackpress(context, isdialog: true);
//                                           if (isfinish) {
//                                             Navigator.of(mcontext).pop();
//                                           }
//                                         } else {
//                                           onpress();
//                                           if (isfinish) {
//                                             Navigator.of(mcontext).pop();
//                                           }
//                                         }
//                                       } else {
//                                         setState(() {
//                                           iserror = true;
//                                         });
//                                       }
//                                     }),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   })
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }

class LoadingDialog {
  LoadingDialog({
    required this.context,
    required this.title,
    required this.message,
    required this.dismissable,
  });

  final Widget title;
  final Widget message;
  final bool dismissable;
  final BuildContext context;
  bool isShowing = false;

  void show() {
    if (!isShowing) {
      showGeneralDialog(
        barrierDismissible: dismissable,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        context: context,
        pageBuilder: (_, __, ___) {
          return LoadingDialog_ui(
              title: title, message: message, dismissable: dismissable);
        },
      );
      isShowing = true;
    }
  }

  void dismiss() {
    if (isShowing) {
      Navigator.of(context, rootNavigator: true).pop();
      isShowing = false;
    }
  }
}

class LoadingDialog_ui extends StatelessWidget {
  const LoadingDialog_ui({
    Key? key,
    required this.title,
    required this.message,
    required this.dismissable,
  }) : super(key: key);

  final Widget title;
  final Widget message;
  final bool dismissable;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => dismissable ? true : false,
      child: Container(
        height: 1.sh,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 1.sw,
          height: 80.h,
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.h),
                    topRight: Radius.circular(10.h))),
            elevation: 10.h,
            child: Container(
                padding: EdgeInsets.all(10.h),
                child: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 20.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [title, SizedBox(height: 10.h), message],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class bottomSheetDialog {
  bottomSheetDialog({
    required this.context,
    required this.content,
    required this.dismissable,
  }) {
    show();
  }

  final Widget content;
  final bool dismissable;
  final BuildContext context;
  bool isShowing = false;

  void show() {
    if (!isShowing) {
      showGeneralDialog(
        barrierDismissible: dismissable,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        context: context,
        pageBuilder: (_, __, ___) {
          return bottomSheetDialog_ui(
              content: content, dismissable: dismissable);
        },
      );
      isShowing = true;
    }
  }

  void dismiss() {
    if (isShowing) {
      Navigator.of(context, rootNavigator: true).pop();
      isShowing = false;
    }
  }
}

class bottomSheetDialog_ui extends StatelessWidget {
  const bottomSheetDialog_ui({
    Key? key,
    required this.content,
    required this.dismissable,
  }) : super(key: key);

  final Widget content;
  final bool dismissable;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => dismissable ? true : false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: InkWell(
          onTap: () {
            if (dismissable) {
              onbackpress(context, isdialog: true);
            }
          },
          child: Container(
            height: 1.sh,
            alignment: Alignment.bottomCenter,
            child: InkWell(onTap: () {}, child: content),
          ),
        ),
      ),
    );
  }
}

// transpassword(
//   BuildContext context,
//   Function onpress, {
//   TextEditingController? password_controller,
//   TextEditingController? otp_controller,
//   bool istrans = true,
// }) {
//   final _trans_pass_formKey = GlobalKey<FormState>();
//
//   bottomSheetDialog(
//     context: context,
//     dismissable: true,
//     content: Wrap(
//       children: [
//         Stack(
//           alignment: AlignmentDirectional.bottomCenter,
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 30.h),
//               padding: EdgeInsets.all(20.h),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20))),
//               child: Form(
//                 key: _trans_pass_formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     boldText("Verifying User", ColorResources.blue1D3, 20),
//                     SizedBox(height: 15),
//                     CustomTextWidget(
//                         "please enter your ${istrans ? 'transaction ' : ''}password to proceed",
//                         size_txt: 13.sp),
//                     SizedBox(height: 10),
//                     password_controller != null
//                         ? text_form_field(
//                       istrans ? "Transaction password" : "Password",
//                       password_controller,
//                       textInputType: TextInputType.text,
//                       prefix_icon: Icon(Icons.lock_open_rounded),
//                       obscure: true,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Enter ${istrans ? 'Transaction ' : ''}password";
//                         }
//                         return null;
//                       },
//                     ):Container(),
//                     SizedBox(height: 10),
//                     otp_controller != null
//                         ? text_form_field(
//                       "OTP",
//                       otp_controller,
//                       textInputType: TextInputType.number,
//                       prefix_icon: Icon(Icons.password),
//                       obscure: true,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Enter OTP";
//                         }
//                         return null;
//                       },
//                     )
//                         : Container(),
//                     SizedBox(height: 10),
//                     containerButton(() {
//                       if (_trans_pass_formKey.currentState!.validate()) {
//                         onbackpress(PrefUtil.navKey.currentContext!,
//                             isdialog: true);
//                         onpress();
//                       }
//                     }, "Proceed"),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 0,
//               right: 0,
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20.w),
//                 alignment: Alignment.topRight,
//                 child: InkWell(
//                   onTap: () {
//                     onbackpress(PrefUtil.navKey.currentContext!,
//                         isdialog: true);
//                   },
//                   child: Card(
//                     elevation: 10.h,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50.h),
//                     ),
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     semanticContainer: true,
//                     color: Colors.transparent,
//                     child: Stack(
//                       alignment: AlignmentDirectional.center,
//                       children: [
//                         Container(
//                           height: 20.h,
//                           width: 20.w,
//                           color: Colors.white,
//                           alignment: Alignment.center,
//                         ),
//                         Image.asset(
//                           Images.close,
//                           height: 40.h,
//                           width: 40.w,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }

class DashLineView extends StatelessWidget {
  final double dashHeight;
  final double dashWith;
  final Color dashColor;
  final double fillRate; // [0, 1] totalDashSpace/totalSpace
  final Axis direction;

  DashLineView(
      {this.dashHeight = 1,
      this.dashWith = 8,
      this.dashColor = Colors.black,
      this.fillRate = 0.5,
      this.direction = Axis.horizontal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxSize = direction == Axis.horizontal
            ? constraints.constrainWidth()
            : constraints.constrainHeight();
        final dCount = (boxSize * fillRate / dashWith).floor();
        return Flex(
          children: List.generate(dCount, (_) {
            return SizedBox(
              width: direction == Axis.horizontal ? dashWith : dashHeight,
              height: direction == Axis.horizontal ? dashHeight : dashWith,
              child: DecoratedBox(
                decoration: BoxDecoration(color: dashColor),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: direction,
        );
      },
    );
  }
}

class OptionRadio extends StatefulWidget {
  final String text;
  final int index;
  final int selectedButton;
  final Function press;

  const OptionRadio({
    Key? key,
    required this.text,
    required this.index,
    required this.selectedButton,
    required this.press,
  }) : super();

  @override
  OptionRadioPage createState() => OptionRadioPage();
}

class OptionRadioPage extends State<OptionRadio> {
  // QuestionController controllerCopy =QuestionController();

  int id = 1;
  bool? _isButtonDisabled;

  OptionRadioPage();

  @override
  void initState() {
    _isButtonDisabled = false;
  }

  int? _selected = null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.press(widget.index);
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                  // height: 60.0,
                  child: Theme(
                data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.grey,
                    disabledColor: Colors.blue),
                child: Column(children: [
                  RadioListTile(
                    title: Transform.translate(
                      offset: const Offset(-18, 0),
                      child: Text(
                        "${widget.text}",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        softWrap: true,
                      ),
                    ),
                    /*Here the selectedButton which is null initially takes place of value after onChanged. Now, I need to clear the selected button when other button is clicked */
                    groupValue: widget.selectedButton,
                    value: widget.index,
                    activeColor: Colors.green,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) async {
                      debugPrint('Radio button is clicked onChanged $val');
                      // setState(() {
                      //   debugPrint('Radio button setState $val');
                      //   selectedButton = val;
                      //   debugPrint('Radio button is clicked onChanged $widget.index');
                      // });
                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                      // prefs.setInt('intValue', val);
                      widget.press(widget.index);
                    },
                    toggleable: true,
                  ),
                ]),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildcontainer(String s,
    {bool isempty = false,
    bool isbold = false,
    bool isheader = false,
    Function? onpressed,
    double? size_txt,
    String? status,
    Color txt_color = Colors.black}) {
  return InkWell(
    onTap: () {
      if (onpressed != null) {
        onpressed();
      }
    },
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5.h),
      child: CustomTextWidget(
        "${s != null ? s : isempty ? "" : "N/A"}",
        size_txt: size_txt != null ? size_txt : 11.sp,
        max_lines: 3,
        isbold: isbold,
        textAlign: isheader ? TextAlign.center : TextAlign.start,
        color_txt: isheader ? Colors.white : txt_color,
      ),
    ),
  );
}

String checkString(
  String? s, {
  bool isempty = false,
}) {
  return "${s != null ? s : isempty ? "" : "N/A"}";
}

onbackpress(BuildContext context,
    {bool isdialog = false, Map<String, dynamic>? data}) {
  if (isdialog) {
    return Navigator.of(context, rootNavigator: true).pop(data);
  } else {
    return Navigator.of(context).pop(data);
  }
}

sendActivity(BuildContext context, Widget funcs,
    {bool isreplace = false, Function? onrefresh, bool clearstack = false}) {
  if (clearstack) {
    return Navigator.pushAndRemoveUntil(
        context,
        PageTransition(type: PageTransitionType.rightToLeft, child: funcs),
        (route) => false);
  } else if (isreplace) {
    return Navigator.pushReplacement(
      context,
      PageTransition(type: PageTransitionType.rightToLeft, child: funcs),
    ).then((value) {
      if (onrefresh != null) {
        onrefresh();
      }
      return value;
    });
  } else {
    return Navigator.push(
      context,
      PageTransition(type: PageTransitionType.rightToLeft, child: funcs),
    ).then((value) {
      if (onrefresh != null) {
        onrefresh();
      }
      return value;
    });
  }
}

// Widget sendLoginscreen() {
//   return MultiBlocProvider(
//     providers: [],
//     child: OnBoardingScreen(),
//   );
// }

extension DoubleExtension on double {
  /// rounds the double to a specific decimal place
  double roundedPrecision(int places) {
    double mod = pow(10.0, places) as double;
    return ((this * mod).round().toDouble() / mod);
  }

  /// good for string output because it can remove trailing zeros
  /// and sometimes periods. Or optionally display the exact number of trailing
  /// zeros
  String roundedPrecisionToString(
    int places, {
    bool trailingZeros = false,
  }) {
    double mod = pow(10.0, places) as double;
    double round = ((this * mod).round().toDouble() / mod);
    String doubleToString =
        trailingZeros ? round.toStringAsFixed(places) : round.toString();
    if (!trailingZeros) {
      RegExp trailingZeros = RegExp(r'^[0-9]+.0+$');
      if (trailingZeros.hasMatch(doubleToString)) {
        doubleToString = doubleToString.split('.')[0];
      }
    }
    return doubleToString;
  }

  String toStringNoTrailingZeros() {
    String doubleToString = toString();
    RegExp trailingZeros = RegExp(r'^[0-9]+.0+$');
    if (trailingZeros.hasMatch(doubleToString)) {
      doubleToString = doubleToString.split('.')[0];
    }
    return doubleToString;
  }
}
//
// shareapp() async {
//   PackageInfo packageInfo = await PackageInfo.fromPlatform();
//   String packageName = packageInfo.packageName;
//
//   ByteData byteData = await rootBundle.load(Images.appLogo);
//
//   Directory appDocDir = await getApplicationDocumentsDirectory();
//   String appDocPath = appDocDir.path;
//   // this creates the file image
//   File file = await File('$appDocPath/app_icon.png').create(recursive: true);
//
//   // copies data byte by byte
//   await file.writeAsBytes(byteData.buffer
//       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//   debugPrint('file_path:${file.path}');
//   //Share.shareFiles(['${file.path}'],
//   Share.shareXFiles([XFile(file.path)],
//       text:
//           "Install ${AppConstants.appname} and get Registered Using My ID:- ${PrefUtil.getreg() != null ? PrefUtil.getreg()!.rows![0].memberId : PrefUtil.getcustomer_reg() != null ? PrefUtil.getcustomer_reg()!.rows![0].id : ''} to Get Registration Benefit\n"
//           "https://play.google.com/store/apps/details?id=$packageName"
//           "&referrer=utm_source%3Dgoogle%26utm_campaign%3D${PrefUtil.getreg() != null ? PrefUtil.getreg()!.rows![0].memberId : PrefUtil.getcustomer_reg() != null ? PrefUtil.getcustomer_reg()!.rows![0].id : ''}");
// }
//
// shareurl(String s) async {
//   PackageInfo packageInfo = await PackageInfo.fromPlatform();
//   String packageName = packageInfo.packageName;
//
//   ByteData byteData = await rootBundle.load(Images.appLogo);
//
//   Directory appDocDir = await getApplicationDocumentsDirectory();
//   String appDocPath = appDocDir.path;
//   // this creates the file image
//   File file = await File('$appDocPath/app_icon.png').create(recursive: true);
//
//   // copies data byte by byte
//   await file.writeAsBytes(byteData.buffer
//       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//   debugPrint('file_path:${file.path}');
//   Share.shareFiles(['${file.path}'], text: s);
// }
