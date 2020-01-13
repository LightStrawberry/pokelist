import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokelist/component/pokemon_card.dart';
import 'package:pokelist/component/stats_card.dart';

import '../db.dart';

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
            // future: DefaultAssetBundle.of(context).loadString('data/pokemon/'+ id +'.json'),
            future: DBManager().queryOne(id),
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
                  // var detail = json.decode(snapshot.data.toString());
                  return new Container(
                    child: Column (
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new PokemonDetailCard(id, snapshot.data),
                        // new SpecieCard(detail['species'], detail['description'], detail['profile']),
                        new StatsCard(snapshot.data),
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