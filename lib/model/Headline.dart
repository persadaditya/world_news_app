
import 'package:json_annotation/json_annotation.dart';
part 'Headline.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class Headline{
  String? status;
  int? totalResults;
  List<Article>? articles;

  Headline(this.status,this.totalResults, this.articles);

  factory Headline.fromJson(Map<String, dynamic> json) => _$HeadlineFromJson(json);
  Map<String, dynamic> toJson() => _$HeadlineToJson(this);

}

@JsonSerializable(explicitToJson: true, nullable: true)
class Article{
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article(this.source, this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt, this.content);

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

}

@JsonSerializable(nullable: true)
class Source{
  String? id;
  String? name;

  Source(this.id, this.name);

  factory Source.fromJson(Map<String, dynamic> json) =>
      _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);

}