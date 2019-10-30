import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if( _database != null ) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {

    Directory directory = await getApplicationDocumentsDirectory();

    final path = join( directory.path, 'ScansDb.db' );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: ( Database db, int version ) async {
        await db.execute(
          'CREATE TABLE Scans ('
            'id INTEGER PRIMARY KEY,'
            'tipo TEXT,'
            'valor TEXT'
          ')'
        );
      }
    );
  }

  /* insert ( ScanModel newScan ) async {

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO Scans (id, tipo, valor) "
      "VALUES ( ${ newScan.id }, '${ newScan.tipo }', '${ newScan.valor }' )"
    );

    return res;

  } */

  Future<int> insert ( ScanModel newScan ) async {
    final db = await database;

    return await db.insert('Scans', newScan.toJson() );
  }

  Future<ScanModel> getScanById ( int id ) async {
    final db = await database;

    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScan () async {
    final db = await database;

    final res = await db.query('Scans');

    return res.isNotEmpty ? 
      res.map( (s) => ScanModel.fromJson(s) ).toList() :
      null;
  }

  Future<List<ScanModel>> getScansByType ( String type ) async {
    final db = await database;

    final res = await db.query('Scans', where: 'type = ?', whereArgs: [type]);

    return res.isNotEmpty ? 
      res.map( (s) => ScanModel.fromJson(s) ).toList() :
      null;
  }
  
  update ( ScanModel updatedScan ) async {
    final db = await database;

    return await db.update(
      'Scans', 
      updatedScan.toJson(),
      where: 'id = ?',
      whereArgs: [ updatedScan.id ]
    );

  }

  Future<int> delete ( int id ) async {
    final db = await database;

    return await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll () async {
    final db = await database;

    return await db.delete('Scans');
  }
}