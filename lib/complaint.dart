import 'dart:convert';
import 'dart:io';

import 'package:complaint_management/home.dart';
import 'package:complaint_management/navbar.dart';
import 'package:complaint_management/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class Complaint extends StatefulWidget {
  const Complaint({super.key});

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  final _formKey = GlobalKey<FormState>();

  late String dropdownValue;
  var subject = TextEditingController();
  var description = TextEditingController();

  Future<List<Map<String, String>>> getData() async {
    var res = await get(Uri.parse('${Con.url}view-department.php'));

    var a = (jsonDecode(res.body) as List<dynamic>)
        .map((e) => {'id': '${e['id']}', 'value': '${e['dept_name']}'})
        .toList();
    print('a.......................$a');
    var rs = jsonDecode(res.body);
    print(res.body);

    // Set the dropdown value to the first item in the list
    dropdownValue = '${a[0]['id']}_${a[0]['value']}';

    var drop = dropdownValue.split('_')[1];
    print('----------------------$drop');

    return a;
  }

  XFile? pickedFile;
  File? image;

  File? pickedImage;

  addComplaint(BuildContext context) async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    if (pickedImage != null) {
      final data = await Services.postWithIamge(
          endPoint: 'add-complaint.php',
          params: {
            'id': sp,
            'dept': dropdownValue.split('_')[1],
            'subject': subject.text,
            'description': description.text,
          },
          image: pickedImage!,
          imageParameter: 'pic');

      if ((data as Map)['result'] == 'done') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => MyNavigationBar(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: 'Complaint registered');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return MyNavigationBar();
          },
        ));
      }
    } else {
      Fluttertoast.showToast(msg: 'Pick image ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 107, 162, 222),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<DropdownMenuItem<String>> dropdownItems =
                snapshot.data!.asMap().entries.map((entry) {
              return DropdownMenuItem(
                value: '${entry.value['id']}_${entry.value['value']}',
                child: Text('${entry.value['value']}'),
              );
            }).toList();
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upload Image',
                            style: TextStyle(fontSize: 15),
                          ),
                          FloatingActionButton(
                            onPressed: () async {
                              File? temp = await Services.pickImage(context);
                              setState(() {
                                pickedImage = temp;
                              });
                              print(pickedImage!.path);
                            },
                            child: Icon(Icons.camera_alt),
                          ),
                          // image == null ? Text('no image') : Image.file(image!),
                        ],
                      ),
                    ),
                    Text(
                      '*Must upload a image',
                      style: TextStyle(color: Colors.red),
                    ),
                    // Text(snap.data.toString()),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: DropdownButtonFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Username';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Department'),
                        value: dropdownValue, // Set the value to dropdownValue
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: dropdownItems,
                        onChanged: (String? newValue) {
                          dropdownValue = newValue!;

                          // print(dropdownValue.split('_')[1]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Complaint Subject';
                          }
                          return null;
                        },
                        controller: subject,
                        decoration: InputDecoration(
                            labelText: 'Subject', border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Complaint description';
                          }
                          return null;
                        },
                        controller: description,
                        minLines: 6,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder()),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              addComplaint(context);
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
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                  )
                                ],
                              )),
                              height: 50,
                              width: 320,
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
        },
      ),
    );
  }
}
