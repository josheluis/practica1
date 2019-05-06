import 'package:practica1/infrastructure/database_provider.dart';
import 'package:practica1/model/student.dart';

abstract class StudentRepository {
  DatabaseProvider databaseProvider;
  Future<int> insert(Student course);
  Future<int> update(Student course);
  Future<int> delete(Student course);
  Future<List<Student>> getList();
}