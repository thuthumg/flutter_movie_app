
import 'package:json_annotation/json_annotation.dart';

part 'spoken_language_vo.g.dart';

@JsonSerializable()
class SpokenLanguageVO{
  @JsonKey(name: "english_name")
  String? englishName;

  @JsonKey(name: "iso_639_1")
  String? ios6391;

  @JsonKey(name: "name")
  String? name;

  SpokenLanguageVO(this.englishName, this.ios6391, this.name);

  factory SpokenLanguageVO.fromJson(Map<String,dynamic> json) =>_$SpokenLanguageVOFromJson(json);
  Map<String,dynamic> toJson()=> _$SpokenLanguageVOToJson(this);
}