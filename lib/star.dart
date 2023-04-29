import 'package:complaint_management/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage({Key? key, required this.id}) : super(key: key);
  String id;
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double _rating = 3.0;
  int _starCount = 0;
  var review = TextEditingController();
  Future<void> addReview() async {
  SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    var data = {
      "id":sp,
      "cid":widget.id,
      "star": _starCount.toString(),
      "review": review.text};
    var response =
        await post(Uri.parse('${Con.url}add-review.php'), body: data);
    print(response.body);
    Fluttertoast.showToast(msg: 'Review added');
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return MyNavigationBar();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a Review'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _starCount = rating.toInt();
                  print(_starCount);
                });
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: review,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Write your review here...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                addReview();
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
