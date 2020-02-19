import 'package:minhas_contas/helpers/perfil_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String tabelaConta = "conta";
final String colunaId = "id";
final String colunaIdPerfil = "idPerfil";
final String colunaApelido = "apelido";
final String colunaDescricao = "descricao";
final String colunaImagem = "imagem";
final String colunaNomeBanco = "nomeBanco";
final String colunaCodigoBanco = "codigoBanco";
final String colunaAgencia = "agencia";
final String colunaConta = "conta";
final String colunaDigitoConta = "digito_conta";
final String colunaTipo = "tipo";
final String colunaCpfCnpj = "cpf_cnpj";

class ContaHelper {
  ContaHelper.internal();
  static final ContaHelper _instance = ContaHelper.internal();
  factory ContaHelper() => _instance;

  Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    else {
      _db = await iniciarBanco();
      return _db;
    }
  }
  Future<Database> iniciarBanco() async {
    final String pathBancoDados = await getDatabasesPath();
    final String path = join(pathBancoDados, "banco_minhas_contas.db");

    Database dbAberto = await openDatabase(path, version: 5, onCreate: (Database db, int novaVersao) async {
      db.execute("CREATE TABLE $tabelaConta ("
          "$colunaId INTEGER PRIMARY KEY,"
          "$colunaIdPerfil INTEGER,"
          "$colunaApelido TEXT,"
          "$colunaDescricao TEXT,"
          "$colunaImagem TEXT,"
          "$colunaNomeBanco TEXT,"
          "$colunaCodigoBanco TEXT,"
          "$colunaAgencia TEXT,"
          "$colunaConta TEXT,"
          "$colunaDigitoConta TEXT,"
          "$colunaTipo TEXT,"
          "$colunaCpfCnpj TEXT"
          ")");
    });

  }
}

class Conta {
  int id;
  int idPerfil;
  String apelido;
  String descricao;
  String imagem;
  String nomeBanco;
  String codigoBanco;
  String agencia;
  String conta;
  String digitoConta;
  String tipo;
  String cpfCnpj;

  Conta();

  Conta.fromMap(Map map){
    id = map[colunaId];
    idPerfil = map[colunaIdPerfil];
    apelido = map[colunaApelido];
    descricao = map[colunaDescricao];
    imagem = map[colunaImagem];
    nomeBanco = map[colunaNomeBanco];
    codigoBanco = map[colunaCodigoBanco];
    agencia = map[colunaAgencia];
    conta = map[colunaConta];
    digitoConta = map[colunaDigitoConta];
    tipo = map[colunaTipo];
    cpfCnpj = map[colunaCpfCnpj];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      colunaIdPerfil: idPerfil,
      colunaApelido: apelido,
      colunaDescricao: descricao,
      colunaImagem: imagem,
      colunaNomeBanco: nomeBanco,
      colunaCodigoBanco: codigoBanco,
      colunaAgencia: agencia,
      colunaConta: conta,
      colunaDigitoConta: digitoConta,
      colunaTipo: tipo,
      colunaCpfCnpj: cpfCnpj
    };

    if(id != null)
      map[colunaId] = id;

    return map;
  }
}



















