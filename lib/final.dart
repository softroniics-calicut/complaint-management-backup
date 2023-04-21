import 'package:complaint_management/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class Final extends StatefulWidget {
  const Final({super.key});

  @override
  State<Final> createState() => _FinalState();
}

class _FinalState extends State<Final> {
  @override
   void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds:3)).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      },));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
            height: 500,
              width: 500,
              child: Lottie.asset('assets/images/success.json')
          ),
        ),
    );
  }
}