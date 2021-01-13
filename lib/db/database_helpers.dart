import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:istudy/models/lesson_model.dart';
import 'package:istudy/models/category_model.dart';
import 'package:istudy/models/test_model.dart';

class DatabaseHelper{
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();


  static Database _database;
  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "istudy.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Lesson ("
          "id INTEGER PRIMARY KEY,"
          "category_id INTEGER,"
          "title TEXT,"
          "content TEXT,"
          "week INTEGER,"
          "hour INTEGER,"
          "image TEXT,"
          "FOREIGN KEY (category_id) REFERENCES Category (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
          ")");

      await db.execute("CREATE TABLE Category ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "image TEXT"
          ")");

      await db.execute("CREATE TABLE Variant ("
          "id INTEGER PRIMARY KEY,"
          "variant_text TEXT,"
          "test_id INTEGER,"
          "FOREIGN KEY (test_id) REFERENCES Test (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
          ")");

      await db.execute("CREATE TABLE Test ("
          "id INTEGER PRIMARY KEY,"
          "lesson_id INTEGER,"
          "question TEXT,"
          "answer INTEGER,"
          "FOREIGN KEY (answer) REFERENCES Variant (id) ON DELETE NO ACTION ON UPDATE NO ACTION,"
          "FOREIGN KEY (lesson_id) REFERENCES Lesson (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
          ")");
    });
  }

  insert_lesson(Lesson lesson) async {
    final Database db = await database;
    await db.insert(
      'Lesson',
      lesson.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  insert_category(Category category) async {
    final Database db = await database;
    await db.insert(
      'Category',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  insert_variant(Variant variant) async {
    final Database db = await database;
    await db.insert(
      'Variant',
      variant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  insert_test(Test test) async {
    final Database db = await database;
    await db.insert(
      'Test',
      test.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  get_test(int lesson_id) async {
    final db = await database;
    var res = await  db.query("Test", where: "lesson_id = ?", whereArgs: [lesson_id]);
    return res;
  }

  get_variant(int test_id) async {
    final db = await database;
    var res = await  db.query("Variant", where: "test_id = ?", whereArgs: [test_id]);
    return res;
  }

  get_lesson(int id) async {
    final db = await database;
    var res =await  db.query("Lesson", where: "id = ?", whereArgs: [id]);
    return res;
  }

  get_category(int id) async {
    final db = await database;
    var res =await  db.query("Category", where: "id = ?", whereArgs: [id]);
    return res;
  }

  get_lesson_by_cat_id(int category_id) async {
    final db = await database;
    var res =await  db.query("Lesson", where: "category_id = ?", whereArgs: [category_id]);
    return res;
  }

  get_all_lesson() async {
    final db = await database;
    var res = await db.query("Lesson");
    return res;
  }

  get_all_category() async {
    final db = await database;
    var res = await db.query("Category");
    return res;
  }

  get_all_variant() async {
    final db = await database;
    var res = await db.query("Variant");
    return res;
  }

  update_lesson(Lesson lesson) async {
    final db = await database;
    var res = await db.update("Lesson", lesson.toMap(),
        where: "id = ?", whereArgs: [lesson.id]);
    return res;
  }

}

