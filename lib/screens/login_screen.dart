import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/components/rounded_button.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id='/login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  
  
  Widget build(BuildContext context) {
    String id,password;
  bool spinnerEnabled=false;
  final FirebaseAuth _auth=FirebaseAuth.instance;
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
                decoration:  kTextFieldDecoration.copyWith(hintText:'Enter your email' ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
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
              RoundButton(title:'Log In',color:Colors.blueAccent,
                  onpress:() async{
                setState(() {
                  spinnerEnabled=true;
                });

                try{
                final  user=await _auth.signInWithEmailAndPassword(email: id, password: password);
                  if(user!=null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    spinnerEnabled=false;
                  });


                }catch(e){
                  print(e);
                }


              }),
            ],
          ),
        ), inAsyncCall: spinnerEnabled,
      ),
    );
  }
}
