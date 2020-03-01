import 'package:flutter/material.dart';
import 'package:minhas_contas/helpers/conta_helper.dart';
import 'package:minhas_contas/ui/nova_conta_page.dart';
import 'package:share/share.dart';

class ContasPage extends StatefulWidget {

  int idPerfil;

  ContasPage(this.idPerfil);

  @override
  _ContasPageState createState() => _ContasPageState();
}

class _ContasPageState extends State<ContasPage> {

  List<Conta> contas = List();
  ContaHelper helper = ContaHelper();

  @override
  void initState() {
    _carregarContas(widget.idPerfil);
  }

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
          Navigator.push(context, MaterialPageRoute(builder: (context) => NovaContaPage(widget.idPerfil))).then((contexto){
            setState(() {
              _carregarContas(widget.idPerfil);
            });
          });
        },
      ),
      body: buscarCorpo(),
    );
  }

  void _carregarContas(int idPerfil) {
    debugPrint("idCarregar: ${idPerfil}");
    helper.buscarTodasPorPerfil(idPerfil).then((lista){
      setState(() {
        contas = lista;
      });
    });
  }

  Widget buscarCorpo(){
    debugPrint("quantidade contas: ${contas.length}");
    if(contas.length <= 0)
      return Center(
        child: Text(
          "Você ainda não tem contas.",
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 20
          ),
        ),
      );

      return ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contas.length,
        itemBuilder: (context, index) {
          return _cardContato(context, index);
        },
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        Share.share(
                          contas[index].toString()
                        );
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Compartilhar",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: (){
                        debugPrint("Excluir");
                        setState(() {
                          helper.deletarConta(contas[index].id);
                          contas.removeAt(index);
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
                  ],
                ),
              );
            },
          );
        }
    );
  }

  Widget _cardContato(BuildContext context, int index){
    return GestureDetector(
      onTap: (){
        _mostrarOpcoes(context, index);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.center,
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      contas[index].apelido,
                      style: TextStyle(
                          fontSize: 22
                      ),
                    ),
                    Text(
                      contas[index].nomeBanco,
                      style: TextStyle(
                          fontSize: 22
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "tipo: ${contas[index].tipo}",
                      style: TextStyle(
                          fontSize: 13
                      ),
                    ),
                    Text(
                      "cpf: ${contas[index].cpfCnpj}",
                      style: TextStyle(
                          fontSize: 13
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Ag: ${contas[index].agencia}",
                      style: TextStyle(
                          fontSize: 13
                      ),
                    ),
                    Text(
                      "conta: ${contas[index].conta}-${contas[index].digitoConta}",
                      style: TextStyle(
                          fontSize: 13
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

