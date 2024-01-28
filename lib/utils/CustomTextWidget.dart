import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'font_family.dart';

class CustomTextWidget extends StatelessWidget {
  final String? _title;
  final Color? _color;
  final double? _size;
  final int? _maxlines;
  final TextAlign? _textAlign;
  final double? _linespace;
  final String? _fontfamily;
  final bool _isbold;
  final bool _issemibold;
  final TextOverflow _textOverflow;

  CustomTextWidget(String? title,
      {Key? key,
      Color? color_txt,
      double? size_txt,
      int? max_lines,
      TextAlign? textAlign,
      double? line_space,
      String? font_family,
      bool isbold = false,
      bool issemibold = false,
        TextOverflow textOverflow = TextOverflow.ellipsis})
      : this._title = title,
        this._color = color_txt,
        //   this._size = size_txt,
        this._size = size_txt == null ? 11.sp : size_txt,
        this._maxlines = max_lines,
        this._textAlign = textAlign,
        this._linespace = line_space,
        this._fontfamily = font_family,
        this._isbold = isbold,
        this._issemibold = issemibold,
        this._textOverflow = textOverflow,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_title',
      style: TextStyle(
          fontFamily: _fontfamily != null
              ? _fontfamily
              : _isbold
                  ? TextFontFamily.ROBOTO_BOLD
                  : TextFontFamily.ROBOTO_REGULAR,
          fontWeight: _isbold
              ? FontWeight.w600
              : _issemibold
                  ? FontWeight.w400
                  : FontWeight.normal,
          color: _color,
          fontSize: _size,
          letterSpacing: _linespace,
          height: _linespace),
      overflow: _textOverflow,
      maxLines: _maxlines,
      textAlign: _textAlign,
    );
  }
}
