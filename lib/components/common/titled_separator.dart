import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotation/utils/colors.dart';

class TitledSeparator extends StatelessWidget {
  const TitledSeparator({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 24,
            color: primaryTextColor
          ),
        ),
      ),
    );
  }
}
