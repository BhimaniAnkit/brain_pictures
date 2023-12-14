import 'package:brain_pictures/gemehard.dart';
import 'package:brain_pictures/main.dart';
import 'package:flutter/material.dart';

class hard extends StatefulWidget {
  const hard({Key? key}) : super(key: key);

  @override
  State<hard> createState() => _hardState();
}

class _hardState extends State<hard> {
  List hardLevelName = ["MATCH 2","MATCH 3","MIRROR","MIRROR 3","MATCH 4","MIRROR 4"];
  List hardLevel = [];
  int hardCnt = 0;
  bool hardTemp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Select Level",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.teal,
          actions: [
            TextButton(
                onPressed: () {
                  if (hardCnt == 0) {
                    hardTemp = true;
                    setState(() {});
                  } else {
                    hardTemp = false;
                    setState(() {});
                  }
                },
                child: (hardCnt % 2 == 0)
                    ? Icon(
                  Icons.volume_up_sharp,
                  size: 30,
                  color: Colors.white,
                )
                    : Icon(
                  Icons.volume_off,
                  size: 30,
                  color: Colors.white,
                )),
            Icon(Icons.more_vert),
          ],
        ),
        body: WillPopScope(child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("pic/background.jpeg"),
                fit: BoxFit.fill,
              )),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hardLevelName.length,
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
                          child: Text("${hardLevelName[myindex]}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.teal.shade900),),
                        ),
                        Icon(Icons.help_outline_sharp,size: 25,color: Colors.teal.shade900,),
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
                                // return game((myindex * 10) + index);
                                return gamehard((myindex * 10) + index);
                                // return normalgame();
                              },));
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.teal.shade900,
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text("LEVEL ${(myindex * 10) + index + 1}",style: TextStyle(color: Colors.white),),
                            ),
                          );
                        },),
                    ))
                  ],
                ),
              );
            },
          ),
        ),
          onWillPop: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return first();
            },));
            return false;
          },
        )
    );
  }
}
