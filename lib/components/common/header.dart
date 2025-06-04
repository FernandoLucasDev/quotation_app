import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotation/utils/colors.dart';

class Header extends StatelessWidget {
  const Header ({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0, left: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Image.asset("assets/logobg.png", height: 32.0),
              SizedBox(width: 8.0),
              Text(
                "Quotation App",
                style: GoogleFonts.inter(
                    fontSize: 14,
                    color: primaryTextColor
                ),
              ),
            ],
          ),
        ),
    );
  }
}
