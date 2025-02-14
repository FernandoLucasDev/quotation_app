import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotation/utils/colors.dart';

class CustomModal {
  static void show({
    required BuildContext context,
    required Widget content,
    String title = "Select Currency",
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: containerBackground,
          title: Text(
            "Select a currency",
            style: GoogleFonts.inter(
              fontSize: 16,
              color: secondaryTextColor,
            ),
          ),
          content: content,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Ok",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: btnBackgroundColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}