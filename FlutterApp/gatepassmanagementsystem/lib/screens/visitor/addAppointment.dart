import 'package:gatepassmanagementsystem/screens/widgets/text_field_no_icon.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
class AddPage extends StatefulWidget {
  final String id;
  const AddPage({Key? key,required this.id,}) : super(key: key);
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late UserCredential userCredential;
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController nosvisitors = TextEditingController();


  cleardata(){
    nosvisitors.clear();
    reason.clear();
    date.clear();
    time.clear();
  }

  Future sendData()async{
    await FirebaseFirestore.instance.collection('appointmentVisitor').doc().set({
      'uid': widget.id,
      'time': time.text.trim(),
      'date': date.text.trim(),
      'reason' : reason.text.trim(),
      'number of visitor':nosvisitors.text.trim(),
      'faculty' :'faculty email',
      'approval':'NO',
      'exit':'NO',
    });
    FirebaseFirestore.instance
        .collection('VisitorRegister')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
    FirebaseFirestore.instance.collection('Appointments').doc().set({
      'city': doc['city'],
      'email': doc['email'],
      'id':widget.id,
      'mobile': doc['mobile number'],
      'name': doc['username'],

      'datetime_oa': date.text.trim(),
      'reason' : reason.text.trim(),
      'nosvisitors':nosvisitors.text.trim(),
      'faculty' :'faculty email',
      'approval':'NO',
      'exit':'NO',
    });});
    });
    //send Mail
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
          title:Text('Add New Visit', style:TextStyle(fontSize: 20, color: Colors.white) ,),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidTextFieldNIC(
                hintText: "Date of arrival",
                obscureText: false,
                controller: date,
              ),
              WidTextFieldNIC(
                hintText: "Time of arrival",
                obscureText: false,
                controller: time,
              ),
              WidTextFieldNIC(
                hintText: "Reason of visitation",
                obscureText: false,
                controller: reason,
              ),
              WidTextFieldNIC(
                hintText: "Number of Visitors",
                obscureText: false,
                controller: nosvisitors,
              ),
              Row(
                children: [
                  Container(
                    height: 60,
                    width : 135,
                    child: RaisedButton(
                      color: Colors.red[900],
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      onPressed: () {
                        sendData();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()),);
                      },
                      child: Text("Schedule", style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: 60,
                    width : 135,
                    child: RaisedButton(
                      color: Colors.red[900],
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      onPressed: () {
                        cleardata();
                      },
                      child: Text("Reset", style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}
