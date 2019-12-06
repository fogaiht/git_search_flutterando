import 'package:flutter/material.dart';
import 'package:level1/models/SearchItem.dart';

class DetailsWidget extends StatefulWidget {
  final SearchItem item;

  const DetailsWidget({Key key, this.item}) : super(key: key);

  @override
  _DetailsWidgetState createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 20,
              ),
              Hero(
                tag: widget.item.url,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      NetworkImage(widget.item?.avatarUrl ?? "https://icon-library.net/images/no-photo-icon/no-photo-icon-5.jpg"),
                ),
              ),
              Container(
                height: 20,
              ),
              Text(
                widget.item.fullName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
              ),
              Container(
                height: 10,
              ),
              Text(
                widget.item.url,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
