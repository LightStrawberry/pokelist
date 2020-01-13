import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final Map base;
  const StatsCard(this.base);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Column (
        crossAxisAlignment : CrossAxisAlignment.start,
        children: <Widget>[
          new StatsBar('HP', base['hp']),
          new StatsBar('Attack', base['atk']),
          new StatsBar('Defense', base['def']),
          new StatsBar('Sp. Attack', base['spa']),
          new StatsBar('Sp. Defense', base['spd']),
          new StatsBar('Speed', base['spe']),
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