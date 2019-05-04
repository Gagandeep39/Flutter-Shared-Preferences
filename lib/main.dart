import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  static SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    _fetchSharedPreferenceData();
  }

  void _fetchSharedPreferenceData() async {
    preferences = await SharedPreferences.getInstance();
    int data = preferences.getInt('counter');
    setState(() {
      if (data != null) _counter = data;
    });
  }

  void _updateCounter() async {
    setState(() {
      _counter++;
    });
    preferences = await SharedPreferences.getInstance();
    preferences.setInt('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "FAB Pressed since App installation",
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            "$_counter",
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _updateCounter();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}