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
                  child: new Padding(
                    padding: EdgeInsets.all(2.0),
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
                                    child: new Text('#'+(index+1).toString().padLeft(3, '0')),
                                  ),
                                  new Container(
                                    margin: const EdgeInsets.only(top: 0, left: 45.0),
                                    child: new Text(pokemons[index]["name"]["english"]),
                                  ),
                                ],
                              ),
                              new TypeBar(pokemons[index]["type"]),
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
              },
              itemCount: pokemons == null ? 0 : pokemons.length,
            );
          },
        ),
      ),
    );
  }
}

// class EmailScreen extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Email'),),
//     );
//   }
// }

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage(this.id);

  @override
  State<StatefulWidget> createState() => _DetailState(id);
}

class _DetailState extends State<DetailPage> with SingleTickerProviderStateMixin {
  // final String id;
  // const _DetailState(this.id);
  String id;
  _DetailState(String id){  // 有参构造函数，
    this.id = id;
  }

  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  var _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          DetailStatPage(id),
          SkillStatPage(id),
        ],
        // 可以左右滑动
        // physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _bottomNavigationColor,
              ),
              title: Text(
                'HOME',
                style: TextStyle(color: _bottomNavigationColor),
              )),
              BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: _bottomNavigationColor,
              ),
              title: Text(
                'SKILL',
                style: TextStyle(color: _bottomNavigationColor),
              )),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class SkillStatPage extends StatelessWidget {
  final String id;
  const SkillStatPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text('Skill'),
      ),
      body: new Center(
        child: FutureBuilder(
          future: DefaultAssetBundle.
          of(context).
          loadString('data/moves.json'),
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
                  new SkillList('learn', detail['moves']['learn']),
                ]
              ),
            );
          },
        ),
      ),
    );
  }
}

class SkillList extends StatelessWidget {
  final String names;
  final List shkils;
  const SkillList(this.names, this.shkils);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < shkils.length; i++){
      list.add(
        new Row(
          children: <Widget>[
            new Text(shkils[i]['lv']),
            new Text(shkils[i]['name']),
            new Text(shkils[i]['type']), 
          ]
        )
      );
    }
    return new Card(
      child: Column(children: list),
    );
  }
}


class DetailStatPage extends StatelessWidget {
  final String id;
  const DetailStatPage(this.id);

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
                  new SpecieCard(detail['species'], detail['description'], detail['profile']),
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
  final String description;
  final Map profile;
  const SpecieCard(this.species, this.description, this.profile);

  List<Widget> generateSpeies(profile) {
    return <Widget>[
      new Text(profile['Height']),
      new Text(profile['Weight']),
      new Text(profile['Catch Rate']),
      new Text(profile['Gender Ratio']),
      new Text(profile['Egg Groups']),
      new Text(profile['Hatch Steps']),
      new Text(profile['Abilities']),
      new Text(profile['EVs']),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Column (
        crossAxisAlignment : CrossAxisAlignment.start,
        children: <Widget>[
          new Text(species),
          new Text(description),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: generateSpeies(profile),
          )
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
  final List types;
  const TypeBar(this.types);

  List<Widget> _buildTypeChips() {
    final Map<String, String> typeColor = {"grass": "105,194,61", "poison": "146,58,146", "fire": "237,109,18", "flying": "142,111,235", "water": "69,120,237",
    "bug": "151,165,29", "normal": "156,156,99", "ghost": "100, 78, 136", "rock": "164,143,50", "electric": "246,201,19", "ground": "219,181,77", "ice": "126,206,206", 
    "fairy": "232,120,144", "psychic":"247,54,112", "fighting": "174,42,36", "dark": "100,78,64", "dragon": "94,29,247", "steel": "160,160,192"};
    return types.map((type) {
      var colors = typeColor[type.toLowerCase()].split(',');
      return Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Chip(
          label: Text(type),
          // labelStyle: textTheme.caption,
          backgroundColor: new Color.fromARGB(150, int.parse(colors[0]), int.parse(colors[1]), int.parse(colors[2])),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: _buildTypeChips(),
    );
  }
}