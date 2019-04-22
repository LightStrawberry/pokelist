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
          SkillPage(id),
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
                                  learnOffstage = true;
                                  eggOffstage = false;
                                  tmOffstage = false;
                                  tutorOffstage = false;
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
                                  learnOffstage = false;
                                  eggOffstage = true;
                                  tmOffstage = false;
                                  tutorOffstage = false;
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
                                  learnOffstage = false;
                                  eggOffstage = false;
                                  tmOffstage = true;
                                  tutorOffstage = false;
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
                                  learnOffstage = false;
                                  eggOffstage = false;
                                  tmOffstage = false;
                                  tutorOffstage = true;
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
            // new Container(
            //   // padding: const EdgeInsets.only(bottom: 8.0),
            //   child: new Text(
            //     shkils[i]['lv'],
            //     style: new TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // ),
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

// Future<String> _loadAsset(fileName) async {
//   return await rootBundle.loadString(fileName);
// }

class DetailStatPage extends StatelessWidget {
  final String id;
  const DetailStatPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Detail'),
      // ),
      body: new Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: new Center(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString('data/pokemon/'+ id +'.json'),
            builder: (context, snapshot){
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
                  var pid = id.padLeft(3, '0');
                  return new Container(
                    child: Column (
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Image.asset(
                          'assets/images/'+ pid + '.png',
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
              }
            },
          ),
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
      new Text(profile['CatchRate']),
      new Text(profile['GenderRatio']),
      new Text(profile['EggGroups']),
      new Text(profile['HatchSteps']),
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
          new StatsBar('Sp. Attack', base['SpAttack']),
          new StatsBar('Sp. Defense', base['SpDefense']),
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