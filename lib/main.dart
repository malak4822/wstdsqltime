import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color blackGucci = const Color.fromARGB(255, 40, 40, 40);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double counter = 0;
  double inHours = 0;

  double contWidth = 0;
  bool showSwitchCard = false;

  void loadBool() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getDouble('wastedTime') ?? 0;
    });
  }

  void resetCounter() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setDouble('wastedTime', 0);
    setState(() {
      counter = 0;
    });
    timeInHours();
  }

  void addLessonTime() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = counter + 45.00;
    });
    prefs.setDouble('wastedTime', counter);
    timeInHours();
  }

  void timeInHours() {
    setState(() {
      inHours = counter / 60;
    });
  }

  void eee() {
    setState(() {
      if (showSwitchCard) {
        contWidth = MediaQuery.of(context).size.width;
      } else {
        contWidth = 0;
      }
    });
  }

  @override
  void initState() {
    loadBool();
    timeInHours();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: blackGucci,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(60),
              ),
              onPressed: resetCounter,
              child: Text("Reset time",
                  style: GoogleFonts.overpass(
                      color: blackGucci, fontWeight: FontWeight.bold))),
        ]),
      ),
      appBar: AppBar(
        backgroundColor: blackGucci,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(children: [
                  InkWell(
                    onTap: () {
                      showSwitchCard = !showSwitchCard;
                      eee();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: blackGucci,
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Text("Add Custom Time",
                          style: GoogleFonts.overpass(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                    ),
                  ),
                  AnimatedContainer(
                      color: const Color.fromARGB(255, 108, 108, 108),
                      width: contWidth,
                      curve: Curves.easeInOutCirc,
                      duration: const Duration(milliseconds: 400),
                      alignment: Alignment.center,
                      child: Visibility(
                          visible: showSwitchCard,
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showSwitchCard = !showSwitchCard;
                                    });
                                    eee();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    color: Colors.black,
                                    height: double.infinity,
                                    child: const Icon(Icons.close,
                                        color: Colors.white, size: 50),
                                  )),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Switch(
                                    value: true,
                                    onChanged: (bool value) {
                                      setState(() {
                                        value = !value;
                                      });
                                    }))
                          ])))
                ])),
            Container(color: Colors.white, width: double.maxFinite, height: 1),
            button(addLessonTime, 'dodaj lekcje (45 min.)'),
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You wasted :',
                      style: GoogleFonts.overpass(fontSize: 25),
                    ),
                    Text(
                      '$counter mins',
                      style: GoogleFonts.overpass(
                          fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    Text(
                      "and that's",
                      style: GoogleFonts.overpass(fontSize: 25),
                    ),
                    Text(
                      "$inHours hours",
                      style: GoogleFonts.overpass(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget button(func, String txt) => Expanded(
      flex: 2,
      child: GestureDetector(
          onTap: func,
          child: Container(
            color: blackGucci,
            width: double.infinity,
            child: Center(
                child: Text(
              txt,
              style: GoogleFonts.overpass(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
          )));
}
