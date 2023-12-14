import 'dart:convert';
import 'package:brain_pictures/main.dart';
import 'package:brain_pictures/timelimitno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class gamehard extends StatefulWidget {
  int i;
  gamehard(this.i);
  // const gamehard({Key? key}) : super(key: key);

  @override
  State<gamehard> createState() => _gamehardState();
}

class _gamehardState extends State<gamehard> {

  List hard_images = [];
  List hard_img = [];
  int hard_a = 15;
  List <bool> hard_temp = [];
  int hard_x = 1;
  int hard_pos1 = 0,hard_pos2 = 0,hard_pos3 = 0,hard_count = 0;

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
      hard_images = imagePaths;
      hard_images.shuffle();
      for (int i = 0; i < 10; i++) {
        hard_img.add(hard_images[i]);
        hard_img.add(hard_images[i]);
        hard_img.add(hard_images[i]);
      }
      hard_img.shuffle();
    });
  }

  @override
  void initState() {
    super.initState();
    _initImages();
    hard_temp = List.filled(30, true);
    get();
  }

  get() async {
    for(int i = 15;i >= 0; i--)
    {
      await  Future.delayed(Duration(seconds: 1));
      hard_a = i;
      if(i == 0) hard_temp = List.filled(30, false);
      setState(() {

      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer - ${hard_a} / 15"),
        backgroundColor: Colors.teal,
      ),
      body: GridView.builder(
        itemCount: hard_img.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,mainAxisSpacing: 5,crossAxisSpacing: 5),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              {
                if(!hard_temp[index] && hard_x == 1)
                {
                  hard_temp[index] = true;
                  print("First Click");
                  hard_pos1 = index;
                  hard_x = 2;
                  // print(index);
                }
                if(!hard_temp[index] && hard_x == 2)
                {
                  hard_temp[index] = true;
                  print("Second Click");
                  hard_pos2 = index;
                  hard_x = 3;
                  // print(index);
                }
                if(!hard_temp[index] && hard_x == 3)
                {
                  hard_temp[index] = true;
                  print("Third Click");
                  // x = 3;
                  hard_pos3 = index;
                  hard_x = 1;
                  if((hard_img[hard_pos1] == hard_img[hard_pos2]) && (hard_img[hard_pos2] == hard_img[hard_pos3]))
                  {
                    Fluttertoast.showToast(
                        msg: 'Match',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM_RIGHT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    hard_count++;
                    if(hard_count == 10){
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
                      hard_temp[hard_pos1] = false;
                      hard_temp[hard_pos2] = false;
                      hard_temp[hard_pos3] = false;
                      setState(() {});
                    });
                  }
                }
                first.preferences!.setString("level_no${widget.i}", "win");
                setState(() {});
              }
            },
            child: Visibility(child: Container(
              height: 50,
              width: 50,
              child: Image.asset("${hard_img[index]}"),
              ),
              visible: hard_temp[index],
              replacement: Container(
                height: 50,
                width: 50,
                color: Colors.teal,
              ),
            ),
          );
      },),
    );
  }
}
