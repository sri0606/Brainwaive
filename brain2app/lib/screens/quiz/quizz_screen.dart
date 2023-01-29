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

  Future<http.Response> fetchQuestions(String quizTopic) async {
    var url = Uri.https(
        'us-central1-brainwaive-76ded.cloudfunctions.net', '/gptinput');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'question': quizTopic,
          'howManyQuestions': 5,
          'isQuestion': 'true'
        }));

    mainViewModel.quizQuestions = json.decode(response.body);

    return response;
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

      body: FutureBuilder(
        builder: (ctx, snapshot) {
          // Checking if future is resolved or not
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasData) {
              // store response in mainViewModel

              // parse response into questions
              for (var i = 0; i < mainViewModel.quizQuestions.length; i++) {
                // find the correct answer, look at fifth element in list
                int correct = 0;

                // find first character in string
                var firstEntry = mainViewModel.quizQuestions[i].entries.first;
                // what does 1) jdslfjklsd
                var firstKey = firstEntry.key;
                // list 5 items
                var firstValue = firstEntry.value;

                if (mainViewModel.quizQuestions[i].entries.first.value[4]
                            .substring(0, 1) ==
                        'A' ||
                    mainViewModel.quizQuestions[i].entries.first.value[4]
                            .substring(0, 1) ==
                        'a') {
                  correct = 0;
                } else if (mainViewModel.quizQuestions[i].entries.first.value[4]
                            .substring(0, 1) ==
                        'B' ||
                    mainViewModel.quizQuestions[i].entries.first.value[4]
                            .substring(0, 1) ==
                        'b') {
                  correct = 1;
                } else if (mainViewModel.quizQuestions[i].entries.first.value[4]
                            .substring(0, 1) ==
                        'C' ||
                    mainViewModel.quizQuestions[i].entries.first.value[4]
                            .substring(0, 1) ==
                        'c') {
                  correct = 2;
                } else if (mainViewModel.quizQuestions[i].entries.first.value[4]
                            .substring(0, 1) ==
                        'D' ||
                    mainViewModel.quizQuestions[i].entries.first.value[4]
                            .substring(0, 1) ==
                        'd') {
                  correct = 3;
                }

                // create new QuestionModel object
                mainViewModel.questions.add(QuestionModel(firstEntry.key, {
                  firstValue[0]: correct == 0 ? true : false,
                  firstValue[1]: correct == 1 ? true : false,
                  firstValue[2]: correct == 2 ? true : false,
                  firstValue[3]: correct == 3 ? true : false,
                }));
              }
              // Extracting data from snapshot object
              final data = snapshot.data as http.Response;
              return Padding(
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
                              i <
                                  mainViewModel
                                      .questions[index].answers!.length;
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: mainViewModel.questions.length,
                  ));
            }
          }

          // Displaying LoadingSpinner to indicate waiting state
          return Center(
            child: CircularProgressIndicator(),
          );
        },

        // Future that needs to be resolved
        // inorder to display something on the Canvas
        future: fetchQuestions(quizQuestion),
      ),
    );
  }
}
