import 'package:flutter/material.dart';
import 'package:minhas_contas/ui/nova_conta_page.dart';

class ContasPage extends StatefulWidget {
  @override
  _ContasPageState createState() => _ContasPageState();
}

class _ContasPageState extends State<ContasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Contas"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.add_box),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NovaContaPage())).then((contexto){

          });
        },
      ),
      body: buscarCorpo(),
    );
  }

  Widget buscarCorpo(){
    return Center(
      child: Text(
        "Você ainda não tem contas.",
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 20
        ),
      ),
    );
  }
}

