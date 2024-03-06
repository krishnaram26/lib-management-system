// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class DTables extends StatefulWidget {
//   const DTables({super.key});

//   @override
//   State<DTables> createState() => _DTablesState();
// }

// class _DTablesState extends State<DTables> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Users",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.black, // Set background color
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, right: 8),
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection("MyStudents")
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         columns: [
//                           DataColumn(label: Text('Student Name')),
//                           DataColumn(label: Text('Student ID')),
//                           DataColumn(label: Text('Student Dept')),
//                           DataColumn(label: Text('Book ID')),
//                           DataColumn(label: Text('Author')),
//                           DataColumn(label: Text('Book Title')),
//                           DataColumn(label: Text('Verified By')),
//                           DataColumn(label: Text('From Date')),
//                           DataColumn(label: Text('To Date')),
//                         ],
//                         rows: snapshot.data!.docs
//                             .map<DataRow>((documentSnapshot) {
//                           final data =
//                               documentSnapshot.data() as Map<String, dynamic>;
//                           return DataRow(
//                             cells: [
//                               DataCell(Text(data['studentName'] ?? '')),
//                               DataCell(
//                                   Text(data['studentID']?.toString() ?? '')),
//                               DataCell(Text(data['studentDept'] ?? '')),
//                               DataCell(Text(data['bookID']?.toString() ?? '')),
//                               DataCell(Text(data['author'] ?? '')),
//                               DataCell(Text(data['bookTitle'] ?? '')),
//                               DataCell(Text(data['verifiedBy'] ?? '')),
//                               DataCell(Text(data['fromDate'] ?? '')),
//                               DataCell(Text(data['toDate'] ?? '')),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     );
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     return Align(
//                       alignment: FractionalOffset.bottomCenter,
//                       child: CircularProgressIndicator(),
//                     ); // Or any other loading indicator
//                   }
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
