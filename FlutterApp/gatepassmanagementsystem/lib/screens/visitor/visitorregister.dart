import 'package:gatepassmanagementsystem/screens/visitor/home.dart';
import 'package:flutter/material.dart';
import 'package:gatepassmanagementsystem/screens/welcome.dart';
import 'package:gatepassmanagementsystem/screens/visitor/visitorlogin.dart';
import 'package:gatepassmanagementsystem/screens/widgets/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late UserCredential userCredential;
  RegExp regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController uid = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController mobile = TextEditingController();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Future sendData()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text
      );
      await FirebaseFirestore.instance.collection('VisitorRegister').doc(userCredential.user!.uid).set({
        'email': email.text.trim(),
        'username': name.text.trim(),
        'userid': userCredential.user!.uid,
        'password' : password.text.trim(),
        'city': city.text.trim(),
        'mobile number': mobile.text.trim()
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        globalKey.currentState!.showSnackBar(SnackBar(content: Text("The password is too weak.")));
      } else if (e.code == 'email-already-in-use') {
        globalKey.currentState!.showSnackBar(SnackBar(content: Text("The account already exists for that email.")));
      }
    } catch (e) {
      globalKey.currentState!.showSnackBar(SnackBar(content: Text('error')
      )
      );
    }
  }

  void validation(){
    if(email.text.trim().isEmpty||email.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter a Email address"),
        ),
      );
      return;
    }
    if(name.text.trim().isEmpty||name.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter a Username"),
        ),
      );
      return;
    }
    if(password.text.trim().isEmpty||password.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter a Password"),
        ),
      );
      return;
    }
    if(mobile.text.trim().isEmpty||mobile.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter Mobile Number"),
        ),
      );
      return;
    }
    if(city.text.trim().isEmpty||city.text.trim() == null) {
      globalKey.currentState!.showSnackBar(
        SnackBar(content: Text("Enter City from"),
        ),
      );
      return;
    }
    else{
      sendData();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()),);
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
            Text("Sign Up",style: TextStyle(color: Colors.red[900],
                fontSize: 30,
                fontWeight: FontWeight.bold),),
            Column(
              children: [
                WidTextField(
                  hintText: "Enter Email Address",
                  icon: Icons.email_rounded,
                  obscureText: false,
                  controller: email,
                ),
                SizedBox(height: 30,),
                WidTextField(
                  hintText: "Enter Name",
                  icon: Icons.person,
                  controller: name,
                  obscureText: false,
                ),
                SizedBox(height: 30,),
                WidTextField(
                  hintText: "Enter Password",
                  icon:Icons.vpn_key_rounded,
                  obscureText: true,
                  controller: password,
                ),
                SizedBox(height: 30,),
                WidTextField(
                  hintText: "Enter Mobile Number",
                  icon :Icons.dock_rounded,
                  obscureText: false,
                  controller: mobile,
                ),
                SizedBox(height: 30,),
                WidTextField(
                  hintText: "Enter City name",
                  icon :Icons.dock_rounded,
                  obscureText: false,
                  controller: city,
                ),
              ],
            ),
            Container(
              height: 60,
              width : 200,
              child :RaisedButton(
                color: Colors.red[900],
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(30)
                ),
                onPressed: () {
                  sendData();
                  validation();
                },
                child: Text("Register", style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have a Account?", style: TextStyle(color: Colors.grey),),
                Container(
                  height: 25,
                  width : 120,
                  child :FlatButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VisitorLoginPage()),
                      );
                    },
                    child: Text("SignIn here.", style: TextStyle(color: Colors.red[900]),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}