import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'final.dart';

class Village extends StatefulWidget {
   Village({super.key, required this.id});
  String id;

  @override
  State<Village> createState() => _VillageState();
}

class _VillageState extends State<Village> {
  late String dropdownValue;
  

  Future<List<Map<String, String>>> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print(sp);

    var data = {
      "taluk": widget.id,
    };

    print('selected >>>>>>>>>>>>>>>>>>>>>>>>>>>$data');
    var res = await post(Uri.parse('${Con.url}view-village.php'), body: data);
    // print('response>>>>>>>>${res.body}');

    var a = (jsonDecode(res.body) as List<dynamic>)
        .map((e) => {'id': '${e['id']}', 'value': '${e['village']}'})
        .toList();
    // print('.......................$a');
    var rs = jsonDecode(res.body);
    print(res.body);

    // Set the dropdown value to the first item in the list
    dropdownValue = '${a[0]['id']}_${a[0]['value']}';
    print('dropdown value $dropdownValue');

    return a;
  }

  late String selectedValue;

  Future<void> addData() async {
      setState(() {
        selectedValue = dropdownValue.split('_')[1];
      });
      print('select***************************$selectedValue');
      SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print(sp);

    var data={
      "id":sp,
      "village":selectedValue,
    };
    print(data);
            
    var response = await post(Uri.parse('http://192.168.0.106/Complaint management/api/village.php'),body: data);
    var res = jsonDecode(response.body);
    if(res['message']=='updated'){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Final();
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

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(snap.data.toString()),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: DropdownButtonFormField(
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
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
                        addData();
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
            );
          }
        },
      ),
    );
  }
}