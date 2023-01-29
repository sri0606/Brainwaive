import 'package:brain2app/screens/homeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // hide debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // add padding
          SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: <Widget>[
              // image of logo
              Image.asset(
                'images/signInLogo.png',
                height: 300,
                width: 600,
              ),
              TextField(
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

                  hintText: 'Username',
                ),
              ),
              // create invisible sized box
              const SizedBox(height: 10),
              TextField(
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

                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 176),
              // create button
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 50,
                        width: 125,
                        child: ElevatedButton(
                          onPressed: () {
                            // navigate to homeScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const homeScreen(
                                  title: 'Home Screen',
                                ),
                              ),
                            );
                          },
                          child: const Text('Sign In'),
                          // make color black
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 50,
                        width: 125,
                        child: ElevatedButton(
                          onPressed: () {
                            // navigate to homeScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const homeScreen(
                                  title: 'Home Screen',
                                ),
                              ),
                            );
                          },
                          child: const Text('Sign Up'),
                          // make color black
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}
