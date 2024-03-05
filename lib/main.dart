import 'dart:html';
import 'dart:js_interop';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lib_manage/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String studentName, studentID, studyProgramID;
  late double studentGPA;

  getStudentName(name) {
    this.studentName = name;
  }

  getStudentID(id) {
    this.studentID = id;
  }

  getStudyProgramID(programID) {
    this.studyProgramID = programID;
  }

  getStudentGPA(gpa) {
    this.studentGPA = double.parse(gpa);
  }

  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('MyStudents').doc(studentName);
    Map<String, dynamic> students = {
      'studentName': studentName,
      'studentID': studentID,
      'studyProgramID': studyProgramID,
      'studentGPA': studentGPA
    };

    documentReference.set(students).whenComplete(() {
      print('$studentName created');
    });
  }

// var a = user.userLocation() as Map;
// print(a['location]['city']);

  // var data = dataSnapshot.value as Map?;

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('MyStudents').doc(studentName);

    documentReference.get().then((datasnapshot) {
      var a = datasnapshot.data() as Map;
      print(a['studentName']);
      print(a['studentID']);
      print(a['studyProgramID']);
      print(a['studentGPA']);
    });
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('MyStudents').doc(studentName);
    Map<String, dynamic> students = {
      'studentName': studentName,
      'studentID': studentID,
      'studyProgramID': studyProgramID,
      'studentGPA': studentGPA
    };

    documentReference.set(students).whenComplete(() {
      print('$studentName created');
    });
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
    documentReference.delete().whenComplete(() {
      print('$studentName deleted');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SRPTC Libary Management System"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String name) {
                getStudentName(name);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "Student ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String id) {
                getStudentID(id);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "Study Program ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String programID) {
                getStudyProgramID(programID);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  labelText: "GPA",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))),
              onChanged: (String gpa) {
                getStudentGPA(gpa);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // background (button) color
                  foregroundColor: Colors.white, // foreground (text) color
                ),
                onPressed: () {
                  createData();
                },
                child: const Text('Create'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // background (button) color
                  foregroundColor: Colors.white, // foreground (text) color
                ),
                onPressed: () {
                  readData();
                },
                child: const Text('Read'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // background (button) color
                  foregroundColor: Colors.white, // foreground (text) color
                ),
                onPressed: () {
                  updateData();
                },
                child: const Text('Update'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // background (button) color
                  foregroundColor: Colors.white, // foreground (text) color
                ),
                onPressed: () {
                  deleteData();
                },
                child: const Text('Delete'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                Expanded(child: Text("Name")),
                Expanded(child: Text("Student ID")),
                Expanded(child: Text("Study Program ID")),
                Expanded(child: Text("GPA")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("MyStudents")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return Row(
                        children: [
                          Expanded(
                            child: Text(documentSnapshot['studentName']),
                          ),
                          Expanded(
                            child: Text(documentSnapshot['studentID']),
                          ),
                          Expanded(
                            child: Text(documentSnapshot['studyProgramID']),
                          ),
                          Expanded(
                            child:
                                Text(documentSnapshot['studentGPA'].toString()),
                          )
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CircularProgressIndicator(),
                  ); // Or any other loading indicator
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
