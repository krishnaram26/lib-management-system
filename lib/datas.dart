import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'table.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedDept;

  TextEditingController _fromDateController = TextEditingController();
  TextEditingController _toDateController = TextEditingController();
  var selectedCategory;
  final categories = ["CSE", "Auto", "Mech", "Civil", 'EEE', 'ECE', 'CCN'];
  late String studentName,
      // studentID,
      // bookID,
      author,
      bookTitle,
      verifiedBy,
      studentDept,
      fromDate,
      toDate;
  late double studentID = 0.0;
  // late String author = '';
  late double bookID = 0.0;

  getStudentName(name) {
    this.studentName = name;
  }

  getDept(dept) {
    this.studentDept = dept;
  }

  getStudentID(id) {
    this.studentID = double.parse(id);
  }

  getBookID(book) {
    this.bookID = double.parse(book);
  }

  getAuthor(authorName) {
    this.author = authorName;
  }

  getBookTitle(title) {
    this.bookTitle = title;
  }

  getVerifiedBy(verify) {
    this.verifiedBy = verify;
  }

  getFromDate(from) {
    this.fromDate = from;
  }

  getToDate(to) {
    this.toDate = to;
  }
  // getStudentGPA(gpa) {
  //   this.studentGPA = double.parse(gpa);

  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('MyStudents').doc(studentName);
    Map<String, dynamic> students = {
      'studentName': studentName,
      'studentID': studentID,
      'studentDept': studentDept,
      'bookID': bookID,
      'author': author,
      'bookTitle': bookTitle,
      'verifiedBy': verifiedBy,
      'fromDate': fromDate,
      'toDate': toDate
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
      print(a['studentDept']);
      print(a['studentID']);
      print(a['bookID']);
      print(a['author']);
      print(a['bookTitle']);
      print(a['verifiedBy']);
      print(a['fromDate']);
      print(a['toDate']);
    });
  }

  // updateData() {
  //   DocumentReference documentReference =
  //       FirebaseFirestore.instance.collection('MyStudents').doc(studentName);
  //   Map<String, dynamic> students = {
  //     'studentName': studentName,
  //     'studentID': studentID,
  //     'studentDept': studentDept,
  //     'bookID': bookID,
  //     'author': author,
  //     'bookTitle': bookTitle,
  //     'verifiedBy': verifiedBy,
  //     'fromDate': fromDate,
  //     'toDate': toDate
  //   };

  //   documentReference.set(students).whenComplete(() {
  //     print('$studentName created');
  //   });
  // }

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
        title: Text(
          "Library Management System",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black, // Set background color
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
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
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String id) {
                  getStudentID(id);
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextFormField(
            //     decoration: const InputDecoration(
            //         labelText: "Student Dept",
            //         fillColor: Colors.white,
            //         focusedBorder: OutlineInputBorder(
            //             borderSide:
            //                 BorderSide(color: Colors.blue, width: 2.0))),
            //     onChanged: (String dept) {
            //       getDept(dept);
            //     },
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Student Dept',
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                value: selectedDept,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDept = newValue!;
                    getDept(newValue);
                  });
                },
                items: <String>[
                  'CSE',
                  'Auto',
                  'Mech',
                  'Civil',
                  'EEE',
                  'ECE',
                  'CCN'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: FormField<String>(
            //     builder: (FormFieldState<String> state) {
            //       return InputDecorator(
            //         decoration: InputDecoration(
            //             border: OutlineInputBorder(
            //                 borderRadius: BorderRadius.circular(5.0))),
            //         child: DropdownButtonHideUnderline(
            //           child: DropdownButton<String>(
            //             hint: Text("Select Department"),
            //             value: selectedCategory,
            //             isDense: true,
            //             onChanged: (newValue) {
            //               setState(() {
            //                 selectedCategory = newValue;
            //                 getStudentID(dept);
            //               });
            //             },
            //             items: categories.map((String value) {
            //               return DropdownMenuItem<String>(
            //                 value: value,
            //                 child: Text(value),
            //               );
            //             }).toList(),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Book ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String book) {
                  getBookID(book);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Title",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String title) {
                  getBookTitle(title);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Author",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String author) {
                  getAuthor(author);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Verified By",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String verify) {
                  getVerifiedBy(verify);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _fromDateController,
                decoration: InputDecoration(labelText: 'From'),
                readOnly: true,
                onTap: () {
                  _selectFromDate();
                },
                // onChanged: (String from) {
                //   getFromDate(from);
                // },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _toDateController,
                decoration: InputDecoration(labelText: 'To'),
                readOnly: true,
                onTap: () {
                  _selectToDate();
                },
                // onChanged: (String from) {
                //   getFromDate(from);
                // },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green, // background (button) color
                      foregroundColor: Colors.white, // foreground (text) color
                    ),
                    onPressed: () {
                      createData();
                    },
                    child: const Text('Create'),
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.blue, // background (button) color
                  //     foregroundColor: Colors.white, // foreground (text) color
                  //   ),
                  //   onPressed: () {
                  //     readData();
                  //   },
                  //   child: const Text('Read'),
                  // ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor:
                  //         Colors.amber, // background (button) color
                  //     foregroundColor: Colors.white, // foreground (text) color
                  //   ),
                  //   onPressed: () {
                  //     updateData();
                  //   },
                  //   child: const Text('Update'),
                  // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.orange, // background (button) color
                      foregroundColor: Colors.white, // foreground (text) color
                    ),
                    onPressed: () {
                      deleteData();
                    },
                    child: const Text('Complete'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // background (button) color
                      foregroundColor: Colors.white, // foreground (text) color
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DTables()),
                      );
                    },
                    child: Text('View Users'),
                  ),
                ],
              ),
            ),
            // DataTable(columns: [
            //   DataColumn(
            //     label: Text("Name"),
            //   ),
            //   DataColumn(
            //     label: Text("Student ID"),
            //   ),
            //   DataColumn(
            //     label: Text("Study Program ID"),
            //   ),
            //   DataColumn(
            //     label: Text("title"),
            //   )
            // ], rows: [
            //   DataRow(cells: [

            //   ])
            // ]),
            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0, right: 8),
            //   child: Row(
            //     textDirection: TextDirection.ltr,
            //     children: [
            //       Expanded(
            //           child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: Colors.black,
            //                   width: 1.0,
            //                 ),
            //               ),
            //               child: Text("Name"))),
            //       Expanded(
            //           child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: Colors.black,
            //                   width: 1.0,
            //                 ),
            //               ),
            //               child: Text("Student ID"))),
            //       Expanded(
            //           child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: Colors.black,
            //                   width: 1.0,
            //                 ),
            //               ),
            //               child: Text("Student Dept"))),
            //       Expanded(
            //           child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: Colors.black,
            //                   width: 1.0,
            //                 ),
            //               ),
            //               child: Text("Book ID"))),
            //       Expanded(
            //           child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: Colors.black,
            //                   width: 1.0,
            //                 ),
            //               ),
            //               child: Text("Author"))),
            //       Expanded(
            //           child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: Colors.black,
            //                   width: 1.0,
            //                 ),
            //               ),
            //               child: Text("Title"))),
            //       Expanded(
            //           child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: Colors.black,
            //                   width: 1.0,
            //                 ),
            //               ),
            //               child: Text("Verified By"))),
            //       Expanded(
            //           child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: Colors.black,
            //                   width: 1.0,
            //                 ),
            //               ),
            //               child: Text("From Date"))),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0, right: 8),
            //   child: StreamBuilder<QuerySnapshot>(
            //     stream: FirebaseFirestore.instance
            //         .collection("MyStudents")
            //         .snapshots(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: DataTable(
            //             columns: [
            //               DataColumn(label: Text('Name')),
            //               DataColumn(label: Text('Student ID')),
            //               DataColumn(label: Text('Student Dept')),
            //               DataColumn(label: Text('Book ID')),
            //               DataColumn(label: Text('Author')),
            //               DataColumn(label: Text('Book Title')),
            //               DataColumn(label: Text('Verified By')),
            //               DataColumn(label: Text('From Date')),
            //               DataColumn(label: Text('To Date')),
            //             ],
            //             rows: snapshot.data!.docs
            //                 .map<DataRow>((documentSnapshot) {
            //               final data =
            //                   documentSnapshot.data() as Map<String, dynamic>;
            //               return DataRow(
            //                 cells: [
            //                   DataCell(Text(data['studentName'] ?? '')),
            //                   DataCell(
            //                       Text(data['studentID']?.toString() ?? '')),
            //                   DataCell(Text(data['studentDept'] ?? '')),
            //                   DataCell(Text(data['bookID']?.toString() ?? '')),
            //                   DataCell(Text(data['author'] ?? '')),
            //                   DataCell(Text(data['bookTitle'] ?? '')),
            //                   DataCell(Text(data['verifiedBy'] ?? '')),
            //                   DataCell(Text(data['fromDate'] ?? '')),
            //                   DataCell(Text(data['toDate'] ?? '')),
            //                 ],
            //               );
            //             }).toList(),
            //           ),
            //         );
            //       } else if (snapshot.hasError) {
            //         return Text('Error: ${snapshot.error}');
            //       } else {
            //         return Align(
            //           alignment: FractionalOffset.bottomCenter,
            //           child: CircularProgressIndicator(),
            //         ); // Or any other loading indicator
            //       }
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void _selectFromDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _fromDateController.text = picked.toString();
      });

      // Call getFromDate with the selected date
      getFromDate(picked.toString());
    }
  }

  void _selectToDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _toDateController.text = picked.toString();
      });

      // Call getFromDate with the selected date
      getToDate(picked.toString());
    }
  }
}

