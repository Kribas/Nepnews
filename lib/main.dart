import 'package:flutter/material.dart';
import 'package:nepnews/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:nepnews/provider/bookmark_model.dart';

void main() {

  runApp(ChangeNotifierProvider(create: (context) => BookmarkBloc(),child: NepNews())
  );
}

class NepNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}



