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

    //TextStyle textStyle = Theme.of(context).textTheme.title;
    TextStyle textStyle = Theme.of(context).textTheme.title;
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Alumno: ' + student.names + ' ' + student.apepaterno),
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
          Padding(
            padding:  EdgeInsets.only(top:10.0, bottom: 0.0),
            child:  
                  TextField(
                    controller: codigoController,
                    style: textStyle,
                    onChanged: (value) => this.updateCodigo(),
                    decoration: InputDecoration(
                      labelText: "Código:",
                      labelStyle: textStyle,
                      hintText: 'Ingrese el código',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                    ),
                  )),          
          Padding(
            padding: EdgeInsets.only(top:10.0, bottom: 0.0),
            child:
            TextField(
                controller: namesController,
                style: textStyle,
                onChanged: (value) => this.updateNames(),
                decoration: InputDecoration(
                  labelText: "Nombres",
                  labelStyle: textStyle,
                  hintText: 'Ingrese los nombres',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
                  )),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
            child:        
                  TextField(
                    controller: apePaternoController,
                    style: textStyle,
                    onChanged: (value) => this.updateApepaterno(),               
                    decoration: InputDecoration(
                      labelText: "Apellido Paterno:",
                      labelStyle: textStyle,
                      hintText: 'Ingrese apellido paterno',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                    ),
          )),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
            child: 
            TextField(
            controller: apeMaternoController,
            style: textStyle,
            onChanged: (value) => this.updateApematerno(),
            decoration: InputDecoration(
              labelText: "Apellido Materno:",
              labelStyle: textStyle,
              hintText: 'Ingrese apellido materno',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          )),

          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
            child:           
                  TextField(
                    controller: dniController,
                    style: textStyle,
                    onChanged: (value) => this.updateDNI(),
                    decoration: InputDecoration(
                      labelText: "DNI:",
                      labelStyle: textStyle,
                      hintText: 'Ingrese el DNI',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                    ),
                  )),

          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
            child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xff01A0C7),
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: () => save(),
                              child: Text("agregar alumno",
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
        )
            
          ),

          
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


  void updateCodigo(){
    student.codigo = codigoController.text;
  }

  void updateNames(){
    student.names = namesController.text;
  }
  
  void updateApepaterno(){
    student.apepaterno = apePaternoController.text;
  }

  void updateApematerno(){
    student.apematerno = apeMaternoController.text;
  }

  void updateDNI(){
    student.dni = dniController.text;
  }
        

}
