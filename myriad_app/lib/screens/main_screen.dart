import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class MainScreen extends StatefulWidget {

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController eCtrl = new TextEditingController();
  Color colorInclude = Color.fromRGBO(0, 207, 21, 0.21);
  Color colorExclude = Color.fromRGBO(221, 0, 0, 0.24);
  Color borderColer = Colors.grey;
  List<Triplet> items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadJson();
    });
  }

  loadJson() async {
    String data = await rootBundle.loadString('qa.json');
    List<dynamic> jsonResult = json.decode(data);
    List<Triplet> list=[];

    jsonResult.forEach((value) {
      String question = value['Query'];
      String answer = value["Response"];
      String intent = value["IntentName"];

      if (answer.isNotEmpty && question.isNotEmpty && intent.isNotEmpty){
        list.add(new Triplet(question, answer, intent, false));
      }
    });
    setState(() {
      list.shuffle();
      items=list;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: /*AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(8.0), child: Text('YourAppTitle'))
          ],

        ),
      )*/PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'logo.png',
                  fit: BoxFit.contain,
                  height: 150,
                )
              ],

            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text('MYRIAD', style: TextStyle(fontSize: 72),)],
            ),*/
          ),
        ),
      )
      ,
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Container(
            width: screenSize.width * 0.7,
            height: screenSize.height * 0.6,
            child: Column(
              children: [
                new Expanded(
                    child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: new ListView.separated(
                      padding: EdgeInsets.only(right: 20),
                      controller: _scrollController,
                      itemCount: items.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemBuilder: (BuildContext ctxt, int Index) {
                        return new Container(
                          decoration: BoxDecoration(
                              color: items[Index].exclude
                                  ? colorExclude
                                  : colorInclude,
                              border: Border.all(color: borderColer, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [Text('Intent: ', style: TextStyle(fontWeight: FontWeight.bold)), Text(items[Index].intend)],),
                                    SizedBox(height: 5,),
                                    Row(children: [Text('Question: ', style: TextStyle(fontWeight: FontWeight.bold)), Text(items[Index].question)],),
                                    Row(children: [Text('Answer: ', style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(width: screenSize.width*0.5, child: Text(items[Index].answer,))],),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: new ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: items[Index].exclude ? Color.fromRGBO(244, 156, 156, 1) : Color.fromRGBO(170, 220, 175, 1),
                                      ),
                                      onPressed: () => setState(() {
                                            items[Index].exclude =
                                                !items[Index].exclude;
                                          }),
                                  child: items[Index].exclude ? Text('INCLUDE', style: TextStyle(color: Colors.black),) : Text('EXCLUDE', style: TextStyle(color: Colors.black))),
                                ),

                                /*
                                    TextButton(onPressed: ()=>setState(() {
                                      items[Index].exclude=!items[Index].exclude;
                                    }),
                                        style: ButtonStyle(backgroundColor: items[Index].exclude ? Color.fromRGBO(247, 183, 183, 1) : Color.fromRGBO(183, 239, 190, 1)),
                                        child: items[Index].exclude ? Text('INCLUDE') : Text('EXCLUDE'))*/
                              ],
                            ),
                          ),
                        );
                        //Text(items[Index].question);
                      }),
                )),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    new ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.black, width: 1)
                          ),
                          primary: Colors.white
                        ),
                        onPressed: () => {downloadFile()},
                        child: Text('EXPORT', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32))
                    )],
                )
              ],
            )),
      ),
    );
  }

  Future<void> loadDefaultData() async {

    Future.delayed(Duration(seconds: 5));
    List<Triplet> loadedData = List<Triplet>.generate(
        14, (index) => new Triplet('Question', 'Answer', 'Intent', false));
    setState(() {
      items = loadedData;
    });
  }

}
void downloadFile(){
  html.window.open('https://drive.google.com/file/d/1Bkq2MH8dO5-bVTOPMiBLBuLpvvjR3Sls/view?usp=sharing', 'new tab');
}

class Triplet {
  String question;
  String answer;
  String intend;
  bool exclude;

  Triplet(String q, a, i, r) {
    this.question = q;
    this.answer = a;
    this.intend = i;
    this.exclude = r;
  }
}
