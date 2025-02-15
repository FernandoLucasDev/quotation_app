import 'package:flutter/material.dart';
import 'package:quotation/utils/colors.dart';

class SelectButton extends StatelessWidget {
  final VoidCallback onPressed;
  final int days;

  const SelectButton({Key? key, required this.onPressed, required this.days}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: containerBackground,
        foregroundColor: Colors.white,
        side: BorderSide(
          color: borderColor, // Cor da borda
          width: 1.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_month_outlined, color: primaryTextColor),
          SizedBox(width: 5.0),
          Text("$days days"),
          SizedBox(width: 5.0),
          Icon(Icons.arrow_drop_down, color: primaryTextColor),
        ],
      ),
    );
  }
}