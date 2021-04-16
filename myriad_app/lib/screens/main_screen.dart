import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  //const YellowBird({ Key? key }) : super(key: key);

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  List<Triplet> items = List<Triplet>.generate(14, (index) => new Triplet('Question', 'Answer', 'intend', false));

  final TextEditingController eCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('MYRIAD')],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Container(
            width: screenSize.width*0.7,
            height: screenSize.height*0.6,
            child: Column(
              children: [
                new Expanded(
                    child: new ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemBuilder: (BuildContext ctxt, int Index) {
                          return new Container(
                            decoration: BoxDecoration(
                                color:
                                items[Index].exclude ? Colors.red : Colors.green,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)
                                )
                            ),

                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Intend: ' + items[Index].intend),
                                      Text('Question: ' + items[Index].question),
                                      Text('Answer: ' + items[Index].answer)
                                    ],
                                  ),
                                  TextButton(onPressed: ()=>setState(() {
                                    items[Index].exclude=!items[Index].exclude;
                                  }), child: items[Index].exclude ? Text('ADD') : Text('EXCLUDE'))
                                ],
                              ),
                            ),
                          );
                          //Text(items[Index].question);
                        })),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [TextButton(onPressed: ()=>{}, child: Text('Export'))],
                )
              ],
            )),
      ),
    );
  }
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
