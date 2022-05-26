import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_ms/db/database_helper.dart';
import 'package:students_ms/models/student.dart';
import 'package:students_ms/screens/update_student_screen.dart';

class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({Key? key}) : super(key: key);

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students List"),
      ),
      body: FutureBuilder<List<Student>>(
          future: DatabaseHelper.instance.getAllStudents(),
          builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot){

            if( !snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }else {

              if( snapshot.data!.isEmpty){
                return const Center(child: Text('No Records Found'));

              }else{

                List<Student> students = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index){

                        Student s = students[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.amber[200],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.circular(16.0)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(s.id.toString()),

                                      Text(s.name),
                                      Text(s.course),
                                      Text(s.mobile),
                                      Text(s.totalFee.toString()),
                                      Text(s.feePaid.toString())
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(16.0)
                                ),
                                child: Column(
                                  children: [
                                    IconButton(onPressed: () async{
                                    String result =  await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                        return UpdateStudentScreen(student: s);
                                      }));

                                    if( result == 'done'){
                                      setState((){});
                                    }



                                    }, icon: const Icon(Icons.edit)),
                                    IconButton(onPressed: (){

                                      showDialog(
                                          barrierDismissible: false,
                                          context: context, builder: (context){
                                        return AlertDialog(
                                          title: const Text('Confirmation!!!'),
                                          content: const Text('Are you sure to delete?'),
                                          actions: [
                                            TextButton(onPressed: (){
                                              Navigator.of(context).pop();
                                            }, child: const Text('No')),
                                            TextButton(onPressed: () async{
                                              Navigator.of(context).pop();

                                              // delete student

                                              int result = await DatabaseHelper.instance.deleteStudent(s.id!);

                                              if( result > 0 ){
                                                Fluttertoast.showToast(msg: 'RECORD DELETED');
                                                setState((){});
                                                // build function will be called
                                              }

                                            }, child: const Text('Yes')),

                                          ],
                                        );
                                      });

                                    }, icon: const Icon(Icons.delete)),

                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                  }),
                );
              }

            }

      }),
    );
  }
}
