import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tabelaPerfil = "perfil";
final String colunaId = "id";
final String colunaApelido = "apelido";
final String colunaDescricao = "descricao";
final String colunaImagem = "imagem";

class PerfilHelper {
  static final PerfilHelper _instance = PerfilHelper.internal();
  factory PerfilHelper() => _instance;
  PerfilHelper.internal();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await iniciarBanco();
      return _db;
    }
  }

  Future<Database> iniciarBanco() async {
    final String pathBancoDados = await getDatabasesPath();
    final String path = join(pathBancoDados, "banco_minhas_contas.db");

    Database dbAberto = await openDatabase(path, version: 5, onCreate: (Database db, int novaVersao) async {
      db.execute("CREATE TABLE $tabelaPerfil("
          "$colunaId INTEGER PRIMARY KEY,"
          "$colunaApelido TEXT,"
          "$colunaDescricao TEXT,"
          "$colunaImagem TEXT"
          ")");
    });

    return dbAberto;
  }

  Future<Perfil> salvarPerfil(Perfil perfil) async {

    debugPrint("salvar ${perfil.toString()}");
    Database _dbSalvar = await db;
    perfil.id = await _dbSalvar.insert(tabelaPerfil, perfil.toMap());
    return perfil;
  }

  Future<List> buscarTodas() async {
    Database _dbBuscar = await db;
    List<Map> maps = await _dbBuscar.rawQuery("SELECT * FROM $tabelaPerfil");
    List<Perfil> perfis = List();

    for(Map m in maps)
      perfis.add(Perfil.fromMap(m));

    return perfis;
  }

  Future<int> deletarPerfil(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(tabelaPerfil, where: "$colunaId = ?", whereArgs: [id]);
  }
}

class Perfil {
  int id;
  String apelido;
  String descricao;
  String imagem;

  Perfil();

  Perfil.fromMap(Map map){
    id = map[colunaId];
    apelido = map[colunaApelido];
    descricao = map[colunaDescricao];
    imagem = map[colunaImagem];

    debugPrint("from map: id: $id, apelido: $apelido, descricao: $descricao, imagem: $imagem");
  }

  Map toMap(){
    Map<String, dynamic> map = {
      colunaApelido: apelido,
      colunaDescricao: descricao,
      colunaImagem: imagem
    };

    if (id != null) {
      map[colunaId] = id;
    }

    return map;
  }

  @override
  String toString(){
    return "Contact(id: $id, apelido: $apelido, descricao: $descricao, imagem: $imagem)";
  }
}