import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotation/utils/colors.dart';

class CurrencyCard extends StatelessWidget {

  const CurrencyCard({super.key, required this.bid, required this.currency, required this.min, required this.max, required this.isValuating});

  final String bid;
  final String currency;
  final String min;
  final String max;
  final bool isValuating;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 10.0),
          child: Container(
            width: double.infinity,
            height: 170.0,
            decoration: BoxDecoration(
              color: containerBackground,
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                      left: 34.0, top: 8.0
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        currency,
                        style: GoogleFonts.inter(
                            fontSize: 24,
                            color: primaryTextColor
                        ),
                      ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: 34.0, top: 12.0
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "R\$$bid",
                        style: GoogleFonts.inter(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: isValuating ? upTextColor : downTextColor
                        ),
                      ),
                      Icon(
                        isValuating ? Icons.keyboard_double_arrow_up : Icons.keyboard_double_arrow_down,
                        color: isValuating ? upTextColor : downTextColor,
                        size: 40.0,
                        weight: 600.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 34.0, top: 8.0
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Min: R\$$min",
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: secondaryTextColor
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Max: R\$$max",
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: secondaryTextColor
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
