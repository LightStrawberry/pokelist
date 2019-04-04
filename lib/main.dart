import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './routes.dart';

void main() {
  ///初始化并配置路由
  final router = new Router();
  Routes.configureRoutes(router);
  runApp(
    MaterialApp(
      onGenerateRoute: router.generator
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'POKEMON',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new HomePage(title: 'POKEMON'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.
          of(context).
          loadString('data/pokemon.json'),
          builder: (context,snapshot){
            var pokemons = json.decode(snapshot.data.toString());

            return ListView.builder(
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                  onTap: () {
                    var id = (index+1).toString().padLeft(3, '0');
                    Routes.router.navigateTo(
                      context, '${Routes.detailpage}?id=$id',
                      transition: TransitionType.inFromRight
                    );
                    // Navigator.push(context,
                    //   MaterialPageRoute(builder: (context) => DetailPage((index+1).toString()))
                    // );
                  },
                  child: Card(
                    color: Colors.yellow[500],
                    elevation: 5.0,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text((index+1).toString() + pokemons[index]["name"]["chinese"]),
                        new Image.asset(
                          'assets/sprites/'+ (index+1).toString().padLeft(3, '0') + 'MS.png',
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomRight,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: pokemons == null ? 0 : pokemons.length,
            );
          },
        ),
      ),
    );
  }
}


class DetailPage extends StatelessWidget {
  final String id;
  const DetailPage(this.id);

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(appBar: AppBar(
        title: Text('Detail'),
      ),
      body: new Center(
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Image.asset(
              'assets/images/'+ id + '.png',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ]
        )
      ),
    );
  }
}