import 'package:gatepassmanagementsystem/screens/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gatepassmanagementsystem/screens/visitor/addAppointment.dart';
import 'package:gatepassmanagementsystem/screens/visitor/appointmentList.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
    backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        leading: IconButton(icon: Icon(Icons.exit_to_app_rounded,color: Colors.white,),onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomePage()),
          );
        },),
        title:Text('Visitor Appointment Scheduler', style:TextStyle(fontSize: 20, color: Colors.white) ,),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Center(
              child: Image.asset("images/logo.png"),
            ),
            SizedBox(height: 60,),
            Container(
              height: 60,
              width : 250,
              child: RaisedButton(
                color: Colors.red[900],
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(30)
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>AddPage(id: auth.currentUser!.uid,)),);
                },
                child: Text("Add New Appointment", style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            Container(
              height: 60,
              width : 250,
              child: RaisedButton(
                color: Colors.red[900],
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(30)
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewPage(id: auth.currentUser!.uid,)),);
                },
                child: Text("View Appointments List", style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
          ],),
      ),
    );
  }
}