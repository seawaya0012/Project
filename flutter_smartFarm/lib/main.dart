import 'package:flutter/material.dart';
import 'dart:io';
import 'CustomDatabase.dart';
import 'constants.dart';

void main() async {
  // modify with your true address/port
  Socket sock = await Socket.connect('192.168.137.30', 80);
  runApp(MyApp(sock));
}

class MyApp extends StatelessWidget {
  Socket socket;

  MyApp(Socket s) {
    this.socket = s;
  }

  @override
  Widget build(BuildContext context) {
    final title = 'TcpSocket Demo';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Farming',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: CustomData(
      title: title,
      channel: socket,
      ),
    );
  }


}

