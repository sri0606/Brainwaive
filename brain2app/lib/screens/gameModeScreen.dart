import 'dart:convert';

import 'package:brain2app/screens/flashcardScreen.dart';
import 'package:brain2app/screens/quiz/quizz_screen.dart';
import 'package:flutter/material.dart';
import 'package:brain2app/mainViewModel/mainViewModel.dart';

import 'package:http/http.dart' as http;

class gameMode extends StatefulWidget {
  final String title;
  final String quizTopic;
  final int numberOfQuestions;

  const gameMode(
      {Key? key,
      required this.title,
      required this.quizTopic,
      required this.numberOfQuestions})
      : super(key: key);

  @override
  State<gameMode> createState() => _gameModeState(
      title: title, quizTopic: quizTopic, numberOfQuestions: numberOfQuestions);
}

class _gameModeState extends State<gameMode> {
  final String title;
  final String quizTopic;
  final int numberOfQuestions;

  _gameModeState(
      {required this.title,
      required this.quizTopic,
      required this.numberOfQuestions});

  double _currentSliderValue = 5;

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
        child: Container(
          // vertically center
          alignment: Alignment.center,
          child: Center(
            child: Column(
              children: [
                Container(),
                SizedBox(
                  height: 100,
                ),
                // print passed in title
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 100,
                ),
                const Text(
                  'What would you like to do?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 50,
                ),
                // create transparent box with outline and rounded corners
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 50,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Quiz',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizzScreen(
                                quizTopic: quizTopic,
                                numberOfQuestions: numberOfQuestions,
                              )),
                    );
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 50,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Flashcards',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const flashcardScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
