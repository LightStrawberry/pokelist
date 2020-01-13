import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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