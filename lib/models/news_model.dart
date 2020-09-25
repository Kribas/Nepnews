import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;

part 'news_model.g.dart';

@JsonSerializable()
class News {
  String title;
  String image;
  String source;
  String details;
  String link;
  String datetime;
  bool status;

  News({this.title,this.image,this.source,this.details,this.link,this.datetime,this.status = false});

  factory News.fromJson(Map<String,dynamic> json) =>_$NewsFromJson(json);


  static Future<List<News>> browse() async {
    String url = 'https://neplinks.com/fetch/all?fbclid=IwAR2sRsKqcXufzll69p7v4Ns0hrO2xmpYgR5o0v6TDtsiwSIcU3PRNa38ht8';

    http.Response response  = await http.get(url);
    await Future.delayed(Duration(seconds: 1));

    List collection = jsonDecode(response.body);

    List<News> _news = collection.map((json) => News.fromJson(json)).toList();

    print(collection);
    return _news;

}

}