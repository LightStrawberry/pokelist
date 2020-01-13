import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SkillPage extends StatefulWidget {
  final String id;
  const SkillPage(this.id);

  @override
  State<StatefulWidget> createState() => _SkillState(id);
}

class _SkillState extends State<SkillPage> {
  String id;
  _SkillState(String id){  // 有参构造函数，
    this.id = id;
  }
  
  var learnOffstage = false;
  var tmOffstage = true;
  var eggOffstage = true;
  var tutorOffstage = true;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.only(top: 30.0),
      child: new Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.
          of(context).
          loadString('data/skill/'+ id +'.json'),
          builder: (context,snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Text('Awaiting result...');
              case ConnectionState.done:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                var detail = json.decode(snapshot.data.toString());
                // print(detail);
                return new SingleChildScrollView(
                  child: Column (
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2, // 20%
                            child: RaisedButton(
                              // onPressed: () => debugPrint('clicked2'),
                              onPressed: () {
                                setState(() {
                                  learnOffstage = false;
                                  eggOffstage = true;
                                  tmOffstage = true;
                                  tutorOffstage = true;
                                });
                              },
                              child: const Text('lv'),
                            ),
                          ),
                          Expanded(
                            flex: 2, // 20%
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  learnOffstage = true;
                                  eggOffstage = false;
                                  tmOffstage = true;
                                  tutorOffstage = true;
                                });
                              },
                              child: const Text('egg'),
                            ),
                          ),
                          Expanded(
                            flex: 2, // 20%
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  learnOffstage = true;
                                  eggOffstage = true;
                                  tmOffstage = false;
                                  tutorOffstage = true;
                                });
                              },
                              child: const Text('tm'),
                            ),
                          ),
                          Expanded(
                            flex: 2, // 20%
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  learnOffstage = true;
                                  eggOffstage = true;
                                  tmOffstage = true;
                                  tutorOffstage = false;
                                });
                              },
                              child: const Text('tutor'),
                            ),
                          ),
                        ],
                      ),
                      new Offstage(
                        offstage: learnOffstage,
                        child: new SkillList(detail['moves']['learn']),
                      ),
                      new Offstage(
                        offstage: tmOffstage,
                        child: new SkillList(detail['moves']['tm']),
                      ),
                      new Offstage(
                        offstage: eggOffstage,
                        child: new SkillList(detail['moves']['egg']),
                      ),
                      new Offstage(
                        offstage: tutorOffstage,
                        child: new SkillList(detail['moves']['tutor']),
                      ),
                    ]
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class SkillList extends StatelessWidget {
  final List shkils;
  const SkillList(this.shkils);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < shkils.length; i++){
      list.add(
        new Row(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: new Text(shkils[i]['name']),
            ),
            new Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Chip(
                label: Text(shkils[i]['type']),
                // labelStyle: textTheme.caption,
                // backgroundColor: new Color.fromARGB(150, int.parse(colors[0]), int.parse(colors[1]), int.parse(colors[2])),
              ),
            ),
            // new Text(shkils[i]['type']),
          ]
        )
      );
    }
    return new Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(children: list),
    );
  }
}