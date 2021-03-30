import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebase/rounded.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'constants.dart';



class CustomData extends StatefulWidget {
  CustomData({this.app, Key key, @required this.title, @required this.channel})
      : super(key: key);
  final FirebaseApp app;
  final String title;
  final Socket channel;

  @override
  _CustomDataState createState() => _CustomDataState();
}

class _CustomDataState extends State<CustomData> {
  List<String> categories = ["Home", "Schedule"];
  final referenceDatase = FirebaseDatabase.instance;

  final myfarmName = 'Status';
  final myfarmName1 = 'Controll';
  // final myfarmName2 = 'Mode';
  final myfarmController = TextEditingController();

  DatabaseReference _myfarmRef;
  DatabaseReference _myfarmRef1;
  // DatabaseReference _myfarmRef2;

  @override
  void initState(){
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _myfarmRef = database.reference().child('ESP_Device');
    _myfarmRef1 = database.reference().child('ESP_Controll');
    // _myfarmRef2 = database.reference().child('ESP_Status');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatase.reference();
    return Scaffold(

      appBar: buildAppBar(context),

      body: SingleChildScrollView(
        child: Column(
          children: [

            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),

                child: Column(
                  children: <Widget> [
                    // Flexible(
                    //     child: new FirebaseAnimatedList(
                    //         shrinkWrap: true,
                    //         query: _myfarmRef2,
                    //         itemBuilder: (
                    //             BuildContext context,
                    //             DataSnapshot snapshot,
                    //             Animation<double> animation,
                    //             int index){
                    //           return new ListTile(
                    //             title: new Text(
                    //                 snapshot.value['Mode'],
                    //                 textAlign: TextAlign.left,
                    //                 style: TextStyle(fontSize: 15, color: kTextMediumColor, fontWeight: FontWeight.w600)),
                    //           );
                    //         })),
                    Text(
                      myfarmName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: kPrimaryColor, fontWeight: FontWeight.w600),
                    ),
                    Flexible(
                        child: new FirebaseAnimatedList(
                            shrinkWrap: true,
                            query: _myfarmRef,
                            itemBuilder: (
                                BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index){
                          return new ListTile(
                            title: new Text(
                                snapshot.value['StatusofFarm'],
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15, color: kTextMediumColor, fontWeight: FontWeight.w600)),
                          );
                    })),
                    Text(
                      myfarmName1,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: kPrimaryColor, fontWeight: FontWeight.w600),
                    ),
                    Flexible(
                        child: new FirebaseAnimatedList(
                            shrinkWrap: true,
                            query: _myfarmRef1,
                            itemBuilder: (
                                BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index){
                              return new ListTile(
                                title: new Text(
                                    snapshot.value['controll'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 15, color: kTextMediumColor, fontWeight: FontWeight.w600)),
                              );
                            })),

                    RoundedButton(
                      text: "LED On/Off",
                      press: _tempLED,
                    ),
                    RoundedButton(
                      text: "Cooling On/Off",
                      press: _tempCooling,
                    ),
                    RoundedButton(
                      text: "Solenoid On/Off",
                      press: _tempSolenoid,
                    ),
                    RoundedButton(
                      text: "Auto Mode",
                      press: _tempAuto,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _tempLED() {
    widget.channel.write("LED\n");
  }
  void _tempCooling() {
    widget.channel.write("Cooling\n");
  }

  void _tempSolenoid() {
    widget.channel.write("Solenoid\n");
  }

  void _tempAuto() {
    widget.channel.write("Auto\n");
  }

  @override
  void dispose() {
    widget.channel.close();
    super.dispose();
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kPrimaryColor.withOpacity(.03),
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/iconapp.svg"),
    ),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset("assets/icons/manual.svg"),
        onPressed: () {},
      ),
    ],
  );
}
