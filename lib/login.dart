import 'dart:convert';

import 'package:complaint_management/navbar.dart';
import 'package:complaint_management/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var user = TextEditingController();
  var pass = TextEditingController();

  Future<void> getData() async {
    var data ={
      "user":user.text,
      "pass":pass.text
    };
    var response = await post(Uri.parse('http://192.168.0.106/Complaint management/api/login.php'),body: data);
    print(response.body);
    var res = jsonDecode(response.body);
    if(res['message']=='login'){

       var id = res["login_id"];
      
      final spref = await SharedPreferences.getInstance();
      spref.setString('log_id', id);
      

      Fluttertoast.showToast(msg: 'Successfully login');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyNavigationBar();
      },));
    }
    else{
      Fluttertoast.showToast(msg: 'Invalid username or password');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
       
        children: [
          Lottie.asset('assets/images/login.json'),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: user,
              decoration: InputDecoration(
                label: Text('Username'),
                border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: pass,
              decoration: InputDecoration(
                 label: Text('Password'),
                border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                getData();
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(255, 107, 162, 222),
                ),
                height: 50,
                width: double.infinity,
                child: Center(child: Text('Login')),
              ),
            ),
          ),
          InkWell(
             onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) {
                  return Register();
                },));
              },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Create new account?'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}