import 'dart:typed_data';
// import 'package:audioplayers/audioplayers.dart';
import 'package:brain_pictures/hard.dart';
import 'package:brain_pictures/normal.dart';
import 'package:brain_pictures/timelimitno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: first(),
  ));
}

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);
  static SharedPreferences? preferences;

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  int cnt = 0;
  bool temp = false;
  List list = [];

  SharedPreferences ?prefs;
  int cur_level = 0;

  @override
  void initState() {
    get();
    list = List.filled(60, "");
  }

  get() async {
    first.preferences = await SharedPreferences.getInstance();
    // prefs = await SharedPreferences.getInstance();
    // cur_level = prefs!.getInt('level')??0;
    //
    // for(int i = 0; i < cur_level; i++){
    //  String str = prefs!.getString('levelno$i')??"pending";
    //  list[i] = str;
    //  setState(() {});
    // }
    // print(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green.shade200,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Select mode",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          TextButton(onPressed: () {
            // AudioPlayer player = AudioPlayer();
            if(cnt == 0){
              temp = true;
              // String audioasset = "assets/audio/phonecalling.mp3";
              // ByteData bytes = await rootBundle.load(audioasset);
              // Uint8List soundbytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
              // int result = await player.playBytes(soundbytes);
              // if(result == 1){
              //   print("Sound play Successfully");
              // }
              // else{
              //   print("Sound not play Successfully");
              // }
              setState(() {

              });
            }
            else{
              temp = false;
              setState(() {

              });
            }
            cnt++;
          },
          child: (cnt % 2 == 0)? Icon(Icons.volume_up_sharp,size: 30,color: Colors.white,) : Icon(Icons.volume_off,size: 30,color: Colors.white,)),
          // Icon(Icons.more_vert),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    // Share.share();
                  },
                  child: PopupMenuItem(child: Text("Java")),
                ),
              ),
              PopupMenuItem(child: Text("MORE GAMES")),
              PopupMenuItem(child: Text("PRIVACY POLICY"))
            ],
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("pic/background.jpeg"),
          fit: BoxFit.fill,
        )),
        child: Expanded(
          flex: 3,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                  )),
              Expanded(
                  flex: 4,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Expanded(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 230,
                            width: 220,
                            decoration: BoxDecoration(
                                color: Colors.teal.shade50,
                                border: Border.all(
                                    width: 5.0, color: Colors.teal.shade800),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return timelimitno();
                                        },
                                      ));
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 190,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.teal.shade600,
                                          border: Border.all(
                                              width: 2.0,
                                              color: Colors.teal.shade800),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text(
                                        "NO TIME LIMIT",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return normal();
                                          },));
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 190,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.teal.shade600,
                                              border: Border.all(
                                                  width: 2.0,
                                                  color: Colors.teal.shade800),
                                              borderRadius:
                                              BorderRadius.circular(10.0)),
                                          child: Text(
                                            "NORMAL",
                                            style: TextStyle(
                                                fontSize: 20, color: Colors.white),
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return hard();
                                          },));
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 190,
                                          alignment: Alignment.center,
                                          margin:
                                          EdgeInsets.only(top: 10, bottom: 10.0),
                                          decoration: BoxDecoration(
                                              color: Colors.teal.shade600,
                                              border: Border.all(
                                                  width: 2.0,
                                                  color: Colors.teal.shade800),
                                              borderRadius:
                                              BorderRadius.circular(10.0)),
                                          child: Text(
                                            "HARD",
                                            style: TextStyle(
                                                fontSize: 20, color: Colors.white),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Expanded(
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        height: 65,
                        width: 170,
                        decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            border: Border.all(
                                width: 5.0, color: Colors.teal.shade800),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          height: 40,
                          width: 140,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.teal.shade600,
                              border: Border.all(
                                  width: 2.0, color: Colors.teal.shade800),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Text(
                            "REMOVE ADS",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: Container(
                height: double.infinity,
                width: double.infinity,
              )),
              Expanded(
                  child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        width: 280,
                        decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            border: Border.all(
                                width: 5.0, color: Colors.teal.shade800),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 40,
                                width: 120,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.teal.shade600,
                                    border: Border.all(
                                        width: 2.0,
                                        color: Colors.teal.shade800),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Text(
                                  "SHARE",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 120,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.teal.shade600,
                                    border: Border.all(
                                        width: 2.0,
                                        color: Colors.teal.shade800),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Text(
                                  "MORE GAMES",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: Container(
                height: double.infinity,
                width: double.infinity,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
