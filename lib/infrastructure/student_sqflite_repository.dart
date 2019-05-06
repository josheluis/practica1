import 'package:practica1/infrastructure/student_dao.dart';
import 'package:practica1/infrastructure/student_repository.dart';
import 'package:practica1/infrastructure/database_provider.dart';
import 'package:practica1/model/student.dart';

class StudentSqfliteRepository implements StudentRepository {
  final dao = StudentDao();

  @override
  DatabaseProvider databaseProvider;

  StudentSqfliteRepository(this.databaseProvider);

  @override
  Future<int> insert(Student student) async {
    final db = await databaseProvider.db();
    var id = await db.insert(dao.tableName, dao.toMap(student));
    return id;
  }

  @override
  Future<int> delete(Student student) async {
    final db = await databaseProvider.db();
    int result = await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [student.id]);
    return result;
  }

  @override
  Future<int> update(Student student) async {
    final db = await databaseProvider.db();
    int result = await db.update(dao.tableName, dao.toMap(student),
        where: dao.columnId + " = ?", whereArgs: [student.id]);
    return result;
  }

  @override
  Future<List<Student>> getList() async {
    final db = await databaseProvider.db();
    var result = await db.rawQuery("SELECT * FROM student order by 1");
    return dao.fromList(result);
  }
}