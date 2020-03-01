import 'package:flutter/material.dart';
import 'package:minhas_contas/helpers/conta_helper.dart';

class NovaContaPage extends StatefulWidget {
  @override
  _NovaContaPageState createState() => _NovaContaPageState();

  int idPerfil;

  NovaContaPage(this.idPerfil);
}

class _NovaContaPageState extends State<NovaContaPage> {

  Conta minhaNovaConta;

  final ContaHelper contaHelper = ContaHelper();

  @override
  void initState() {
    super.initState();

    minhaNovaConta = Conta();
    minhaNovaConta.idPerfil = widget.idPerfil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Conta"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/icone_imagem.png")
                  )
                ),
              ),
            ),
            TextField(
              onChanged: (texto){
                minhaNovaConta.apelido = texto;
              },
              decoration: InputDecoration(
                labelText: "Apelido da conta",
                labelStyle: TextStyle(
                  fontSize: 18
                )
              ),
            ),
            TextField(
              onChanged: (texto){
                minhaNovaConta.descricao = texto;
              },
              decoration: InputDecoration(
                  labelText: "Breve descrição",
                  labelStyle: TextStyle(
                      fontSize: 18
                  )
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buscarListaBancos(),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Expanded(
                  child: TextField(
                    onChanged: (texto){
                      minhaNovaConta.agencia = texto;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Agencia",
                        labelStyle: TextStyle(
                          fontSize: 18,
                        )
                    ),
                  ),
                ),
             ],
            ),
            Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Expanded(
                 child: TextField(
                   onChanged: (texto){
                     minhaNovaConta.conta = texto;
                   },
                   keyboardType: TextInputType.number,
                   decoration: InputDecoration(
                       labelText: "Conta",
                       labelStyle: TextStyle(
                           fontSize: 18,
                       ),
                   ),
                 ),
               ),
               Padding(
                padding: EdgeInsets.only(left: 20),
                 child: Container(
                   width: 70,
                   child: TextField(
                     onChanged: (texto){
                       minhaNovaConta.digitoConta = texto;
                     },
                     keyboardType: TextInputType.number,
                     decoration: InputDecoration(
                         labelText: "Digito",
                         labelStyle: TextStyle(
                             fontSize: 18
                         )
                     ),
                   ),
                 ),
               )
             ],
            ),
            TextField(
              onChanged: (texto){
                minhaNovaConta.cpfCnpj = texto;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Cpf/Cnpj",
                labelStyle: TextStyle(
                  fontSize: 18
                )
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: buscarListaTipoConta(),
            ),
            SizedBox(
             width: double.infinity,
             child: RaisedButton(
                 onPressed: (){
                   contaHelper.salvarConta(minhaNovaConta);
                   Navigator.pop(context);
                 },
                 color: Colors.lightGreen,
                 padding: EdgeInsets.all(10),
                 child: Text(
                   "Salvar",
                   style: TextStyle(
                       fontSize: 22,
                       color: Colors.white
                   ),
                 )
             ),
            )
          ],
        ),
      ),
    );
  }

  String tipoConta = "Conta Corrente";
  Widget buscarListaTipoConta(){
    return DropdownButton(
      value: tipoConta,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 69.5,
      elevation: 10,
      underline: Container(
        height: 1,
        color: Colors.grey,
      ),
      onChanged: (String newValue){
        setState(() {
          tipoConta = newValue;
          minhaNovaConta.tipo = newValue;
        });
      },
      items: <String>['Conta Corrente', 'Conta Poupança'].map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  String dropDownValue = "Bradesco";
  Widget buscarListaBancos(){
    return DropdownButton<String>(
      value: dropDownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 69.5,
      elevation: 10,
      underline: Container(
        height: 1,
        color: Colors.grey,
      ),
      onChanged: (String newValue){
        setState(() {
          dropDownValue = newValue;
          minhaNovaConta.nomeBanco = newValue;
        });
      },
      items: <String>['Bradesco', 'Itau', 'Santander', 'NuBank', 'Banco Original', 'Neon', 'Banco do Brasil', 'Caixa']
          .map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

