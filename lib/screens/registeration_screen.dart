import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id='/register_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String password;
  String id;
  bool spinnerEnabled=false;
//
//  Future<AuthResult> signInWithEmailAndPassword({
//    @required String email,
//    @required String password,
//  })

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 48.0,
                ),
              ),
              TextField(
                keyboardType:TextInputType.emailAddress ,
                textAlign: TextAlign.center,
                onChanged: (value) {

                  id=value;

                },
                decoration: kTextFieldDecoration.copyWith(hintText:'Enter your email' ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                 password=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText:'Enter your password.' ),
              ),
              Expanded(
                child: SizedBox(
                  height: 24.0,
                ),
              ),
          RoundButton(title:'Register',color:Colors.blueAccent,
              onpress:() async{
                try {
                  setState(() {
                    spinnerEnabled=true;
                  });
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email:
                      id, password: password);
                  if(newUser!=null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    spinnerEnabled=false;
                  });
                }catch(e){
                  print(e);
    }
              })
            ],
          ),
        ), inAsyncCall: spinnerEnabled,
      ),
    );
  }
}
