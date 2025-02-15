import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotation/utils/colors.dart';

class TextInputCustom extends StatelessWidget {
  final TextEditingController inputKey;
  final double borderRadius;
  final String errorMsg;
  final String textHint;
  final bool sensitive;
  final bool isNumber;

  const TextInputCustom({
    Key? key,
    required this.inputKey,
    required this.errorMsg,
    required this.textHint,
    required this.borderRadius,
    required this.sensitive,
    this.isNumber = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: inputKey,
        obscureText: sensitive,
        cursorColor: secondaryTextColor,
        style: TextStyle(color: secondaryTextColor),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumber
            ? [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
        ]
            : [],
        decoration: InputDecoration(
          labelText: textHint,
          labelStyle: TextStyle(color: secondaryTextColor),
          counterStyle: TextStyle(color: secondaryTextColor),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: borderColor, width: 2.0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorMsg;
          }

          if (isNumber) {
            final sanitizedValue = value.replaceAll(',', '.');
            final numberValue = double.tryParse(sanitizedValue);

            if (numberValue == null) {
              return 'Digite um número válido';
            }
            if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(sanitizedValue)) {
              return 'Apenas duas casas decimais são permitidas';
            }
          }

          return null;
        },
      ),
    );
  }
}
