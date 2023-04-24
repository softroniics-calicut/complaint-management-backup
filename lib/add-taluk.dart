import 'dart:convert';

import 'package:complaint_management/village.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class Taluk extends StatefulWidget {
  Taluk({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<Taluk> createState() => _TalukState();
}

class _TalukState extends State<Taluk> {
  late String dropdownValue;
  

  Future<List<Map<String, String>>> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print(sp);

    var data = {
      "district": widget.id,
    };

    print(data);
    var res = await post(Uri.parse('${Con.url}view-taluk.php'), body: data);

    var a = (jsonDecode(res.body) as List<dynamic>)
        .map((e) => {'id': '${e['id']}', 'value': '${e['taluk']}'})
        .toList();
    print('a.......................$a');
    var rs = jsonDecode(res.body);
    print(res.body);

    // Set the dropdown value to the first item in the list
    dropdownValue = '${a[0]['id']}_${a[0]['value']}';

    return a;
  }


  late String selectedValue;
final _formKey = GlobalKey<FormState>();
  Future<void> addData() async {
      setState(() {
        selectedValue = dropdownValue.split('_')[1];
      });
      print('slect>>>>>>>>>>>>>$selectedValue');
      SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print(sp);

    var data={
      "id":sp,
      "taluk":selectedValue,
    };
    print(data);
            
    var response = await post(Uri.parse('http://192.168.0.106/Complaint management/api/taluk.php'),body: data);
    print(response.body);
    var res = jsonDecode(response.body);
   if(res['message']=='updated'){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Village(id:selectedValue);
      },));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<DropdownMenuItem<String>> dropdownItems =
                snap.data!.asMap().entries.map((entry) {
              return DropdownMenuItem(
                value: '${entry.value['id']}_${entry.value['value']}',
                child: Text('${entry.value['value']}'),
              );
            }).toList();

            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(snap.data.toString()),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: DropdownButtonFormField(
                      validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your Taluk';
                          }
                          return null;
                        },
                      decoration:
                          const InputDecoration(border: OutlineInputBorder(),labelText: 'Select your Taluk'),
                      value: dropdownValue, // Set the value to dropdownValue
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: dropdownItems,
                      onChanged: (String? newValue) {
                        
                           dropdownValue = newValue!;
                     
                       
                        print(dropdownValue.split('_')[1]);
            
            
                      },
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
            );
          }
        },
      ),
    );
  }
}
