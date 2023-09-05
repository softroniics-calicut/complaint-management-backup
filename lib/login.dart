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

   final _formKey = GlobalKey<FormState>();

  var user = TextEditingController();
  var pass = TextEditingController();

  // Future<void> getData() async {
    // var data ={
    //   "user":user.text,
    //   "pass":pass.text
    // };
    // var response = await post(Uri.parse('${Con.url}login.php'),body: data);
    // print(response.body);
    // var res = jsonDecode(response.body);
    // print(res);
    // if(res['message']=='login'){

    //    var id = res["login_id"];
      
  //     final spref = await SharedPreferences.getInstance();
  //     spref.setString('log_id', id);
      

  //     Fluttertoast.showToast(msg: 'Successfully login');
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return MyNavigationBar();
  //     },));
  //   }
  //   else{
  //     Fluttertoast.showToast(msg: 'Invalid username or password');
  //   }

  // }
  Future<void> getData() async {
          final spref = await SharedPreferences.getInstance();
            spref.setString('log_id', 'a.text');
            spref.setString('name', 'qwref');
            spref.setString('email', 'fhf@');
           


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
         
          children: [
            Lottie.asset('assets/images/login.json'),
            Padding(
              
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Username';
                          }
                          return null;
                        },
                controller: user,
                decoration: InputDecoration(
                  label: Text('Email'),
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          }
                          return null;
                        },
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
                  if (_formKey.currentState!.validate()) {
                    getData();
                  };
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
      ),
    );
  }
}