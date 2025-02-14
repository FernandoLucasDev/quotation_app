import 'package:flutter/material.dart';
import 'package:quotation/views/quotation_screen.dart';

class ScreensNavigation extends ChangeNotifier {

  int presentationScreen = 1;

  Map<int, dynamic> screens = {
    1: QuotationScreen(),
  };

  void changeScreen(screenNumber) => screens.containsKey(screenNumber) ? screens[screenNumber] : screens[1];

}
