import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_ms/db/database_helper.dart';
import 'package:students_ms/models/student.dart';
import 'package:students_ms/screens/students_list_screen.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  var formKey = GlobalKey<FormState>();

  late String name, course, mobile, totalFee, feePaid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'Please provide name';
                    }

                    name = text;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Course',
                      labelText: 'Course',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'Please provide course';
                    }

                    course = text;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Mobile',
                      labelText: 'Mobile',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'Please provide mobile';
                    }

                    mobile = text;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Total Fee',
                      labelText: 'Total Fee',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'Please provide name';
                    }

                    totalFee = text;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Fee Paid',
                      labelText: 'Fee Paid',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'Please provide name';
                    }

                    feePaid = text;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        // save record in DB Table
                        // create a student object
                        Student s = Student(
                          name: name,
                          course: course,
                          mobile: mobile,
                          totalFee: int.parse(totalFee),
                          feePaid: int.parse(feePaid),
                        );

                        int result = await DatabaseHelper.instance.insertStudent(s);

                        if( result > 0 ){
                          Fluttertoast.showToast(msg: "Record Saved", backgroundColor: Colors.green);
                        }else{
                          Fluttertoast.showToast(msg: "Record Failed", backgroundColor: Colors.red);

                        }
                      }
                    },
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return const StudentsListScreen();
                      }));
                    },
                    child: const Text('View All')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
