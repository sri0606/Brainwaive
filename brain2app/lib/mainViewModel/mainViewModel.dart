import 'package:flutter/material.dart';
import '../utilities/stateNotifier.dart';
import 'package:brain2app/screens/quiz/question_model.dart';

final MainViewModel mainViewModel = MainViewModel();

class MainViewModel with StateNotifier {
  MainViewModel();

  //Test data
  String testString = 'test string';

  var quizQuestions;

  // quizQuestions Data
  List<QuestionModel> questions = [];

  bool isQuizStarted = false;

  int questionIndex = 0;
}
