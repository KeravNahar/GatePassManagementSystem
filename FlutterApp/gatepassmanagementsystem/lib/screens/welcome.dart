import 'package:flutter/material.dart';
import 'package:gatepassmanagementsystem/screens/admin/adminlogin.dart';
import 'package:gatepassmanagementsystem/screens/visitor/visitorlogin.dart';
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top:150),
                  child: Center(
                    child: Image.asset("images/logo.png"),
                  ),
                )
            )),
            Expanded(child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Welcome to GPMS", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[900])),
                    Column(
                      children: [
                        Text("GatePass Management System"),
                        Text("For pre-scheduling Visitations."),
                      ],
                    ),

                    Container(
                      height: 60,
                      width: 300,
                      child: RaisedButton(
                        color: Colors.red[900],
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage()),);
                        },
                        child: Text("Admin", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                    ),

                    //button("Register", Colors.white, Colors.blue),
                    Container(
                      height: 60,
                      width: 300,
                      child: RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VisitorLoginPage()),);
                        },
                        child: Text("Visitor", style: TextStyle(color: Colors.red[900],fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                    ),
                  ],
                )))
          ],
        )
    );
  }
}