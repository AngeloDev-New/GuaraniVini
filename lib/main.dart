import 'package:flutter/material.dart';
import './model/mystate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() async{
  await dotenv.load();
  runApp(App());
}




class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RecorderScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RecorderScreen extends StatefulWidget {
  @override
  RecorderScreenState createState() => RecorderScreenState();
}

