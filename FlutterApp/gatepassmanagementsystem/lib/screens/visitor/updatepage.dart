import 'package:gatepassmanagementsystem/screens/widgets/text_field_no_icon.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'appointmentList.dart';
import 'home.dart';
class UpdateEmployeePage extends StatefulWidget {
  final String id;
  final String userid;
  final String title;

  const UpdateEmployeePage({
    Key? key,
    required this.id,
    required this.title,
    required this.userid
  }) : super(key: key);

  @override
  _UpdateEmployeePageState createState() => _UpdateEmployeePageState();
}

class _UpdateEmployeePageState extends State<UpdateEmployeePage> {
  late UserCredential userCredential;
  final _formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController nosvisitors = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        leading: IconButton(icon: Icon(Icons.arrow_back_rounded,color: Colors.white,),onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewPage(id: widget.userid,)),
          );
        },),
        title:Text(widget.title, style:TextStyle(fontSize: 20, color: Colors.white) ,),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('appointmentVisitor')
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
              var date = data!['date'];
              var time = data['time'];
              var reason = data['reason'];
              var nosvisitors = data['number of visitor'];

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: date,
                        enabled: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Date: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.grey)
                          ),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter date';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: time,
                        enabled: false,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Time:',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.grey)
                          ),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter time';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: reason,
                        enabled: false,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Reason of visit:',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.grey)
                          ),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter reason';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: nosvisitors,
                        enabled: false,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Number of visitors: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.grey)
                          ),
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Number of visitora';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              );
            },
          )),
    );
  }
}
