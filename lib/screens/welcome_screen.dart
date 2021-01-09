
import 'package:flashchat/components/rounded_button.dart';
import 'package:flashchat/screens/registeration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


import 'login_screen.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id='/welcome_screen';

    @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController=AnimationController(vsync: this,duration: Duration(seconds: 1),);
    //Curved animation is like customizing the animation with different properties ,its like a top layer applied to already present animation
    //ps.curved animation must go from 0 to 1 only else exception
//    animation=CurvedAnimation(parent: animationController,curve: Curves.easeInOut);
    animationController.forward();

//Using tween animation tween or in-between anim.  can be used to move from one value to another in animation.Color tweeen can accept 2 colors and move between them .this again act as a layer over the animationController
    //.animate returns a animation object
    //colorTween value return color type value which can be used as color
    animation=ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(animationController);
    //to reverse animate use
    //animationController.reverse(from: 1.0);
    //to loop through the animation
//    animationController.addStatusListener((status){
//      if(status==AnimationStatus.completed){
//        animationController.reverse(from: 1.0);
//      }else if (status==AnimationStatus.dismissed) animationController.forward();
//    });

    animationController.addListener((){
     // print(animationController.value);
      setState(() {

      });
    }

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 100,
                  ),
                ),
        TypewriterAnimatedTextKit(
          speed: Duration(milliseconds:400 ),
            repeatForever: false,
            totalRepeatCount: 1,

            text: [
              'Flash Chat '
            ],
            textStyle:TextStyle(

                     fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                 ),
//            textAlign: TextAlign.start,
//            alignment: AlignmentDirectional.topStart // or Alignment.topLeft
        ),

//        TextLiquidFill(
//          text: 'LIQUIDY',
//          waveColor: Colors.blueAccent,
//          boxBackgroundColor: Colors.redAccent,
//          textStyle: TextStyle(
//            fontSize: 80.0,
//            fontWeight: FontWeight.bold,
//          ),
//
//        ),
//                Text(
//                  'Flash Chat ',
//                 // \n ${animationController.value.toInt()}%
//                style: TextStyle(
//                    fontSize: 45.0,
//                    fontWeight: FontWeight.w900,
//                  ),
//                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(title:'Log In',color:Colors.lightBlueAccent,onpress:() {
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            RoundButton(title:'Register',color:Colors.blueAccent,onpress:() {
              Navigator.pushNamed(context, RegistrationScreen.id);
            }),

          ],
        ),
      ),
    );

  }
}

