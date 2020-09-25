// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
    title: json['title'] as String,
    image: json['image'] as String,
    source: json['source'] as String,
    details: json['details'] as String,
    link: json['link'] as String,
    datetime: json['datetime'] as String,
  );
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
      'source': instance.source,
      'details': instance.details,
      'link': instance.link,
      'datetime': instance.datetime,
    };
