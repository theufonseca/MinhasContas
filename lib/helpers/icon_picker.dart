import 'package:flutter/material.dart';

class IconPicker extends StatelessWidget {
  static List<IconData> icons = [
    Icons.error,
    Icons.check,
    Icons.monetization_on,
    Icons.person,
    Icons.work,
    Icons.whatshot,
    Icons.verified_user,
    Icons.account_circle
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: <Widget>[
        for (var icon in icons)
          GestureDetector(
            onTap: () => Navigator.pop(context, icon),
            child: Icon(icon),
          )
      ],
    );
  }

  static IconData BuscarIconePorString(String icone){
    debugPrint(icone);
    IconData iconeSelecionado = icons.firstWhere((icone) => icone.toString() == icone.toString());
    debugPrint("$iconeSelecionado");
  }
}