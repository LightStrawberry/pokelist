import 'package:flutter/material.dart';

class PokemonDetailCard extends StatelessWidget {
  final String id;
  final Map detail;
  const PokemonDetailCard(this.id, this.detail);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var pid = id.padLeft(3, '0');
    print(detail);
    var name = detail['name']['english'];
    var type = detail['type'];
    var species = detail['species'];
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.red,
            padding: EdgeInsets.all(10.0),
          ),
          flex: 3,
        ),
        // Column(
        //   children: <Widget>[
        //     Row(
        //       children: <Widget>[
        //         Text('111'),
        //         Text('122')
        //       ],
        //     ),
        //     Row(
        //       children: <Widget>[
        //         Text('111')
        //       ],
        //     ),
        //   ],
        // ),
        Expanded(
          child:
            Image.asset(
            'assets/images/'+ pid + '.png',
            width: 120.0,
            height: 120.0,
            fit: BoxFit.contain,
            alignment: Alignment.bottomRight,
          ),
          flex: 2,
        ),
      ],
    );
  }
}