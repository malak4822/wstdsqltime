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

  double sliderMinutes = 0.5;
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
    hourEnding();
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

  void easySliding() {
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
          child: Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center
              ,children: [
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
              textAlign: TextAlign.center,
              style: GoogleFonts.overpass(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  color: Colors.white),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
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
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            content: Text(
                                "Are you sure you \n want to reset counter?",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.overpass(
                                    fontWeight: FontWeight.bold, fontSize: 25)),
                            actions: [
                              Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(20),
                                          backgroundColor: blackGucci),
                                      onPressed: () {
                                        resetCounter();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text("yes",
                                          style: GoogleFonts.overpass(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)))),
                            ]);
                      });
                },
                child: Text("Reset time",
                    style: GoogleFonts.overpass(
                        color: blackGucci,
                        fontWeight: FontWeight.bold,
                        fontSize: 30))),
          ])),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: blackGucci,
          title: Text(
            widget.title,
            style: GoogleFonts.overpass(fontWeight: FontWeight.bold),
          ),
        ),
        // EKRAN GŁÓWNY EKRAN GŁÓWNY EKRAN GŁÓWNY EKRAN GŁÓWNY EKRAN GŁÓWNY
        body: Center(
          child: Stack(children: [
            Column(children: [
const Spacer(),
            Text(
              'You wasted :',
              style: GoogleFonts.overpass(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            Text(
              '$counter mins',
              style: GoogleFonts.overpass(
                  fontWeight: FontWeight.bold, fontSize: 40),
              textAlign: TextAlign.center,
            ),
            Text(
              "and that's",
              style: GoogleFonts.overpass(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            Text(
              "$inHours hour${hasOurEnding ? "" : "s"}",
              textAlign: TextAlign.center,
              style: GoogleFonts.overpass(
                  fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text(
              'equivalent :',
              textAlign: TextAlign.center,
              style: GoogleFonts.overpass(
                  fontWeight: FontWeight.bold, color: blackGucci),
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    kolumna(walkTime, 'kilometres',
                        Icons.nordic_walking_rounded, false),
                    kolumna(beerTime, 'beers', null, true),
                    kolumna(movieTime, 'movies', Icons.movie_creation, false),
                  ],
                )),
            const Spacer(),

          ],),
            Align(
                alignment: Alignment(0.5,-0.2),
                child:
            Column(children: [
              SizedBox(
                  height: 120,
                  child: Stack(
                    children: [
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
                              ))),
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          color: const Color.fromARGB(255, 112, 112, 112),
                          width: showSwitchCard
                              ? MediaQuery.of(context).size.width
                              : 0,
                          curve: Curves.easeInOutCirc,
                          child: AnimatedOpacity(
                              curve: Curves.easeInOutCirc,
                              opacity: showSwitchCard ? 1 : buttOpacity,
                              duration: const Duration(milliseconds: 300),
                              child: Row(children: [
                                Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: 30,
                                            child: Slider(
                                              activeColor: Colors.white,
                                              thumbColor: Colors.black,
                                              inactiveColor: const Color.fromARGB(
                                                  255, 180, 180, 180),
                                              value: sliderMinutes,
                                              onChanged: (double value) {
                                                setState(() {
                                                  sliderMinutes = value;
                                                });
                                                hasEndings = true;
                                                easySliding();
                                              },
                                            )),
                                        SizedBox(
                                            height: 55,
                                            child: Text(
                                              (sliderMinutes * 4).toStringAsFixed(2),
                                              style: GoogleFonts.overpass(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 50),
                                            )),
                                        Expanded(child:
                                        Text(
                                          "lesson${hasEndings ? "'s" : ""}",
                                          style: GoogleFonts.overpass(
                                              color: Colors.white, fontSize: 20),
                                        )),
                                      ],
                                    )),
                                Expanded(child:
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      showSwitchCard = !showSwitchCard;
                                      counter =
                                          (sliderMinutes * 180).round() + counter;
                                    });
                                    hideNShowCustomTime();
                                    countBeers();
                                    movieTimer();
                                    walkinTime();
                                    timeInHours();
                                  },
                                  child: Container(
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
                                Expanded(child:
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        showSwitchCard = !showSwitchCard;
                                      });
                                      hideNShowCustomTime();
                                    },
                                    child: Container(
                                      color: blackGucci,
                                      height: double.infinity,
                                      child: const Icon(Icons.close,
                                          color: Colors.white, size: 50),
                                    )))
                              ])))
                    ],
                  )),
              Container(color: Colors.white, height: 1),
              SizedBox(
                  height: 120,
                  child: InkWell(
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
                              )),
                        ),
                        AnimatedContainer(
                          height: double.infinity,
                          duration: const Duration(milliseconds: 400),
                          color: const Color.fromARGB(67, 136, 136, 136),
                          curve: animationCurve,
                          width: animationDouble,
                        )
                      ])))],
            ))]),
            ));
  }

  Widget kolumna(time, String txt, ikonka, bool hasFaIcon) => Container(
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
          hasFaIcon
              ? const FaIcon(
                  FontAwesomeIcons.beerMugEmpty,
                  size: 35,
                  color: Colors.white,
                )
              : Icon(
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
