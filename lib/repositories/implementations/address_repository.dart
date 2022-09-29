import 'dart:convert';

import 'package:konsi/database/db.dart';
import 'package:konsi/models/address.dart';
import 'package:konsi/repositories/address_repository_interface.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqlite_api.dart';

class AddressRepository implements AddressRepositoryInterface {
  final String _tableName = "adresses";
  late Database db;

  @override
  Future<Address> searchApiCEP(String cep) async {
    var url = Uri.parse('https://viacep.com.br/ws/$cep/json');

    var response = await http.get(url);

    var decoded = jsonDecode(response.body);

    if (decoded['erro'] != null || response.statusCode != 200) {
      return Future.error("CEP não encontrado!");
    }

    return Address.fromJson(decoded);
  }

  Future<List<Address>> listAll() async {
    try {
      db = (await DB.instance.database)!;

      List adresses = await db.query(_tableName);

      return adresses.map((address) => Address.fromJson(address)).toList();
    } catch (e) {
      return Future.error("Foi possível localizar os endereços cadastrados!");
    }
  }

  Future<void> create(Address address) async {
    try {
      db = (await DB.instance.database)!;

      final hasAddress = await db
          .rawQuery('SELECT * FROM $_tableName WHERE cep=?', [address.cep]);

      if (hasAddress.isNotEmpty) {
        return Future.error("Este CEP já foi cadastrado!");
      }

      await db.insert(_tableName, address.toJson());
    } catch (e) {
      return Future.error("Não foi possível realizar o cadastro");
    }
  }

  Future<List<Address>> findByCEP(String cep) async {
    try {
      db = (await DB.instance.database)!;

      List adresses = await db.query(_tableName, where: 'cep LIKE ?', whereArgs: ['%$cep%']);

      return adresses.map((address) => Address.fromJson(address)).toList();
    } catch (e) {
      return Future.error("Não foi possível realizar a pesquisa");
    }
  }
}
