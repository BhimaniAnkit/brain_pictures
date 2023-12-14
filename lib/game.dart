import 'dart:convert';
import 'package:brain_pictures/main.dart';
import 'package:brain_pictures/timelimitno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class game extends StatefulWidget {
  int i = 0;
  game(this.i);
  // const game({Key? key}) : super(key: key);

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  List images = [];
  List img = [];
  int a = 5;
  List <bool> temp = [];
  int x = 1;
  int pos1 = 0,pos2 = 0,count = 0;

  @override
  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('pic/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      images = imagePaths;
      images.shuffle();
      for (int i = 0; i < 6; i++) {
        img.add(images[i]);
        img.add(images[i]);
      }
      img.shuffle();
    });
  }

  @override
  void initState() {
    super.initState();
    _initImages();
    temp = List.filled(12, true);
    get();
  }
  
  get()
  async {
    for(int i = 5;i >= 0; i--){
      await Future.delayed(Duration(seconds: 1));
      a = i;
      if(i == 0) temp = List.filled(12, false);
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Timer-${a} / 5"),
      backgroundColor: Colors.teal,
      ),
      body: GridView.builder(
        itemCount: img.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if(!temp[index] && x == 1)
                {
                  temp[index] = true;
                  print("First Click");
                  pos1 = index;
                  x = 2;
                  // print(index);
                }
                if(!temp[index] && x == 2)
                {
                  temp[index] = true;
                  print("Second Click");
                  // x = 3;
                  pos2 = index;
                  x = 1;
                  if(img[pos1] == img[pos2])
                  {
                    Fluttertoast.showToast(
                        msg: 'Match',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM_RIGHT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    count++;
                    if(count == 6){
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          content: Text("You Are Win..!!"),
                          title: Text("Win..!!",style: TextStyle(color: Colors.teal,fontSize: 25),),
                          actions: [
                            TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return timelimitno();
                              },));
                            }, child: Text("OK",style: TextStyle(fontSize: 25),),),
                          ],
                        );
                      },);
                    }
                    Future.delayed(Duration(seconds: 1));
                  }
                  else
                  {
                    Future.delayed(Duration(seconds: 1)).then((value) {
                      Fluttertoast.showToast(
                          msg: 'Not Matched',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM_RIGHT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      temp[pos1] = false;
                      temp[pos2] = false;
                      setState(() {});
                    });
                    // Future.delayed(Duration(seconds: 1));
                    // Future.delayed(Duration(seconds: 1)).then((value) => (value) {
                    //   temp[pos1] = false;
                    //   temp[pos2] = false;
                    // });
                    // temp[pos1] = false;
                    // temp[pos2] = false;
                    // setState(() {});
                    // Future.delayed(Duration(seconds: 1)).then((value) => (value) {
                    //   temp[pos1] = false;
                    //   temp[pos2] = false;
                    //   x = 1;
                    //   setState(() {});
                    // });
                  }
                }
                // if(6 == count){
                //   showDialog(context: context, builder: (context) {
                //     return AlertDialog(
                //       title: Text("Congratulations..!!",style: TextStyle(color: Colors.teal,fontSize: 25),),
                //       actions: [
                //         TextButton(onPressed: () {
                //           Navigator.push(context, MaterialPageRoute(builder: (context) {
                //             return timelimitno();
                //           },));
                //         }, child: Text("OK",style: TextStyle(fontSize: 25),),),
                //       ],
                //     );
                //   },);
                // }
                first.preferences!.setString("Level_No${widget.i}", "win");
                setState(() {});
              },
              child: Visibility(child: Container(
                height: 100,
                width: 100,
                child: Image.asset("${img[index]}"),
              ),visible: temp[index],
                replacement: Container(
                  height: 100,
                  width: 100,
                  color: Colors.teal,
                ),),
            );
             // return Visibility(child: Container(
             //   height: 100,
             //   width: 100,
             //   child: Image.asset("${img[index]}"),
             // ),visible: temp[index],
             //   replacement: Container(
             //   height: 100,
             //   width: 100,
             //   color: Colors.teal,
             // ),);
          },),
    );
  }
}
