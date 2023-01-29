import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:brain2app/mainViewModel/mainViewModel.dart';

import 'gameModeScreen.dart';

class flashcardScreen extends StatefulWidget {
  const flashcardScreen({Key? key}) : super(key: key);

  @override
  State<flashcardScreen> createState() => _flashcardScreenState();
}

class _flashcardScreenState extends State<flashcardScreen> {
  @override
  Widget build(BuildContext context) {
    // returning MaterialApp
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flashcards"),
          backgroundColor: Colors.black,
          // add back button
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        // body has a center with row child.
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Flipcard with vertical
              // direction when flip
              FlipCard(
                direction: FlipDirection.HORIZONTAL,
                // front of the card
                front: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 200,
                  color: Colors.grey[300],
                  child: Text("Front"),
                ),
                // back of the card
                back: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 200,
                  color: Colors.grey[300],
                  child: Text("Back"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // 2nd card showing Horizontal FlipDirection
              FlipCard(
                direction: FlipDirection.HORIZONTAL,
                // front of the card
                front: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 200,
                  color: Colors.grey[300],
                  child: Text("Front"),
                ),
                // back of the card
                back: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 200,
                  color: Colors.grey[300],
                  child: Text("Back"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
