import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  Future<dynamic> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');

    var data = {
      "id": sp,
    };

    var res = await post(Uri.parse(
        'http://192.168.0.106/Complaint management/api/view-reviews.php'));
    print(res.body);
    var result = jsonDecode(res.body);

    return result;
  }

  var feed = TextEditingController();

  Future<void> addData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    var data = {
      "id": sp,
      "feedback": feed.text,
    };
    var response =
        await post(Uri.parse('${Con.url}add-review.php'), body: data);
    print(response.body);
    Fluttertoast.showToast(msg: 'Feedback added');
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Review();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 107, 162, 222),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(

              
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snap.data[index]['review'].toString()),
                  subtitle: Text(snap.data[index]['name'].toString()),
                  trailing: Text(snap.data[index]['date'].toString()),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Add your feedback'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: feed,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 170,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              addData();
                            },
                            child: Icon(Icons.send),
                            backgroundColor: Color.fromARGB(255, 107, 162, 222),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 107, 162, 222),
      ),
    );
  }
}
