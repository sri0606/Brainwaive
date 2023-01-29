import 'package:flutter/material.dart';
import 'package:brain2app/mainViewModel/mainViewModel.dart';

import 'createScreen.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // add padding
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // made text bold with large font, also left align
                  const Text(
                    'Previous Scores',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  // list view of previous scores
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('Name of Set'),
                        trailing: Text('Score'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // navbar
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          // Respond to item press.
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SliderExample()),
            );
          }
        },
        selectedFontSize: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Settings',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.black,
      ),
    );
  }
}
