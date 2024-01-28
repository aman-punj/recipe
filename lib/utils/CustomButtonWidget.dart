import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'CustomTextWidget.dart';
import 'colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String? _title;
  final Color? _textcolor;
  final Color _bgcolor;
  final Color _bordercolor;
  final double? _textsize;
  final double? _height;
  final double? _width;
  final IconData? _iconData;
  final Color? _iconcolor;
  final double? _iconsize;
  final bool _isoutline;
  final Function? _onpressed;
  final double? _elevation;
  final int _max_lines;

  CustomButtonWidget(String? title,
      {Key? key,
      Color bg_color = ColorResources.pinkDB4,
      Color border_color = ColorResources.black,
      Color txt_color = ColorResources.white,
      double? txt_size=16,
      double? height=40,
      double? width,
      IconData? iconData,
      Color? icon_color,
      double? icon_size,
      bool isoutline = false,
      double elevation = 3,
      int max_lines = 1,
      Function? onpressed})
      : this._title = title,
        this._bgcolor = bg_color,
        this._bordercolor = border_color,
        this._textcolor = txt_color,
        this._textsize = txt_size,
        this._height = height,
        this._width = width,
        this._iconData = iconData,
        this._iconcolor = icon_color,
        this._iconsize = icon_size,
        this._isoutline = isoutline,
        this._elevation = elevation,
        this._max_lines = max_lines,
        this._onpressed = onpressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_isoutline) {
      return InkWell(
        onTap: () async {
          await _onpressed!();
        },
        child: Card(
          elevation: _elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
            height: _height,
            width: _width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: _bgcolor,
                border: Border.all(color: _bordercolor, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(5.h))),
            child: _iconData != null
                ? Row(
                    children: [
                      Icon(
                        _iconData,
                        color: _iconcolor,
                        size: _iconsize,
                      ),
                      SizedBox(width: 10.h),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: CustomTextWidget(
                            '$_title',
                            color_txt: _textcolor,
                            size_txt: _textsize,
                            max_lines: _max_lines,
                          ),
                        ),
                      ),
                    ],
                  )
                : CustomTextWidget(
                    '$_title',
                    color_txt: _textcolor,
                    size_txt: _textsize,
                    textAlign: TextAlign.center,
                    max_lines: _max_lines,
                  ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () async {
          await _onpressed!();
        },
        child: Card(
          elevation: _elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
            height: _height,
            width: _width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: _bgcolor,
                borderRadius: BorderRadius.all(Radius.circular(5.h))),
            child: _iconData != null
                ? Row(
                    children: [
                      Icon(
                        _iconData,
                        color: _iconcolor,
                        size: _iconsize,
                      ),
                      SizedBox(width: 10.h),
                      CustomTextWidget(
                        '$_title',
                        color_txt: _textcolor,
                        size_txt: _textsize,
                      ),
                    ],
                  )
                : CustomTextWidget(
                    '$_title',
                    color_txt: _textcolor,
                    size_txt: _textsize,
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      );
    }
  }
}

class CustomButtonSecondWidget extends StatelessWidget {
  final String? _title;
  final Color? _color;
  final double? _size;
  final IconData? _iconData;
  final Color? _iconcolor;
  final double? _iconsize;
  final Function? _onpressed;

  CustomButtonSecondWidget(
      {Key? key,
      @required String? title,
      Color? color_txt,
      double? size_txt,
      IconData? iconData,
      Color? icon_color,
      double? icon_size,
      Function? onpressed})
      : this._title = title,
        this._color = color_txt,
        this._size = size_txt,
        this._iconData = iconData,
        this._iconcolor = icon_color,
        this._iconsize = icon_size,
        this._onpressed = onpressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _onpressed!();
      },
      child: _iconData != null
          ? Row(
              children: [
                Icon(
                  _iconData,
                  color: _iconcolor,
                  size: _iconsize,
                ),
                SizedBox(width: 10.h),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '$_title',
                      style: TextStyle(color: _color, fontSize: _size),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            )
          : Text(
              '$_title',
              style: TextStyle(color: _color, fontSize: _size),
              overflow: TextOverflow.ellipsis,
            ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
        elevation: 3.h,
      ),
    );
  }
}

class CustomButtonOutlineWidget extends StatelessWidget {
  final String? _title;
  final Color? _color;
  final double? _size;
  final Function? _onpressed;
  final IconData? _iconData;
  final Color? _iconcolor;
  final double? _iconsize;

  CustomButtonOutlineWidget(
      {Key? key,
      @required String? title,
      Color? color_txt,
      double? size_txt,
      IconData? iconData,
      Color? icon_color,
      double? icon_size,
      Function? onpressed})
      : this._title = title,
        this._color = color_txt,
        this._size = size_txt,
        this._iconData = iconData,
        this._iconcolor = icon_color,
        this._iconsize = icon_size,
        this._onpressed = onpressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        _onpressed!();
      },
      child: _iconData != null
          ? Row(
              children: [
                Icon(
                  _iconData,
                  color: _iconcolor,
                  size: _iconsize,
                ),
                SizedBox(width: 10.h),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '$_title',
                      style: TextStyle(color: _color, fontSize: _size),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            )
          : Text(
              '$_title',
              style: TextStyle(color: _color, fontSize: _size),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
        side: BorderSide(width: 1.0, color: Colors.grey[500]!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        elevation: 5.h,
      ),
    );
  }
}
