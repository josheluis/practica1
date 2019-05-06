import 'package:flutter/material.dart';
import 'package:practica1/infrastructure/student_sqflite_repository.dart';
import 'package:practica1/infrastructure/database_provider.dart';
import 'package:practica1/model/student.dart';

StudentSqfliteRepository studentRepository = StudentSqfliteRepository(DatabaseProvider.get);
final List<String> choices = const <String> [
  'Save Student & Back',
  'Delete Student',
  'Back to List'
];

const mnuSave = 'Save Student & Back';
const mnuDelete = 'Delete Student';
const mnuBack = 'Back to List';

class StudentDetail extends StatefulWidget {
  final Student student;
  StudentDetail(this.student);

  @override
  State<StatefulWidget> createState() => StudentDetailState(student);
}

class StudentDetailState extends State<StudentDetail> {
  Student student;
  StudentDetailState(this.student);
  final _semesterList = [1, 2, 3, 4];
  final _creditList = [3, 4, 6, 8, 10];
  int _semester = 1;
  int _credits = 4;
  TextEditingController namesController = TextEditingController();
  TextEditingController codigoController = TextEditingController();
  TextEditingController apePaternoController = TextEditingController();
  TextEditingController apeMaternoController = TextEditingController();
  TextEditingController dniController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    namesController.text = student.names;
    codigoController.text = student.codigo;
    apePaternoController.text = student.apepaterno;
    apeMaternoController.text = student.apematerno;
    dniController.text = student.dni;

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(student.names),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: select,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding( 
        padding: EdgeInsets.only(top:35.0, left: 10.0, right: 10.0),
        child: ListView(children: <Widget>[Column(
        children: <Widget>[
          TextField(
            controller: codigoController,
            style: textStyle,
            onChanged: (value) => this.updateNames(),
            decoration: InputDecoration(
              labelText: "Código:",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ),          
          TextField(
            controller: namesController,
            style: textStyle,
            onChanged: (value) => this.updateNames(),
            decoration: InputDecoration(
              labelText: "Nombres",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ),
          TextField(
            controller: apePaternoController,
            style: textStyle,
            onChanged: (value) => this.updateNames(),
            decoration: InputDecoration(
              labelText: "Apellido Paterno:",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ),
          TextField(
            controller: apeMaternoController,
            style: textStyle,
            onChanged: (value) => this.updateNames(),
            decoration: InputDecoration(
              labelText: "Apellido Materno:",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ),

          TextField(
            controller: dniController,
            style: textStyle,
            onChanged: (value) => this.updateNames(),
            decoration: InputDecoration(
              labelText: "DNI:",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          )


          
        ],
      )],)
      )
    );
  }

  void select (String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true);
        if (student.id == null) {
          return;
        }
        result = await studentRepository.delete(student);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Delete Student"),
            content: Text("The Student has been deleted"),
          );
          showDialog(
            context: context,
            builder: (_) => alertDialog);
          
        }
        break;
        case mnuBack:
          Navigator.pop(context, true);
          break;
      default:
    }
  }

  void save() {
    if (student.id != null) {
      debugPrint('update');
      studentRepository.update(student);
    }
    else {
      debugPrint('insert');
      studentRepository.insert(student);
    }
    Navigator.pop(context, true);
  }



  int retrieveSemester(int value) {
    return _semesterList[value-1];
  }

  void updateNames(){
    student.names = namesController.text;
  }


}
