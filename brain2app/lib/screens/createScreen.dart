import 'package:flutter/material.dart';
import 'package:brain2app/mainViewModel/mainViewModel.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'gameModeScreen.dart';

class SliderExample extends StatefulWidget {
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

var quizTitle = '';

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
                            hintText: 'Title',
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
                            hintText: 'Question',
                          ),
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
                          onPressed: () {
                            // navigate to homeScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      gameMode(title: quizTitle)),
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
