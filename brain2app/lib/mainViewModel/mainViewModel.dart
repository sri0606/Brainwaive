import 'package:flutter/material.dart';
import '../utilities/stateNotifier.dart';

final MainViewModel mainViewModel = MainViewModel();

class MainViewModel with StateNotifier {
  MainViewModel();

  //Test data
  String testString = 'test string';
}
