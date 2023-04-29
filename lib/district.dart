import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add-taluk.dart';
import 'constants.dart';

class District extends StatefulWidget {
  const District({super.key});

  @override
  State<District> createState() => _DistrictState();
}

class _DistrictState extends State<District> {
  final _formKey = GlobalKey<FormState>();
  String dropdownvalue = 'Kozhikode';
  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print(sp);

    var data = {
      "id": sp,
      "district": dropdownvalue,
    };
    print(data);

    var response = await post(
        Uri.parse(
            '${Con.url}add-district.php'),
        body: data);
    print(response.body);
    var res = jsonDecode(response.body);
    if (res['message'] == 'updated') {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Taluk(id: dropdownvalue);
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu
    var items = [
      'Kozhikode',
      'Kannur',
      'Ernakulam',
      'Kollam',
      'Palakkad',
      'Thiruvananthapuram',
      'Wayanad',
      'Alappuzha',
      'Idukki',
      'Kasaragod',
      'Kottayam',
      'Malappuram',
      'Pathanamthitta',
      'Thrissur'
    ];

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: DropdownButtonFormField(
                 validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Select your district';
                            }
                            return null;
                          },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Your District'),
                // Initial Value
                value: dropdownvalue,
      
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
      
                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      getData();
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
