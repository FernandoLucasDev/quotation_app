import 'package:flutter/material.dart';
import 'package:quotation/utils/colors.dart';

class CurrencyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final currency;

  const CurrencyButton({super.key, required this.onPressed, this.currency});

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
          Icon(Icons.attach_money, color: primaryTextColor),
          SizedBox(width: 5.0),
          Text(currency),
          SizedBox(width: 5.0),
          Icon(Icons.arrow_drop_down, color: primaryTextColor),
        ],
      ),
    );
  }
}