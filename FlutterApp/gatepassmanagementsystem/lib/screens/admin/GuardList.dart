import 'package:gatepassmanagementsystem/screens/admin/listpage.dart';
import 'package:gatepassmanagementsystem/screens/admin/updatepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final Stream<QuerySnapshot> employeesStream =
  FirebaseFirestore.instance.collection('GuardLogin').snapshots();

  // For Deleting User
  CollectionReference employees =
  FirebaseFirestore.instance.collection('GuardLogin');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return employees
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        leading: IconButton(icon: Icon(Icons.arrow_back_rounded,color: Colors.white,),onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },),
        title:Text('Guard List', style:TextStyle(fontSize: 20, color: Colors.white) ,),
      ),
      body:ListEmployeePage(),
    );
  }
}
