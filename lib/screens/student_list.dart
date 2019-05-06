import 'package:flutter/material.dart';
import 'package:practica1/infrastructure/student_sqflite_repository.dart';
import 'package:practica1/infrastructure/database_provider.dart';
import 'package:practica1/model/student.dart';
import 'package:practica1/screens/student_detail.dart';

class StudentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StudentListState();
}

class StudentListState extends State<StudentList> {
  StudentSqfliteRepository studentRepository = StudentSqfliteRepository(DatabaseProvider.get);
  List<Student> students;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (students == null) {
      students = List<Student>();
      getData();
    }
    return Scaffold(
      body: studentListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          navigateToDetail(Student('', '', '','',''));
        }
        ,
        tooltip: "Add new Student",
        child: new Icon(Icons.add),
      ),
    );
  }
  
  ListView studentListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.students[position].id),
              child:Text(this.students[position].id.toString()),
            ),
          title: Text(this.students[position].names),
          subtitle: Text(this.students[position].apepaterno.toString()),
          onTap: () {
            debugPrint("Tapped on " + this.students[position].id.toString());
            navigateToDetail(this.students[position]);
          },
          ),
        );
      },
    );
  }
  
  void getData() {    
      final studentFuture = studentRepository.getList();
      studentFuture.then((studentList) {
        setState(() {
          students = studentList;
          count = studentList.length;
        });
        debugPrint("Items " + count.toString());
      });
  }

  Color getColor(int semester) {
    switch (semester) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.yellow;
        break;
      case 4:
        return Colors.green;
        break;
      default:
        return Colors.green;
    }
  }

  void navigateToDetail(Student student) async {
    bool result = await Navigator.push(context, 
        MaterialPageRoute(builder: (context) => StudentDetail(student)),
    );
    if (result == true) {
      getData();
    }
  }
}
