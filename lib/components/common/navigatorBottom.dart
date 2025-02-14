import 'package:flutter/material.dart';
import 'package:quotation/utils/colors.dart';

class Navigatorbottom extends StatefulWidget {
  const Navigatorbottom({super.key});

  @override
  State<Navigatorbottom> createState() => _NavigatorbottomState();
}

class _NavigatorbottomState extends State<Navigatorbottom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 10.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 220,
          height: 60,
          decoration: BoxDecoration(
            color: containerBackground,
            borderRadius: BorderRadius.circular(20.0)
          ),
        ),
      ),
    );
  }
}
