import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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