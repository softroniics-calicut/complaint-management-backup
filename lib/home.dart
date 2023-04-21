import 'dart:convert';

import 'package:complaint_management/view-complaint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

Future<dynamic> getData() async {

 SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');

var data={
  "id":sp,
};
print(data);
  var res = await post(Uri.parse('http://192.168.0.106/Complaint management/api/view-complaints.php'),body: data);
  print(res.body);
  var result = jsonDecode(res.body);
  print(result);
  return result;
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 107, 162, 222),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snap) {
          if(!snap.hasData){
            return Center(child: CircularProgressIndicator(),);  
          }
          else if(snap.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: snap.data.length,
            itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return View(id:snap.data[index]['comp_id']);
                },));
              },
                title: Text(snap.data[index]['subject']),
                subtitle: Text(snap.data[index]['description']),
                trailing: Text(snap.data[index]['date']),
            );
          },);
        }
      ),
    );
  }
}