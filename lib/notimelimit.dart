import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class notimelimit extends StatefulWidget {
  const notimelimit({Key? key}) : super(key: key);

  @override
  State<notimelimit> createState() => _notimelimitState();
}

class _notimelimitState extends State<notimelimit> {

  List images = [];
  List img = [];
  int a = 5;
  int x = 1;
  int pos1 = 0,pos2 = 0,count = 0;
  List<bool> temp = [];

  Future _initImages() async{
    // >> To get paths you need these 2 lines

    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String,dynamic> manifestMap = json.decode(manifestContent);

    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
    .where((String key) => key.contains('pic/'))
    .where((String key) => key.contains('.png'))
    .toList();

    setState(() {
      images = imagePaths;
      images.shuffle();
      for(int i = 0; i < 6; i++){
        img.add(images[i]);
        img.add(images[i]);
      }
      img.shuffle();
    });
  }

  @override
  void initState() {
    _initImages();
    temp = List.filled(12, true);

    get();
  }

  get() async {
    for(int i = 5; i >= 0; i--){
      await Future.delayed(Duration(seconds: 1));
      a = i;
      if(i == 0){
        temp = List.filled(12, false);
      }
      setState(() {

      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${a}"),
        // title: Text("Select level",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        actions: [
          PopupMenuButton(itemBuilder: (context) => [
            PopupMenuItem(child: Text("SOUND ON")),
            PopupMenuItem(child: Text("SHARE")),
            PopupMenuItem(child: Text("MORE GAMES")),
            PopupMenuItem(child: Text("PRIVACY POLICY"))
          ],)
        ],
      ),
      body: GridView.builder(
        itemCount: img.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
               if(!temp[index] && x == 1)
                 {
                     temp[index] = true;
                     print("first");
                     pos1 = index;
                     x = 2;
                 }
               if(!temp[index] && x == 2)
                 {
                    temp[index] = true;
                    print("second");
                    pos2 = index;
                    x = 1;
                    if(img[pos1] == img[pos2]){
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
                      count++;
                      print("Count := ${count}");
                      if(count == 6){
                        // Future.delayed(Duration(seconds: 1));
                        return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text("You Are WIN!...."),
                            title: Text("Win"),
                            actions: [
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                                setState(() {

                                });
                              }, child: Text("OK"))
                            ],

                          ),);
                      }
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
                        setState(() {

                        });
                      });
                     }
                 }
               setState(() {

               });
            },
            child: Visibility(child: Container(
              height: 100,
              width: 100,
              child: Image.asset("${img[index]}"),
            ),
              visible: temp[index],
              replacement: Container(
                height: 100,
                width: 100,
                color: Colors.teal,
              ),
            ),
          );
      },),
    );
  }
}
