import 'package:gatepassmanagementsystem/screens/admin/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gatepassmanagementsystem/screens/welcome.dart';
import 'package:gatepassmanagementsystem/screens/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}
class _AdminState extends State<AdminPage>{

  bool loading = false;
  late UserCredential userCredential;
  RegExp regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  loginAuth()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text
      );
      if (userCredential == null) {
        setState(() {
          SnackBar(content: Text("Email or password are invalid."));
          loading = false;
        });
      }
      else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        globalKey.currentState!.showSnackBar(
          SnackBar(content: Text("No user found for that email."),
          ),
        );
      } else if (e.code == 'wrong-password') {
        globalKey.currentState!.showSnackBar(
          SnackBar(content: Text("Wrong password provided for that user."),
          ),
        );
      }
    }
  }

  void validation() {
    if (email.text.trim()
        .isEmpty || email.text.trim() == null || password.text.trim()
        .isEmpty || password.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter valid Details"),
        ),
      );
      return;
    }
    if (email.text
        .trim()
        .isEmpty || email.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter a Email address"),
        ),
      );
      return;
    }
    else if (!regExp.hasMatch(email.text)) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter valid Email address"),
        ),
      );
      return;
    }
    if (password.text
        .trim()
        .isEmpty || password.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter a Password"),
        ),
      );
      return;
    }
    else{
      loginAuth();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_rounded,color: Colors.red[900],),onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomePage()),
          );
        },),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Login",style: TextStyle(color: Colors.red[900],
                fontSize: 30,
                fontWeight: FontWeight.bold),),
            Column(
              children: [
                WidTextField(
                  hintText: "Email Address",
                  icon: Icons.email_rounded,
                  obscureText: false,
                  controller: email,
                ),
                SizedBox(height: 30,),
                WidTextField(
                  hintText: "Password",
                  icon:Icons.remove_red_eye_rounded,
                  obscureText: true,
                  controller: password,
                ),
              ],
            ),
            Container(
              height: 60,
              width : 200,
              child: RaisedButton(
                color: Colors.red[900],
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(30)
                ),
                onPressed: () {
                  validation();
                },
                child: Text("Login", style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}