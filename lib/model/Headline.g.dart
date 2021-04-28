// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Headline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Headline _$HeadlineFromJson(Map<String, dynamic> json) {
  return Headline(
    json['status'] as String?,
    json['totalResults'] as int?,
    (json['articles'] as List<dynamic>?)
        ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HeadlineToJson(Headline instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('totalResults', instance.totalResults);
  writeNotNull('articles', instance.articles?.map((e) => e.toJson()).toList());
  return val;
}

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['source'] == null
        ? null
        : Source.fromJson(json['source'] as Map<String, dynamic>),
    json['author'] as String?,
    json['title'] as String?,
    json['description'] as String?,
    json['url'] as String?,
    json['urlToImage'] as String?,
    json['publishedAt'] as String?,
    json['content'] as String?,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source', instance.source?.toJson());
  writeNotNull('author', instance.author);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('url', instance.url);
  writeNotNull('urlToImage', instance.urlToImage);
  writeNotNull('publishedAt', instance.publishedAt);
  writeNotNull('content', instance.content);
  return val;
}

Source _$SourceFromJson(Map<String, dynamic> json) {
  return Source(
    json['id'] as String?,
    json['name'] as String?,
  );
}

Map<String, dynamic> _$SourceToJson(Source instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  return val;
}
