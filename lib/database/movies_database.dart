import 'dart:io';

import 'package:fluttersample1/models/MoviesDAO.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MoviesDatabase {
  static final NAMEDB = 'MOVIESDB';
  static final VERSIONDB = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await initDatabase();
  }

  Future<Database> initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path, NAMEDB);
    return openDatabase(
      path,
      version: VERSIONDB,
      onCreate: (db, version) {
        String query1 = '''
          CREATE TABLE tblgenre()(
          idGenre char(1) PRIMARY KEY,
          dscgenre VARCHAR(50)
          );
          ''';
        db.execute(query1);
        String query2 = '''CREATE TABLE tblmovies(
          idMovie INTEGER PRIMARY KEY,
          nameMovie VARCHAR(100),
          overview TEXT,
          IdGenre  char(1),
          imgMovie VARCHAR(150),
          releaseDate date,
          CONSTRAINT fk_gen FOREIGN KEY(idGenre) REFERENCES tblgenre(idGenre) 
          );''';
        db.execute(query2);
      },
    );
  } //INIT DATABASE

  Future<int> INSERT(String table, Map<String, dynamic> row) async {
    var con = await database;
    return con.insert(table, row);
  }

  Future<int> UPDATE(String table, Map<String, dynamic> row) async {
    var con = await database;
    return con
        .update(table, row, where: 'idMovie = ?', whereArgs: [row['idMovie']]);
  }

  Future<int> DELETE(String table, int idMovie) async {
    var con = await database;
    return con.delete(table, where: 'idMovie = ?', whereArgs: [idMovie]);
  }

  Future<List<Moviesdao>> SELECT() async {
    var con = await database;
    var result = await con.query('tblmovies');
    return result.map((movie) => Moviesdao.fromMap(movie)).toList();
  }
}
