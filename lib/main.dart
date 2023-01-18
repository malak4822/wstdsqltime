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
      debugShowCheckedModeBanner: false,
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
  double sliderMinutes = 0;
  double contWidth = 0;
  bool showSwitchCard = false;
  double buttOpacity = 0;
  bool hasEndings = true;

  void loadBool() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getDouble('wastedTime') ?? 0;
    });
    timeInHours();
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
                padding: const EdgeInsets.all(70),
              ),
              onPressed: resetCounter,
              child: Text("Reset time",
                  style: GoogleFonts.overpass(
                      color: blackGucci,
                      fontWeight: FontWeight.bold,
                      fontSize: 30))),
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
                      child: AnimatedOpacity(
                          curve: Curves.easeInOutCirc,
                          opacity: showSwitchCard ? 1 : buttOpacity,
                          duration: const Duration(milliseconds: 400),
                          child: Row(children: [
                            Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Slider(
                                          activeColor: Colors.white,
                                          thumbColor: Colors.black,
                                          inactiveColor: Colors.white30,
                                          value: sliderMinutes,
                                          onChanged: (double value) {
                                            setState(() {
                                              sliderMinutes = value;
                                              hasEndings = true;
                                              if (sliderMinutes < 0.3) {
                                                if (sliderMinutes > 0.2) {
                                                  hasEndings = false;
                                                  sliderMinutes = 0.25;
                                                }
                                              }
                                              if (sliderMinutes < 0.15) {
                                                if (sliderMinutes > 0.1) {
                                                  sliderMinutes = 0.125;
                                                  hasEndings = false;
                                                }
                                              }
                                              if (sliderMinutes < 0.55) {
                                                if (sliderMinutes > 0.45) {
                                                  sliderMinutes = 0.5;
                                                }
                                              }
                                              if (sliderMinutes < 0.8) {
                                                if (sliderMinutes > 0.7) {
                                                  sliderMinutes = 0.75;
                                                }
                                              }
                                            });
                                          },
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          (sliderMinutes * 4)
                                              .toStringAsFixed(2),
                                          style: GoogleFonts.overpass(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 60),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "lesson${hasEndings ? "'s" : ""}",
                                          style: GoogleFonts.overpass(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )),
                                  ],
                                )),
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showSwitchCard = !showSwitchCard;
                                    });
                                    eee();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    color: blackGucci,
                                    height: double.infinity,
                                    child: const Icon(Icons.done,
                                        color: Colors.white, size: 50),
                                  ),
                                )),
                            Container(
                              color: Colors.white,
                              height: double.infinity,
                              width: 1,
                            ),
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showSwitchCard = !showSwitchCard;
                                    });
                                    eee();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    color: blackGucci,
                                    height: double.infinity,
                                    child: const Icon(Icons.close,
                                        color: Colors.white, size: 50),
                                  ),
                                )),
                          ])))
                ])),
            Container(color: Colors.white, width: double.maxFinite, height: 3),
            Expanded(
                flex: 2,
                child: GestureDetector(
                    onTap: addLessonTime,
                    child: Container(
                      color: blackGucci,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        'Add lesson (45 min.)',
                        style: GoogleFonts.overpass(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ))),
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
}
