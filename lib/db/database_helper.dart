import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/student.dart';

class DatabaseHelper {
  // database
  DatabaseHelper._privateConstructor(); // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // getter for database

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database

    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/students.db';

    // open/ create database at a given path
    var studentsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return studentsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE tbl_student (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  name TEXT,
                  course TEXT,
                  mobile TEXT, 
                  totalFee INTEGER, 
                  feePaid INTEGER )
    
    ''');
  }

  // insert
  Future<int> insertStudent(Student s) async {
    // add student to table

    Database db = await instance.database;
    //int result = await db.rawInsert('INSERT INTO tbl_student (name, course, mobile, totalFee, feePaid) VALUES (?, ?, ?, ?, ?)', [s.name, s.course, s.mobile, s.totalFee, s.feePaid]);

    int result = await db.insert('tbl_student', s.toMap());

    return result;
  }

  // read

  Future<List<Student>> getAllStudents() async {
    List<Student> students = [];

    // read data from table
    Database db = await instance.database;
    //db.rawQuery('SELECT * from tbl_student');

    List<Map<String, dynamic>> listMap = await db.query('tbl_student');

    for (var studentMap in listMap) {
      Student s = Student.fromMap(studentMap);
      students.add(s);
    }

    await Future.delayed(const Duration(seconds: 3));
    return students;
  }

  // update
  Future<int> updateStudent(Student s) async {
    Database db = await instance.database;
    /*
    int result = await db.rawUpdate(
        'UPDATE tbl_student set name=?, course=?, mobile=?, totalFee=?, feePaid=? where id=?',
        [s.name, s.course, s.mobile, s.totalFee, s.feePaid, s.id]);
  */
    int result = await db.update('tbl_student', s.toMap(), where: 'id=?', whereArgs: [s.id]);
    return result;
  }

  // delete

  Future<int> deleteStudent(int id) async {
    Database db = await instance.database;
    //int result = await db.rawDelete('DELETE from tbl_student where id=?', [id] );

    int result = await db.delete('tbl_student', where: 'id=?', whereArgs: [id]);
    return result;
  }
}
