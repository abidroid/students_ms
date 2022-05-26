import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_ms/db/database_helper.dart';

import '../models/student.dart';

class UpdateStudentScreen extends StatefulWidget {
  final Student student;
  const UpdateStudentScreen({Key? key, required this.student}) : super(key: key);

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {

  var formKey = GlobalKey<FormState>();
  late String name, course, mobile, totalFee, feePaid;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student'),
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

                  initialValue: widget.student.name,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'Please provide name';
                    }

                    name = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  initialValue: widget.student.course,
                  decoration: InputDecoration(
                      hintText: 'Course',
                      labelText: 'Course',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'Please provide course';
                    }

                    course = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  keyboardType: TextInputType.number,
                initialValue: widget.student.mobile,
                  decoration: InputDecoration(
                      hintText: 'Mobile',
                      labelText: 'Mobile',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'Please provide mobile';
                    }

                    mobile = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.student.totalFee.toString(),
                  decoration: InputDecoration(
                      hintText: 'Total Fee',
                      labelText: 'Total Fee',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'Please provide name';
                    }

                    totalFee = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: '${widget.student.feePaid}',
                  decoration: InputDecoration(
                      hintText: 'Fee Paid',
                      labelText: 'Fee Paid',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'Please provide name';
                    }

                    feePaid = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),

                ElevatedButton(onPressed: () async{
                  if( formKey.currentState!.validate()){
                    // update record in DB Table

                    Student s = Student(
                      id: widget.student.id,
                      name: name,
                      course: course,
                      mobile: mobile,
                      totalFee: int.parse(totalFee),
                      feePaid: int.parse(feePaid),
                    );

                    int result = await DatabaseHelper.instance.updateStudent(s);

                    if( result > 0 ){
                      Fluttertoast.showToast(msg: "Record Update", backgroundColor: Colors.green);
                      Navigator.pop(context, 'done');

                    }else{
                      Fluttertoast.showToast(msg: "Updating Failed", backgroundColor: Colors.red);

                    }
                  }

                }, child: const Text('Update')),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
