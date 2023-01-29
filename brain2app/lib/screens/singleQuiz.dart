import 'dart:convert';

import 'package:brain2app/screens/flashcardScreen.dart';
import 'package:brain2app/screens/quiz/quizz_screen.dart';
import 'package:flutter/material.dart';
import 'package:brain2app/mainViewModel/mainViewModel.dart';

import 'package:http/http.dart' as http;

class singleQuiz extends StatefulWidget {
  final String title;
  final String quizTopic;
  final int numberOfQuestions;

  const singleQuiz(
      {Key? key,
      required this.title,
      required this.quizTopic,
      required this.numberOfQuestions})
      : super(key: key);

  @override
  State<singleQuiz> createState() => _singleQuizState(
      title: title, quizTopic: quizTopic, numberOfQuestions: numberOfQuestions);
}

class _singleQuizState extends State<singleQuiz> {
  final String title;
  final String quizTopic;
  final int numberOfQuestions;

  _singleQuizState(
      {required this.title,
      required this.quizTopic,
      required this.numberOfQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // make background color FAFAFA
        backgroundColor: const Color(0xFFFAFAFA),
        // remove shadow
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 40),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('Q1'),
          ],
        ),
      ),
    );
  }
}
