import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:level1/Home/HomeBloc.dart';
import 'package:level1/details/DetailsWidget.dart';
import 'package:level1/models/SearchItem.dart';
import 'package:level1/models/SearchResult.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HomeBloc bloc;

  @override
  void initState() {
    bloc = HomeBloc();

    super.initState();
  }

  @override
  void dispose() {
    bloc?.dispose();

    super.dispose();
  }

  Widget _textField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: bloc.searchEvent.add,
        decoration: InputDecoration(border: OutlineInputBorder(), hintText: "Texto para pesquisa aqui...", labelText: "Pesquisa"),
      ),
    );
  }

  Widget _items(SearchItem item) {
    return ListTile(
      leading: Hero(
        tag: item.url,
        child: CircleAvatar(
          backgroundImage: NetworkImage(item?.avatarUrl ?? "https://icon-library.net/images/no-photo-icon/no-photo-icon-5.jpg"),
        ),
      ),
      title: Text(item?.fullName ?? "Título"),
      subtitle: Text(item?.url ?? "url"),
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => DetailsWidget(
                    item: item,
                  ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub Search"),
      ),
      body: ListView(
        children: <Widget>[
          _textField(),
          StreamBuilder(
              stream: bloc.listItems,
              builder: (context, AsyncSnapshot<SearchResult> snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _items(snapshot.data.items[index]);
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              })
        ],
      ),
    );
  }
}
