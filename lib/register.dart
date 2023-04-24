import 'dart:convert';

import 'package:complaint_management/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'district.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

    final _formKey = GlobalKey<FormState>();

  var name = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var password = TextEditingController();

  Future<void> postData() async {
    var data = {
      "name": name.text,
      "email": email.text,
      "mobile": mobile.text,
      "password": password.text
    };

    var response = await post(
        Uri.parse(
            'http://192.168.0.106/Complaint management/api/register.php'),
        body: data);
    print(response.body);
    var res = jsonDecode(response.body);
    print(res);
   
      var message = res["message"];
     
      var id = res["login_id"];
       print(id);

      if (message == "Added") {
        SharedPreferences spref = await SharedPreferences.getInstance();
        spref.setString('log_id', id);

        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Address();
          },
        ));
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong !');
      }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Form(
        key: _formKey,
        
        child: ListView(
         
          children: [
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                 validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Name';
                          }
                          return null;
                        },
                controller: name,
                decoration: InputDecoration(
                    label: Text('Name'), border: OutlineInputBorder()),
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
                controller: email,
                decoration: InputDecoration(
                    label: Text('Email'), border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                 validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Mobile';
                          }
                          return null;
                        },
                controller: mobile,
                decoration: InputDecoration(
                    label: Text('Mobile'), border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                 validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                controller: password,
                decoration: InputDecoration(
                    label: Text('Password'), border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                    if (_formKey.currentState!.validate()) {
                      postData();
                    }
                    ;
                  },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromARGB(255, 107, 162, 222),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      )
                    ],
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
