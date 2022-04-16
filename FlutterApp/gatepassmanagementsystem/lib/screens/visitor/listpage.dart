import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gatepassmanagementsystem/screens/visitor/updatepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListEmployeePage extends StatefulWidget {
  final String uid;
  ListEmployeePage({Key? key, required this.uid}) : super(key: key);

  @override
  _ListEmployeePageState createState() => _ListEmployeePageState();
}

class _ListEmployeePageState extends State<ListEmployeePage> {
  final Stream<QuerySnapshot> employeestream =
  FirebaseFirestore.instance.collection('appointmentVisitor').snapshots();
  // For Deleting User
  CollectionReference employee =
  FirebaseFirestore.instance.collection('appointmentVisitor');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: employeestream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          if(snapshot.hasData){
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    1: FixedColumnWidth(140),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Time',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                '',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (var i = 0; i < storedocs.length; i++) ...[
                     TableRow(
                        children: [
                          TableCell(
                            child: Center(
                                child:
                                Text(storedocs[i]['date'],
                                    style: TextStyle(fontSize: 18.0))
                                    ),
                          ),
                          TableCell(
                            child: Center(
                                child: Text(storedocs[i]['time'],
                                    style: TextStyle(fontSize: 18.0))),
                          ),
                          TableCell(
                                child: IconButton(
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateEmployeePage(
                                          id: storedocs[i]['id'],
                                          title: storedocs[i]['uid'],
                                          userid: widget.uid,
                                        ),
                                      ),
                                    )
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }
}