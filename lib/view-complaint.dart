import 'dart:convert';

import 'package:complaint_management/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

class View extends StatefulWidget {
  View({super.key, required this.id});
  String id;

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  var sts;
  Future<dynamic> getData() async {
    var data = {"id": widget.id};
    print(data);
    var res = await post(
        Uri.parse(
            'http://192.168.0.106/Complaint management/api/view-comp.php'),
        body: data);
    var resp = res.body;
    var rs = jsonDecode(resp);
    print(rs);
    return rs;
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
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.data[0]['status']=="0"){
                return Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text(
                        snapshot.data[0]['subject'],
                        style: TextStyle(
                            color: Color.fromARGB(255, 4, 76, 135),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      snapshot.data[0]['date'],
                      style: TextStyle(
                          color: Color.fromARGB(255, 6, 62, 107),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                
                    Text(
                      snapshot.data[0]['description'],
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 15,
                      ),
                    ),
                        SizedBox(height: 30,),
              
                    
                    // sts=snapshot.data[0]['status'],
                    
                        
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green),
                        ),
                        Text('  Complaint Registered')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 194, 192, 192)),
                        ),
                        Text('  Complaint Noticed')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 194, 192, 192)),
                        ),
                        Text('  Complaint on Processing')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 194, 192, 192)),
                        ),
                        Text('  Complaint Solved')
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
              
                          // ElevatedButton(onPressed: (){
                          //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //     return Home();
                          //   },));
                          // }, child: Text('OK')),
                        ],
                      ),
                    )
                    
                  ],
                ),
              ),
            );
            }
            if(snapshot.data[0]['status']=="1"){
                return Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text(
                        snapshot.data[0]['subject'],
                        style: TextStyle(
                            color: Color.fromARGB(255, 4, 76, 135),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      snapshot.data[0]['date'],
                      style: TextStyle(
                          color: Color.fromARGB(255, 6, 62, 107),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                
                    Text(
                      snapshot.data[0]['description'],
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 15,
                      ),
                    ),
                        SizedBox(height: 30,),
              
                    
                    // sts=snapshot.data[0]['status'],
                    
                        
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green),
                        ),
                        Text('  Complaint Registered')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green),
                        ),
                        Text('  Complaint Noticed')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 194, 192, 192)),
                        ),
                        Text('  Complaint on Processing')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 194, 192, 192)),
                        ),
                        Text('  Complaint Solved')
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
              
                          // ElevatedButton(onPressed: (){
                          //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //     return Home();
                          //   },));
                          // }, child: Text('OK')),
                        ],
                      ),
                    )
                    
                  ],
                ),
              ),
            );
            }
             if(snapshot.data[0]['status']=="2"){
                return Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text(
                        snapshot.data[0]['subject'],
                        style: TextStyle(
                            color: Color.fromARGB(255, 4, 76, 135),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      snapshot.data[0]['date'],
                      style: TextStyle(
                          color: Color.fromARGB(255, 6, 62, 107),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                
                    Text(
                      snapshot.data[0]['description'],
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 15,
                      ),
                    ),
                        SizedBox(height: 30,),
              
                    
                    // sts=snapshot.data[0]['status'],
                    
                        
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green),
                        ),
                        Text('  Complaint Registered')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green),
                        ),
                        Text('  Complaint Noticed')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green),
                        ),
                        Text('  Complaint on Processing')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 194, 192, 192)),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 194, 192, 192)),
                        ),
                        Text('  Complaint Solved')
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
              
                          // ElevatedButton(onPressed: (){
                          //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //     return Home();
                          //   },));
                          // }, child: Text('OK')),
                        ],
                      ),
                    )
                    
                  ],
                ),
              ),
            );
            }
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text(
                        snapshot.data[0]['subject'],
                        style: TextStyle(
                            color: Color.fromARGB(255, 4, 76, 135),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      snapshot.data[0]['date'],
                      style: TextStyle(
                          color: Color.fromARGB(255, 6, 62, 107),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                
                    Text(
                      snapshot.data[0]['description'],
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 15,
                      ),
                    ),
                        SizedBox(height: 30,),
              
                    
                    // sts=snapshot.data[0]['status'],
                    
                        
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green),
                        ),
                        Text('  Complaint Registered')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green),
                        ),
                        Text('  Complaint Noticed')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green),
                        ),
                        Text('  Complaint on Processing')
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 80,
                            width: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                      Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green),
                              
                        ),
                        Text('  Complaint Solved')
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
              
                          // ElevatedButton(onPressed: (){
                          //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //     return Home();
                          //   },));
                          // }, child: Text('OK')),
                        ],
                      ),
                    )
                    
                  ],
                ),
              ),
            );
          }),
    );
  }
}
