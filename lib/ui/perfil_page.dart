import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minhas_contas/helpers/perfil_helper.dart';

class PerfilPage extends StatefulWidget {

  @override
  _PerfilPageState createState() => _PerfilPageState();

  final Perfil perfil;

  PerfilPage({this.perfil});
}

class _PerfilPageState extends State<PerfilPage> {

  final controladorApelido = TextEditingController();
  final controladorDescricao = TextEditingController();

  Perfil _editarPerfil;
  PerfilHelper helper = PerfilHelper();

  @override
  void initState() {
    super.initState();

    if(widget.perfil == null)
      _editarPerfil = Perfil();
    else
      _editarPerfil = Perfil.fromMap(widget.perfil.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_editarPerfil.apelido ?? "Novo Perfil"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_alt),
        backgroundColor: Colors.lightGreen,
        onPressed: (){
          helper.salvarPerfil(_editarPerfil);
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                mostrarOpcaoImagem(context);
                /**/
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editarPerfil.imagem != null ?
                        FileImage(File(_editarPerfil.imagem)) :
                        AssetImage("images/icone_imagem.png"),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
            Container(
             child: Center(
               child: Text(
                 "Insira abaixo as informações do seu perfil",
                 style: TextStyle(
                   fontSize: 28,
                   color: Colors.blueGrey,
                   fontWeight: FontWeight.bold
                 ),
               ),
             ),
            ),
            Divider(),
            TextField(
              controller: controladorApelido,
              onChanged: (text){
                setState(() {
                  _editarPerfil.apelido = text;
                });
              },
              decoration: InputDecoration(
                labelText: "Apelido",
                labelStyle: TextStyle(
                  fontSize: 18,
                )
              ),
            ),
            TextField(
              onChanged: (text){
                setState(() {
                  _editarPerfil.descricao = text;
                });
              },
              controller: controladorDescricao,
              decoration: InputDecoration(
                  labelText: "Descrição",
                  labelStyle: TextStyle(
                    fontSize: 18,
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  void mostrarOpcaoImagem(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            child: Column(
             mainAxisSize: MainAxisSize.min,
             children: <Widget>[
               FlatButton(
                 child: Icon(
                   Icons.panorama,
                   size: 40,
                   color: Colors.lightGreen,
                 ),
                 onPressed: (){
                   ImagePicker.pickImage(source: ImageSource.gallery).then((file){
                     if(file == null)
                       return;
                     
                     setState(() {
                       _editarPerfil.imagem = file.path;
                     });

                     Navigator.pop(context);
                   });
                 },
               ),
               Divider(),
               FlatButton(
                 child: Icon(
                   Icons.camera_alt,
                   size: 40,
                   color: Colors.lightGreen
                 ),
                 onPressed: (){
                   ImagePicker.pickImage(source: ImageSource.camera).then((file){
                     if(file == null)
                       return;

                     setState(() {
                       _editarPerfil.imagem = file.path;
                     });

                     Navigator.pop(context);
                   });
                 }
               )
             ],
            ),
          );
        }
    );
  }
}

