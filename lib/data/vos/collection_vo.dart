import 'package:json_annotation/json_annotation.dart';

part 'collection_vo.g.dart';

@JsonSerializable()
class CollectionVO{

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;


  @JsonKey(name: "backdrop_path")
  String? backdropPath;

  @JsonKey(name: "poster_path")
  String? posterPath;

  CollectionVO(this.id, this.name, this.backdropPath, this.posterPath);

  factory CollectionVO.fromJson(Map<String,dynamic> json) =>_$CollectionVOFromJson(json);
  Map<String,dynamic> toJson()=> _$CollectionVOToJson(this);
}