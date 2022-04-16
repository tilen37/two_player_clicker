import 'package:flutter/material.dart';
import "package:flutter/services.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;
  double _height = 0.49;
  final _goal = 10;
  String _text1 = "";
  String _text2 = "";
  double _result = 0;
  double _startMenuHeight = 0.5;
  double _startMenuOffSet = 0;
  var _startMenuAlpha = 130;


  void _incrementCounter(int a) {
    setState(() {
        _counter += a;
        _height += 0.01 * a;
      });

    if (_counter >= _goal) {
      setState(() {
        _text1 = "You Won!";
        _text2 = "You Lost!";
        _result = 0.5;
      });
      Future.delayed(Duration(seconds: 1), (){
        setState(() {
          _startMenuHeight = 0.5;
          _startMenuAlpha = 200;
          _startMenuOffSet = 0;
        });
      });
      Future.delayed(Duration(seconds: 2), (){
        setState(() {
          _counter = 0;
          _height = 0.49;
          _result = 0;
        });
      });
    }
    else if (_counter <= -_goal){
      setState(() {
          _text1 = "You Lost!";
          _text2 = "You Won!";
          _result = 0.5;
      });
      Future.delayed(Duration(seconds: 2), (){
        setState(() {
          _counter = 0;
          _height = 0.49;
          _result = 0;
        });
        setState(() {
          _startMenuHeight = 0.5;
          _startMenuAlpha = 200;
          _startMenuOffSet = 0;
        });
      });
    }
  }

  void _startGame(){
    setState(() {
      _startMenuAlpha = 0;
      _startMenuHeight = 0;
      _startMenuOffSet = 1;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    var _score2 = -_counter;
    var _height2 = 0.98 -_height;

    return Stack (
        children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap:() => _incrementCounter(1),
                    child: Container(
                      height: _height * MediaQuery.of(context).size.height ,
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(5),
                              child: RotatedBox(
                                quarterTurns: 2,
                                child: Text(
                                  "$_counter",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 0.02 * MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  GestureDetector(
                    onTap:() => _incrementCounter(-1),
                    child: Container(
                    height: _height2 * MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget> [
                              Text(
                                "$_score2",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: _result * MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(0, 126, 118, 53),
                    ),
                    child:Center(
                      child: RotatedBox (
                        quarterTurns: 2,
                        child: Text("$_text1",
                            style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: _result * MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(0, 126, 118, 53),
                    ),
                    child: Center(
                      child: Text("$_text2",
                              style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              
              onTap:() => _startGame(),
              child: Column(
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastOutSlowIn,
                    height: _startMenuHeight * MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(_startMenuAlpha, 31, 31, 31),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(0, 0, 0, 0)
                            ),
                          ),
                        ),
                        Expanded(
                          child: Image(
                            image: AssetImage("assets/img/TapTo_3.png"),
                          ),
                        ),
                      ],
                    )
                  ),
                  AnimatedContainer(
                    margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * _startMenuOffSet, 0, 0),
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastOutSlowIn,
                    height: _startMenuHeight * MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(_startMenuAlpha, 31, 31, 31),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child:Image(
                            	image: AssetImage("assets/img/Play_3.png"),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(0, 0, 0, 0)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
  }
}