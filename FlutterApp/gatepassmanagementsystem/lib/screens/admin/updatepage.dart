import 'package:gatepassmanagementsystem/screens/widgets/text_field_no_icon.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'GuardList.dart';
import 'home.dart';
class UpdateEmployeePage extends StatefulWidget {
  final String id;
  final String title;

  const UpdateEmployeePage({
    Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);

  @override
  _UpdateEmployeePageState createState() => _UpdateEmployeePageState();
}

class _UpdateEmployeePageState extends State<UpdateEmployeePage> {
  late UserCredential userCredential;
  final _formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> updateUser(id, name, email, number,password) {
    return FirebaseFirestore.instance.collection('GuardLogin')
        .doc(id)
        .update({
      'email': email,
      'username': name,
      'number' : number,
      'password':password,
      })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        leading: IconButton(icon: Icon(Icons.arrow_back_rounded,color: Colors.white,),onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewPage()),
          );
        },),
        title:Text(widget.title, style:TextStyle(fontSize: 20, color: Colors.white) ,),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('GuardLogin')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var name = data!['username'];
              var email = data['email'];
              var mobile = data['number'];
              var password = data['password'];

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: name,
                        autofocus: false,
                        onChanged: (value) => name = value,
                        decoration: InputDecoration(
                          labelText: 'Name: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.grey)
                          ),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: email,
                        autofocus: false,
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                          labelText: 'Email Address: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.grey)
                          ),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: mobile,
                        autofocus: false,
                        onChanged: (value) => mobile = value,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.grey)
                          ),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: password,
                        autofocus: false,
                        onChanged: (value) => password = value,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Password: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.grey)
                          ),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      child: Container(
                        height: 60,
                        width : 200,
                        child: RaisedButton(
                          color: Colors.red[900],
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              updateUser(widget.id, name, email, mobile,password);
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ViewPage()),);
                            }
                          },
                          child: Text("Update", style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
