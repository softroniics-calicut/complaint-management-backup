import 'dart:convert';

import 'package:complaint_management/district.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _formKey = GlobalKey<FormState>();
  var address = TextEditingController();
   Future<void> addData() async {
      SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    var data={
      "id":sp,
      "address":address.text,
    };
    print(data);
            
    var response = await post(Uri.parse('http://192.168.0.106/Complaint management/api/address.php'),body: data);
    var res = jsonDecode(response.body);
    if(res['message']=='updated'){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return District();
      },));
    }
   

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Address';
                          }
                          return null;
                        },
                controller: address,
                decoration: InputDecoration(border: OutlineInputBorder(),
                labelText: 'Address'),
                minLines:
                    6, // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                         onTap: () {
                            if (_formKey.currentState!.validate()) {
                              addData();
                            };
                          },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
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
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 107, 162, 222),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
