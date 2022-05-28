// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: '',
      home: const MyHomePage(title: 'Chat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: non_constant_identifier_names
  String chat_bot_response = "";
  // ignore: non_constant_identifier_names
  String chat_request = "";
  late String enteredText;
  void getHttp() async {
    try {
      var response = await Dio()
          .get('https://is.nicolae.systems/api/?message=$chat_request');
      setState(() {
        chat_bot_response = response.data['response'];
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              // ignore: unnecessary_string_interpolations
              '$chat_bot_response',
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                // controller: myController,
                // ignore: avoid_print
                onChanged: (text) => chat_request = text,
                // onChanged: (newText) { enteredText = newText; },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Message',
                  hintText: 'Enter Your Message',
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getHttp(),
        tooltip: 'send',
        child: const Icon(Icons.send),
      ),
    );
  }
}
