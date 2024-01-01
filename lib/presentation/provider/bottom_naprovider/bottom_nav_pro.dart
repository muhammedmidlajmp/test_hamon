import 'package:flutter/material.dart';
import 'package:test_hamon/constants/bottom_nav_item.dart';

class BottomNavBarProvider extends ChangeNotifier {
  BottomNavItem _currentItem = BottomNavItem.student;

  BottomNavItem get currentItem => _currentItem;

  void setCurrentItem(BottomNavItem item) {
    _currentItem = item;
    notifyListeners();
  }
}