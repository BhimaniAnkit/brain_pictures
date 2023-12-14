import 'package:brain_pictures/game.dart';
import 'package:brain_pictures/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class timelimitno extends StatefulWidget {

  static SharedPreferences? preferences;

  const timelimitno({Key? key}) : super(key: key);

  @override
  State<timelimitno> createState() => _timelimitnoState();
}

class _timelimitnoState extends State<timelimitno> {
  List levelName = ["MATCH 2", "MATCH 3","MIRROR","MIRROR 3", "MATCH 4","MIRROR 4"];
  List level = [];
  int cnt = 0;
  bool temp = false;

  @override
  void initState() {
    level = List.filled(60, "pending");
    for(int i = 0; i < 60; i++){
      level[i] = first.preferences!.getString("Level_No${i}") ?? "pending";
      setState(() {});
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Select Level",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(width: 50,),
            Text("NO TIME LIMIT",style: TextStyle(fontSize: 12),),
          ],
        ),
        // title: Text("Select Level",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.teal,
        actions: [
          TextButton(onPressed: () {
            if(cnt == 0){
              temp = true;
              setState(() {});
            }
            else{
              temp = false;
              setState(() {});
            }
            cnt++;
          },
          child: (cnt % 2 == 0)? Icon(Icons.volume_up_sharp,size: 30,color: Colors.white,) : Icon(Icons.volume_off,size: 30,color: Colors.white,)),
          Icon(Icons.more_vert),
          // PopupMenuButton(itemBuilder: (context) => [
          //   PopupMenuItem(child: Text("SOUND ON")),
          //   PopupMenuItem(child: Text("SHARE")),
          //   PopupMenuItem(child: Text("MORE GAMES")),
          //   PopupMenuItem(child: Text("PRIVACY POLICY"))
          // ],)
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("pic/background.jpeg"),
            fit: BoxFit.fill
          )
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: levelName.length,
          itemBuilder: (context, myindex) {
          return Container(
            margin: EdgeInsets.all(10.0),
            height: 600,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 4.0,color: Colors.teal.shade900),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 210,
                      // color: Colors.teal.shade100,
                      child: Text("${levelName[myindex]}",
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.teal.shade900),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context, builder: (context) {
                            return AlertDialog(
                              // backgroundColor: Colors.green.shade900,
                              title: Text("How to play match 2"),
                              content: Text("Tap on a square to turn it over and see the picture\nit hides.\n\n"
                                  "Tap on another square to turn it over too.\n\n"
                                  "If the pictures match, they'll stay facing up, if not,\n"
                                  "both will turn it over again.\n\nFind all couples.",),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return timelimitno();
                                  },));
                                }, child: Text("OK",style: TextStyle(fontSize: 20)),)
                              ],
                            );
                        },);
                      },
                      child: Icon(Icons.help_outline_sharp,size: 25,color: Colors.teal.shade900,),
                    )
                  ],
                ),
                Container(
                  height: 0.75,
                  width: double.infinity,
                  margin: EdgeInsets.all(2.0),
                  color: Colors.teal.shade900,
                ),
                Expanded(child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return game((myindex * 10) + index);
                          },));
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: (level[(myindex * 10) + index] == "win") ? Colors.teal.shade900 : Colors.teal.shade50,
                            // color: Colors.teal.shade900,
                            border: Border.all(width: 1.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text("LEVEL ${(myindex * 10) + index + 1}",
                            style: TextStyle(fontWeight: FontWeight.bold,),),
                        ),
                      );
                      // return Container(
                      //   height: 50,
                      //   width: double.infinity,
                      //   alignment: Alignment.center,
                      //   margin: EdgeInsets.all(5.0),
                      //   decoration: BoxDecoration(
                      //     color: Colors.teal.shade900,
                      //     border: Border.all(width: 1.0),
                      //     borderRadius: BorderRadius.circular(5.0),
                      //   ),
                      //   child: Text("LEVEL ${(myindex * 10) + index + 1}",style: TextStyle(color: Colors.white),),
                      // );
                  },),
                ))
              ],
            ),
          );
        },),
      ),
      // body: ListView.builder(
      //   scrollDirection: Axis.horizontal,
      //   itemCount: num.length,
      //   itemBuilder: (context, myindex) {
      //     return Container(
      //       margin: EdgeInsets.all(10),
      //       height: 600,
      //       width: 250,
      //       decoration: BoxDecoration(
      //           border: Border.all(width: 3, color: Colors.teal),
      //           borderRadius: BorderRadius.circular(10)),
      //       child: Column(
      //         children: [
      //           Row(
      //             children: [
      //               Container(
      //                 alignment: Alignment.center,
      //                 height: 50,
      //                 width: 180,
      //                 color: Colors.yellow,
      //                 child: Text("${num[myindex]}"),
      //               ),
      //               Icon(Icons.help,size: 50,)
      //             ],
      //           ),
      //           Expanded(child: Container(height: double.infinity,
      //           width: double.infinity,
      //           child: ListView.builder(
      //             itemCount: 10,
      //             itemBuilder: (context, index) {
      //              return Container(
      //                alignment: Alignment.center,
      //                margin: EdgeInsets.all(5),
      //                height: 50,
      //                width: double.infinity,
      //                color: Colors.green,
      //                child: Text("${(myindex*10)+index+1}"),
      //              );
      //           },),))
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
