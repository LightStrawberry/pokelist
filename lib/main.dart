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
                var colors = pokemons[index]["color"].split(',');
                return GestureDetector(
                  onTap: () {
                    var id = (index+1).toString().padLeft(3, '0');
                    Routes.router.navigateTo(
                      context, '${Routes.detailpage}?id=$id',
                      transition: TransitionType.inFromRight
                    );
                  },
                  child: Card(
                    color: new Color.fromARGB(255, int.parse(colors[0]), int.parse(colors[1]), int.parse(colors[2])),
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
                                  child: new Text((index+1).toString().padLeft(3, '0')),
                                ),
                                new Container(
                                  margin: const EdgeInsets.only(top: 0, left: 45.0),
                                  child: new Text(pokemons[index]["name"]["chinese"]),
                                ),
                              ],
                            ),
                            new TypeBar(pokemons[index]["type"]),
                          ],
                        ),
                        new Image.asset(
                          'assets/sprites/'+ (index+1).toString().padLeft(3, '0') + 'MS.png',
                          width: 75.0,
                          height: 75.0,
                          fit: BoxFit.contain,
                          alignment: Alignment.centerRight,
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
    return Scaffold(appBar: AppBar(
        title: Text('Detail'),
      ),
      body: new Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.
          of(context).
          loadString('data/pokemon.json'),
          builder: (context,snapshot){
            var detail = json.decode(snapshot.data.toString())[int.parse(id)-1];
            print(detail);
            return new Container(
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
                  new SpecieCard(detail['species']),
                  new StatsCard(detail['base']),
                ]
              ),
            );
          },
        ),
      ),
    );
  }
}

class SpecieCard extends StatelessWidget {
  final String species;
  const SpecieCard(this.species);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Column (
        crossAxisAlignment : CrossAxisAlignment.start,
        children: <Widget>[
          new Text(species)
        ],
      )
    );
  }
}

class StatsCard extends StatelessWidget {
  final Map base;
  const StatsCard(this.base);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Column (
        crossAxisAlignment : CrossAxisAlignment.start,
        children: <Widget>[
          new StatsBar('HP', base['HP']),
          new StatsBar('Attack', base['Attack']),
          new StatsBar('Defense', base['Defense']),
          new StatsBar('Sp. Attack', base['Sp. Attack']),
          new StatsBar('Sp. Defense', base['Sp. Defense']),
          new StatsBar('Speed', base['Speed']),
        ],
      )
    );
  }
}

class StatsBar extends StatelessWidget {
  final String statText;
  final int stat;
  const StatsBar(this.statText, this.stat);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: new Container(
              width: stat/120*300,
              child: new OutlineButton (
                onPressed: (){},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    bottomLeft: const Radius.circular(40.0),
                  )
                ),
                child: new Text(statText),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: new Text(stat.toString()),
          ),
        ]
      )
    );
  }
}

class TypeBar extends StatelessWidget {
  final List Types;
  const TypeBar(this.Types);

  @override
  Widget build(BuildContext context) {
    return new Row(children: Types.map((item) => 
      new Container(
        margin: const EdgeInsets.only(top: 0, left: 30.0),
        child: new Text(item),
      ),
    ).toList());
  }
}