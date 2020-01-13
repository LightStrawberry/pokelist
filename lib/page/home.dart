import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../db.dart';
import '../routes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}



class _HomePageState extends State<HomePage> {
  List data;
  // @override
  // void initState() {
  //   super.initState();
  //   queryUserFromDB();
  // }

  // void queryUserFromDB() async {
  //   var list = await DBManager().query("111");
  //   data = list;
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: FutureBuilder<List<Map>>(
          future: DBManager().query("all"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                // 请求成功，显示数据
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  // itemExtent: 50.0, //强制高度为50.0
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // var id = (index+1).toString().padLeft(3, '0');
                        var id = (index+1).toString();
                        Routes.router.navigateTo(
                          context, '${Routes.detailpage}?id=$id',
                          transition: TransitionType.inFromRight
                        );
                      },
                      child: new Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Card(
                          // color: new Color.fromARGB(255, int.parse(colors[0]), int.parse(colors[1]), int.parse(colors[2])),
                          elevation: 5.0,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Container(
                                        margin: const EdgeInsets.only(top: 0, left: 30.0),
                                        child: new Text('#'+(index+1).toString().padLeft(3, '0')),
                                      ),
                                      new Container(
                                        margin: const EdgeInsets.only(top: 0, left: 45.0),
                                        child: new Text(snapshot.data[index]['name']),
                                      ),
                                    ],
                                  ),
                                  // new TypeBar(snapshot.data[index]['type']),
                                ],
                              ),
                              new Padding(
                                padding: EdgeInsets.all(5.0),
                                child: new Image.asset(
                                  'assets/images/'+ (index+1).toString().padLeft(3, '0') + '.png',
                                  width: 75.0,
                                  height: 75.0,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.centerRight,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                    // return ListTile(title: Text(snapshot.data[index]['name']));
                  }
                );
              }
            } else {
              // 请求未结束，显示loading
              return CircularProgressIndicator();
            }
          },
        ),
      )
    );
  }
}