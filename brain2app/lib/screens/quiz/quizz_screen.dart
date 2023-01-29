import 'dart:convert';

import 'package:brain2app/screens/createScreen.dart';
import 'package:brain2app/screens/quiz/question_model.dart';
import 'package:brain2app/screens/quiz/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:brain2app/mainViewModel/mainViewModel.dart';

import 'color.dart';

class QuizzScreen extends StatefulWidget {
  final String quizTopic;
  final int numberOfQuestions;
  QuizzScreen({
    Key? key,
    required this.quizTopic,
    required this.numberOfQuestions,
  }) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState(
      quizTopic: quizTopic, numberOfQuestions: numberOfQuestions);
}

class _QuizzScreenState extends State<QuizzScreen> {
  _QuizzScreenState({required quizTopic, required numberOfQuestions});

  int question_pos = 0;
  int score = 0;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next";
  bool answered = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //app bar
        appBar: AppBar(
          // make background color FAFAFA
          backgroundColor: const Color(0xFFFAFAFA),
          title: Text(
            "Quiz",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
            ),
          ),
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
        body:
            // store response in mainViewModel
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: PageView.builder(
                  controller: _controller!,
                  onPageChanged: (page) {
                    if (page == mainViewModel.questions.length - 1) {
                      setState(() {
                        btnText = "See Results";
                      });
                    }
                    setState(() {
                      answered = false;
                    });
                  },
                  physics: new NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Question ${index + 1}/${mainViewModel.questions.length}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.0,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 200.0,
                          child: Text(
                            "${mainViewModel.questions[index].question}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        for (int i = 0;
                            i < mainViewModel.questions[index].answers!.length;
                            i++)
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            margin: EdgeInsets.only(
                                bottom: 20.0, left: 12.0, right: 12.0),
                            child: RawMaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              fillColor: btnPressed
                                  ? mainViewModel
                                          .questions[index].answers!.values
                                          .toList()[i]
                                      ? Colors.green
                                      : Colors.red
                                  : Colors.black,
                              onPressed: !answered
                                  ? () {
                                      if (mainViewModel
                                          .questions[index].answers!.values
                                          .toList()[i]) {
                                        score++;
                                        print("yes");
                                      } else {
                                        print("no");
                                      }
                                      setState(() {
                                        btnPressed = true;
                                        answered = true;
                                      });
                                    }
                                  : null,
                              child: Text(
                                  mainViewModel.questions[index].answers!.keys
                                      .toList()[i],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  )),
                            ),
                          ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          width: 150,
                          child: RawMaterialButton(
                            onPressed: () {
                              if (_controller!.page?.toInt() ==
                                  mainViewModel.questions.length - 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ResultScreen(score)));
                              } else {
                                _controller!.nextPage(
                                    duration: Duration(milliseconds: 250),
                                    curve: Curves.easeInExpo);

                                setState(() {
                                  btnPressed = false;
                                });
                              }
                            },
                            shape: StadiumBorder(),
                            fillColor: Colors.black,
                            padding: EdgeInsets.all(18.0),
                            elevation: 0.0,
                            child: Text(
                              btnText,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: mainViewModel.questions.length,
                )));
  }
}
