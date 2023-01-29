import 'dart:convert';

import 'package:brain2app/screens/quiz/question_model.dart';
import 'package:flutter/material.dart';
import 'package:brain2app/mainViewModel/mainViewModel.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:http/http.dart' as http;

import 'gameModeScreen.dart';

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

var quizTitle = '';

var quizQuestion = '';

class _SliderExampleState extends State<SliderExample> {
  double _currentSliderValue = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // make text black
        title: const Text(
          'Create Quiz',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
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
            // add padding
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // row with title and text field
                  Row(
                    children: [
                      // set width of text

                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          // background color to B0aFBB

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE1E1E5),
                            // change border radius to 25
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              // make width of border 0
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: 'Set Title',
                          ),

                          // onchanged
                          onChanged: (String value) {
                            quizTitle = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // row with question field
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          // background color to B0aFBB

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE1E1E5),
                            // change border radius to 25
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              // make width of border 0
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: 'Topic',
                          ),

                          onChanged: (String value) {
                            quizTitle = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // text of number of questions centered
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Number of Questions',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto'),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  // slider from 5 to 20
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text 5 is bold
                      Expanded(
                        child:
                            // change color of tooltip to black

                            SfSlider(
                          min: 5.0,
                          max: 20.0,
                          value: _currentSliderValue.roundToDouble(),
                          interval: 5,
                          showTicks: true,
                          showLabels: true,
                          enableTooltip: true,
                          tooltipShape: SfPaddleTooltipShape(),
                          minorTicksPerInterval: 1,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey,
                          onChanged: (dynamic value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // button for submit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 125,
                        child: ElevatedButton(
                          onPressed: () async {
                            // TODO: construct http request
                            Future<http.Response> fetchQuestions(
                                String quizTopic) async {
                              var url = Uri.https(
                                  'us-central1-brainwaive-76ded.cloudfunctions.net',
                                  '/gptinput');
                              var response = await http.post(url,
                                  headers: {"Content-Type": "application/json"},
                                  body: json.encode({
                                    'question': quizTitle,
                                    'howManyQuestions': 5,
                                    'isQuestion': 'true'
                                  }));

                              mainViewModel.quizQuestions =
                                  json.decode(response.body);

                              return response;
                            }

                            var response = await fetchQuestions(quizQuestion);

                            // parse response into questions
                            for (var i = 0;
                                i < mainViewModel.quizQuestions.length;
                                i++) {
                              // find the correct answer, look at fifth element in list
                              int correct = 0;

                              // find first character in string
                              var firstEntry =
                                  mainViewModel.quizQuestions[i].entries.first;
                              // what does 1) jdslfjklsd
                              var firstKey = firstEntry.key;
                              // list 5 items
                              var firstValue = firstEntry.value;

                              if (mainViewModel.quizQuestions[i].entries.first
                                          .value[4]
                                          .substring(0, 1) ==
                                      'A' ||
                                  mainViewModel.quizQuestions[i].entries.first
                                          .value[4]
                                          .substring(0, 1) ==
                                      'a') {
                                correct = 0;
                              } else if (mainViewModel.quizQuestions[i].entries
                                          .first.value[4]
                                          .substring(0, 1) ==
                                      'B' ||
                                  mainViewModel.quizQuestions[i].entries.first
                                          .value[4]
                                          .substring(0, 1) ==
                                      'b') {
                                correct = 1;
                              } else if (mainViewModel.quizQuestions[i].entries
                                          .first.value[4]
                                          .substring(0, 1) ==
                                      'C' ||
                                  mainViewModel.quizQuestions[i].entries.first
                                          .value[4]
                                          .substring(0, 1) ==
                                      'c') {
                                correct = 2;
                              } else if (mainViewModel.quizQuestions[i].entries
                                          .first.value[4]
                                          .substring(0, 1) ==
                                      'D' ||
                                  mainViewModel.quizQuestions[i].entries.first
                                          .value[4]
                                          .substring(0, 1) ==
                                      'd') {
                                correct = 3;
                              }

                              // create new QuestionModel object
                              mainViewModel.questions
                                  .add(QuestionModel(firstEntry.key, {
                                firstValue[0]: correct == 0 ? true : false,
                                firstValue[1]: correct == 1 ? true : false,
                                firstValue[2]: correct == 2 ? true : false,
                                firstValue[3]: correct == 3 ? true : false,
                              }));
                            }

                            // navigate to homeScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => gameMode(
                                      title: quizTitle,
                                      quizTopic: quizQuestion,
                                      numberOfQuestions:
                                          _currentSliderValue.toInt())),
                            );
                          },
                          // make submit text larger
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          // make color black
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
