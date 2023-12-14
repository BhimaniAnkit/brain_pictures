import 'dart:convert';
import 'package:brain_pictures/main.dart';
import 'package:brain_pictures/timelimitno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class normalgame extends StatefulWidget {
  int i;
  normalgame(this.i);
  // const normalgame({Key? key}) : super(key: key);

  @override
  State<normalgame> createState() => _normalgameState();
}

class _normalgameState extends State<normalgame> {

  List noraml_images = [];
  List normal_img = [];
  int normal_a = 10;
  List<bool> normal_temp = [];
  int normal_x = 1,normal_pos1 = 0,normal_pos2 = 0,normal_count = 0;

  @override
  void initState() {
    super.initState();
    _initImages();
    normal_temp = List.filled(24, true);
    get();
  }

  @override

  Future _initImages() async {
    // >> To get paths you need these 2 lines

    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String,dynamic> manifestMap = json.decode(manifestContent);

    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
    .where((String key) => key.contains('pic/'))
    .where((String key) => key.contains('.png'))
    .toList();

    setState(() {
      noraml_images = imagePaths;
      noraml_images.shuffle();
      for(int i = 0; i < 12; i++){
        normal_img.add(noraml_images[i]);
        normal_img.add(noraml_images[i]);
      }
      normal_img.shuffle();
    });
  }

  get() async {
    for(int i = 10; i >= 0; i--){
      await Future.delayed(Duration(seconds: 1));
      normal_a = i;
      if(i == 0) normal_temp = List.filled(24, false);
      setState(() {

      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer - ${normal_a} / 10"),
        backgroundColor: Colors.teal,
      ),
      body: GridView.builder(
        itemCount: normal_img.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,crossAxisSpacing: 5,mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                if(!normal_temp[index] && normal_x == 1)
                {
                  normal_temp[index] = true;
                  print("first");
                  normal_pos1 = index;
                  normal_x = 2;
                }
                if(!normal_temp[index] && normal_x == 2)
                {
                  normal_temp[index] = true;
                  print("second");
                  normal_pos2 = index;
                  normal_x = 1;
                  if(normal_img[normal_pos1] == normal_img[normal_pos2]){
                    Fluttertoast.showToast(
                        msg: 'Match',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM_RIGHT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    Future.delayed(Duration(seconds: 1));
                    normal_count++;
                    print("Count := ${normal_count}");
                    if(normal_count == 12){
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          content: Text("You Are Win..!!"),
                          title: Text("Win..!!",style: TextStyle(color: Colors.teal,fontSize: 25),),
                          actions: [
                            TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                // return timelimitno();
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
                      normal_temp[normal_pos1] = false;
                      normal_temp[normal_pos2] = false;
                      setState(() {

                      });
                    });
                  }
                }
                setState(() {

                });
              },
              child: Visibility(child: Container(
                height: 50,
                width: 50,
                child: Image.asset("${normal_img[index]}"),
              ),
                visible: normal_temp[index],
                replacement: Container(
                  height: 50,
                  width: 50,
                  color: Colors.teal,
                ),
              ),
            );
            // return InkWell(
            //   onTap: () async{
            //     if(!normal_temp[index] && normal_x == 1)
            //     {
            //       normal_temp[index] = true;
            //       print("First Click");
            //       normal_pos1 = index;
            //       normal_x = 2;
            //     }
            //     if(!normal_temp[index] && normal_x == 2)
            //     {
            //       normal_temp[index] = true;
            //       print('Second Click');
            //       normal_pos2 = index;
            //       normal_x = 1;
            //       if(normal_img[normal_pos1] == normal_img[normal_pos2])
            //       {
            //         Fluttertoast.showToast(
            //             msg: 'Match',
            //             toastLength: Toast.LENGTH_SHORT,
            //             gravity: ToastGravity.BOTTOM_RIGHT,
            //             timeInSecForIosWeb: 1,
            //             backgroundColor: Colors.red,
            //             textColor: Colors.white,
            //             fontSize: 16.0
            //         );
            //         Future.delayed(Duration(seconds: 1));
            //         normal_count++;
            //         if(normal_count == 12){
            //           showDialog(context: context, builder: (context) {
            //             return AlertDialog(
            //               content: Text("You Are Win..!!"),
            //               title: Text("Win..!!",style: TextStyle(color: Colors.teal,fontSize: 25),),
            //               actions: [
            //                 TextButton(onPressed: () {
            //                   Navigator.push(context, MaterialPageRoute(builder: (context) {
            //                     return timelimitno();
            //                   },));
            //                 }, child: Text("OK",style: TextStyle(fontSize: 25),),),
            //               ],
            //             );
            //           },);
            //         }
            //       }
            //       else{
            //         Future.delayed(Duration(seconds: 1)).then((value) => (value) {
            //           Fluttertoast.showToast(
            //             msg: "Not Match",
            //             toastLength: Toast.LENGTH_LONG,
            //             timeInSecForIosWeb: 1,
            //             gravity: ToastGravity.BOTTOM_RIGHT,
            //             backgroundColor: Colors.red,
            //             textColor: Colors.white,
            //             fontSize: 16.0,
            //           );
            //           normal_temp[normal_pos1] = false;
            //           normal_temp[normal_pos2] = false;
            //           setState(() {});
            //         });
            //       }
            //     }
            //     first.preferences!.setString("level_no${widget.i}", "win");
            //     setState(() {});
            //   },
            //   child: Visibility(child: Container(
            //     height: 50,
            //     width: 50,
            //     child: Image.asset("${normal_img[index]}"),
            //   ),
            //     visible: normal_temp[index],
            //     replacement: Container(
            //       height: 50,
            //       width: 50,
            //       color: Colors.teal,
            //     ),
            //   ),
            // );
          },),
    );
  }
}
