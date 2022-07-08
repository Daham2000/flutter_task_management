import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnackBarFactory {
  SnackBar getSnackBar({String? title, bool? isFail, double? fontSize}) {
    return SnackBar(
      backgroundColor: isFail == true
          ? Color(0xFFEC3939)
          : title == "Your are offline"
              ? Colors.blue
              : Color(0xFF00A81E),
      margin: EdgeInsets.all(12),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 300,
            height: title=="To download the content please subscribe to the Premium version" ? 60 : 20,
            child: Text(
              title ?? "",
              overflow: TextOverflow.clip,
              style: GoogleFonts.metrophobic(
                fontSize: getSnackBarFontSize(fontSize ?? 0.2),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double getSnackBarFontSize(double fontSize) {
    double textSize = 0;
    if (fontSize >= 1.3) {
      textSize = 12;
    } else {
      textSize = 17;
    }
    return textSize;
  }
}
