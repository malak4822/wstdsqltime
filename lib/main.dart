import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      home: MyHomePage(title: 'Your Wasted Time in School'),
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
  int counter = 0;
  int inHours = 0;
  double contWidth = 0;
  bool showSwitchCard = false;
  double buttOpacity = 0;
  bool hasEndings = true;
  bool hasOurEnding = true;
  double animationDouble = 0;
  Curve animationCurve = Curves.easeInOutQuint;

  double sliderMinutes = 0;
  double substractSliderVal = 0;

  int walkTime = 0;
  int beerTime = 0;
  int movieTime = 0;

  void countBeers() {
    beerTime = (counter / 10).round();
  }

  void movieTimer() {
    movieTime = (counter / 90).round();
  }

  void walkinTime() {
    walkTime = (counter / 9).round();
  }

  void loadBool() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('wastedTime') ?? 0;
    });
    countBeers();
    movieTimer();
    walkinTime();
    timeInHours();
  }

  void animatedContainer() async {
    if (animationDouble == MediaQuery.of(context).size.width) {
      animationDouble = 0;
    } else {
      animationDouble = MediaQuery.of(context).size.width;
    }
    Future.delayed(const Duration(milliseconds: 400), () {
      animationCurve = Curves.easeInOutQuart;

      setState(() {
        animationDouble = 0;
      });
    });
  }

  void hourEnding() {
    setState(() {
      if (inHours == 1) {
        hasOurEnding = true;
      } else {
        hasOurEnding = false;
      }
    });
  }

  void resetCounter() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('wastedTime', 0);
    setState(() {
      counter = 0;
    });
    countBeers();
    movieTimer();
    walkinTime();
    timeInHours();
  }

  void addLessonTime() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = counter + 45;
    });
    prefs.setInt('wastedTime', counter);
    timeInHours();
    countBeers();
    movieTimer();
    walkinTime();
  }

  void timeInHours() {
    setState(() {
      inHours = (counter.roundToDouble() / 60).round();
    });
  }

  void hideNShowCustomTime() {
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
          Slider(
            activeColor: Colors.white,
            thumbColor: Colors.black,
            inactiveColor: Colors.white30,
            value: substractSliderVal,
            onChanged: (double value) {
              setState(() {
                substractSliderVal = value;

                if (substractSliderVal < 0.3) {
                  if (substractSliderVal > 0.2) {
                    substractSliderVal = 0.25;
                  }
                }
                if (substractSliderVal < 0.15) {
                  if (substractSliderVal > 0.1) {
                    substractSliderVal = 0.125;
                  }
                }
                if (substractSliderVal < 0.55) {
                  if (substractSliderVal > 0.45) {
                    substractSliderVal = 0.5;
                  }
                }
                if (substractSliderVal < 0.8) {
                  if (substractSliderVal > 0.7) {
                    substractSliderVal = 0.75;
                  }
                }
              });
            },
          ),
          Text(
            '${(substractSliderVal * 4).toStringAsFixed(2)} lessons',
            style: GoogleFonts.overpass(
                fontWeight: FontWeight.bold, fontSize: 45, color: Colors.white),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  counter = counter - (substractSliderVal * 180).round();
                  if (counter <= 0) {
                    counter = 0;
                  }
                });
                movieTimer();
                countBeers();
                walkinTime();
                timeInHours();
                hourEnding();
                Navigator.pop(context);
              },
              child: Text("Substract Time",
                  style: GoogleFonts.overpass(
                      color: blackGucci,
                      fontWeight: FontWeight.bold,
                      fontSize: 25))),
          const SizedBox(height: 50),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(70),
              ),
              onPressed: () {
                resetCounter();
                Navigator.pop(context);
              },
              child: Text("Reset time",
                  style: GoogleFonts.overpass(
                      color: blackGucci,
                      fontWeight: FontWeight.bold,
                      fontSize: 30))),
        ]),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: blackGucci,
        title: Text(
          widget.title,
          style: GoogleFonts.overpass(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
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
                      "$inHours hour${hasOurEnding ? "" : "s"}",
                      style: GoogleFonts.overpass(
                          fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Text(
              'equivalent :',
              style: GoogleFonts.overpass(
                  fontWeight: FontWeight.bold, color: blackGucci),
            ),
            const SizedBox(height: 10),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    kolumna(
                        walkTime, 'kilometres', Icons.nordic_walking_rounded),
                    Container(
                        width: 110,
                        height: 110,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: blackGucci,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              beerTime.toString(),
                              style: GoogleFonts.overpass(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                            const Spacer(),
                            const FaIcon(
                              FontAwesomeIcons.beerMugEmpty,
                              color: Colors.white,
                              size: 35,
                            ),
                            Text(
                              'beers',
                              style: GoogleFonts.overpass(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.white),
                            )
                          ],
                        )),
                    kolumna(movieTime, 'movies', Icons.movie_creation),
                  ],
                )),
            const Spacer(),
            Expanded(
                flex: 2,
                child: Stack(children: [
                  InkWell(
                    onTap: () {
                      showSwitchCard = !showSwitchCard;
                      hideNShowCustomTime();
                      countBeers();
                      movieTimer();
                      walkinTime();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        color: blackGucci,
                        width: double.maxFinite,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_circle,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text("custom Time",
                                style: GoogleFonts.overpass(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ],
                        )),
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
                                              fontSize: 50),
                                        )),
                                    Expanded(
                                        flex: 2,
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
                                      counter = (sliderMinutes * 180).round() +
                                          counter;
                                    });
                                    hideNShowCustomTime();
                                    countBeers();
                                    movieTimer();
                                    walkinTime();
                                    timeInHours();
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
                                    hideNShowCustomTime();
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
            Container(color: Colors.white, width: double.infinity, height: 1),
            Expanded(
                flex: 2,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        animatedContainer();
                      });
                      addLessonTime();
                      hourEnding();
                    },
                    child: Stack(children: [
                      Container(
                    color: blackGucci,
                    child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_circle,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text(
                              '45 minutes lesson ',
                              style: GoogleFonts.overpass(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),)
   ,
                      AnimatedContainer(
                        height: double.infinity,
                        duration: const Duration(milliseconds: 400),
                        color: Colors.white54,
                        curve: animationCurve,
                        width: animationDouble,
                      ),
                    ]))),
          ],
        ),
      ),
    );
  }

  Widget kolumna(time, String txt, IconData ikonka) => Container(
      width: 110,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: blackGucci,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time.toString(),
            style: GoogleFonts.overpass(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          const Spacer(),
          Icon(
            ikonka,
            color: Colors.white,
            size: 35,
          ),
          Text(
            txt,
            style: GoogleFonts.overpass(
                fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
          )
        ],
      ));
}