class DTables extends StatefulWidget {
  const DTables({super.key});

  @override
  State<DTables> createState() => _DTablesState();
}

class _DTablesState extends State<DTables> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black, // Set background color
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("MyStudents")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Student Name')),
                          DataColumn(label: Text('Student ID')),
                          DataColumn(label: Text('Student Dept')),
                          DataColumn(label: Text('Book ID')),
                          DataColumn(label: Text('Author')),
                          DataColumn(label: Text('Book Title')),
                          DataColumn(label: Text('Verified By')),
                          DataColumn(label: Text('From Date')),
                          DataColumn(label: Text('To Date')),
                        ],
                        rows: snapshot.data!.docs
                            .map<DataRow>((documentSnapshot) {
                          final data =
                              documentSnapshot.data() as Map<String, dynamic>;
                          return DataRow(
                            cells: [
                              DataCell(Text(data['studentName'] ?? '')),
                              DataCell(
                                  Text(data['studentID']?.toString() ?? '')),
                              DataCell(Text(data['studentDept'] ?? '')),
                              DataCell(Text(data['bookID']?.toString() ?? '')),
                              DataCell(Text(data['author'] ?? '')),
                              DataCell(Text(data['bookTitle'] ?? '')),
                              DataCell(Text(data['verifiedBy'] ?? '')),
                              DataCell(Text(data['fromDate'] ?? '')),
                              DataCell(Text(data['toDate'] ?? '')),
                            ],
                          );
                        }).toList(),
                      ),
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
      ),
    );
  }
}
