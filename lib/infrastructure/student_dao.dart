import 'package:upg_fisi/infrastructure/dao.dart';
import 'package:upg_fisi/model/student.dart';

class StudentDao implements Dao<Student> {
  final tableName = 'student';
  final columnId = 'id';
  final _columnNames = 'names';
  final _columnCodigo = 'codigo';
  final _columnApepaterno = 'apepaterno';
  final _columnApematerno = 'apematerno';
  final _columnDni = 'dni';

  @override
  String get createTableQuery =>
    "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
    " $_columnNames TEXT,"
    " $_columnCodigo TEXT,"
    " $_columnApepaterno TEXT,"
    " $_columnApematerno TEXT,"
    " $_columnDni TEXT)";

  @override
  Student fromMap(Map<String, dynamic> query) {
    Student student = Student(query[_columnNames], query[_columnCodigo], query[_columnApepaterno], query[_columnApematerno], query[_columnDni]);
    return student;
  }

  @override
  Map<String, dynamic> toMap(Student student) {
    return <String, dynamic>{
      _columnNames: student.names,
      _columnCodigo: student.codigo,
      _columnApepaterno: student.apepaterno,
      _columnApematerno: student.apematerno,
      _columnDni: student.dni
    };
  }

  Student fromDbRow(dynamic row) {
    return Student.withId(row[columnId], row[_columnNames], row[_columnCodigo], row[_columnApepaterno], row[_columnApematerno],row[_columnDni]);
  }

  @override
  List<Student> fromList(result) {
    List<Student> students = List<Student>();
    var count = result.length;
    for (int i = 0; i < count; i++) {
      students.add(fromDbRow(result[i]));
    }
    return students;
  }
}
