import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class View extends StatefulWidget {
  View({super.key, required this.id});
  String id;

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 107, 162, 222),),
      body: Column(
        children: [
          Text('jhc'),
           Text('jhc'),
            Text('jhc')
        ],
      ),
    );
  }
}