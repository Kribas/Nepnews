import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nepnews/provider/bookmark_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Bookmarks extends StatefulWidget {
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    var bookmarkBloc = Provider.of<BookmarkBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),

      body: ListView.builder(
        itemCount: bookmarkBloc.news.length,
          itemBuilder: (context,index) {
            return ListTile(
              onTap: () async {
                String url = bookmarkBloc.news[index].link;

                if(await canLaunch(url)) {
                  await launch(url,forceWebView: true);
                }else {
                  throw 'Could not launch $url';
                }
              },

              title: Image.network(bookmarkBloc.news[index].image),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bookmarkBloc.news[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  Text(bookmarkBloc.news[index].details,style: TextStyle(fontSize: 20),),
                  Text("Source: ${bookmarkBloc.news[index].source}",style: TextStyle(fontSize: 15),),
                  Text("Read More>>",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),
            );
          }),

    );
  }
}
