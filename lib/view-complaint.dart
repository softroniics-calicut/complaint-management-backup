import 'dart:convert';

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

  Future<dynamic> getData() async {
    var data={
      "id":widget.id
    };
    print(data);
    var res = await post(Uri.parse('http://192.168.0.106/Complaint management/api/view-comp.php'),body: data);
    var resp = jsonDecode(res.body);
    print(resp);
    return resp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 107, 162, 222),),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.connectionState==ConnectionState.waiting){
             return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Text(snapshot.data[0]['subject']),
               Text('jhc'),
                Text('jhc')
            ],
          );
        }
      ),
    );
  }
}