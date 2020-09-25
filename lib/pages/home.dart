import 'package:flutter/material.dart';
import 'package:nepnews/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nepnews/pages/bookmarks_page.dart';
import 'package:provider/provider.dart';
import 'package:nepnews/provider/bookmark_model.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<List<News>> future;

  List<News> news;
  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    fetch();
    super.initState();
  }

  void fetch() async {
    future = News.browse();
    news = await future;
  }

  @override
  Widget build(BuildContext context) {

    var bookmarkBloc = Provider.of<BookmarkBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('NepNews'),
        actions: [
          Row(
            children: [
              Text(bookmarkBloc.count.toString()),
              IconButton(
                  icon: Icon(Icons.star),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Bookmarks()));
                  }),
            ],
          )
        ],
      ),
      body: FutureBuilder(
        future: future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.done:
              default:
                if(snapshot.hasError) return Text('There was an error ${snapshot.error}');
                var news = snapshot.data;

                return ListView.separated(
                    separatorBuilder: (context,index) => Divider(),
                    itemCount: news.length,
                    itemBuilder: (context,index) {
                      News _news = news[index];

                      return Material(
                        child: ListTile(
                          trailing: IconButton(
                              icon: Icon(FontAwesomeIcons.heart),
                              onPressed: () {
                                bookmarkBloc.addCount();

                                News news = News(
                                  image: _news.image,
                                  title: _news.title,
                                  details: _news.details,
                                  source: _news.source,
                                  link: _news.link
                                );

                                bookmarkBloc.addNews(news);

                              }),
                          onTap: () async {
                            String url = _news.link;

                            if(await canLaunch(url)) {
                              await launch(url,forceWebView: true);
                            }else {
                              throw 'Could not launch $url';
                            }
                          },

                          title: Image.network(_news.image),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_news.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                              Text(_news.details,style: TextStyle(fontSize: 20),),
                              Text("Source: ${_news.source}",style: TextStyle(fontSize: 15),),
                              Text("Read More>>",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      );

                    }
                );
            }
          }),
    );

  }


}
