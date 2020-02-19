import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minhas_contas/helpers/perfil_helper.dart';
import 'package:minhas_contas/ui/contas_page.dart';
import 'package:minhas_contas/ui/perfil_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Perfil> perfis = List();

  PerfilHelper helper = PerfilHelper();

  @override
  void initState() {
    super.initState();
    _carregarPerfis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Contas"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PerfilPage())).then((contexto){
            _carregarPerfis();
          });
        },
      ),
      body: buscarTelaInicial(),
    );
  }

  void _carregarPerfis(){
    helper.buscarTodas().then((list){
      setState(() {
        perfis = list;
        debugPrint(perfis.length.toString());
      });
    });
  }

  Widget buscarTelaInicial(){
    if(perfis.length == 0)
      return Center(
        child: Text(
          "Nenhum perfil criado",
          style: TextStyle(
              fontSize: 28,
              color: Colors.blueGrey
          ),
        ),
      );

    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: perfis.length,
      itemBuilder: (context, index){
        return _cardPerfil(context, index);
      },
    );
  }

  Widget _cardPerfil(BuildContext context, int index) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ContasPage())).then((context){
          _carregarPerfis();
        });
      },
      onLongPress: (){
        _mostrarOpcoes(context, index);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget> [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: perfis[index].imagem != null ?
                        FileImage(File(perfis[index].imagem)) :
                        AssetImage("images/icone_imagem.png"),
                        fit: BoxFit.cover
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      perfis[index].apelido ?? "Sem apelido",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  void _mostrarOpcoes(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context){
        return BottomSheet(
          onClosing: (){

          },
          builder: (context){
            return Container(
              padding: EdgeInsets.all(5),
              child: FlatButton(
                onPressed: (){
                  helper.deletarPerfil(perfis[index].id);
                  setState(() {
                    perfis.removeAt(index);
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  "Excluir",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }
}