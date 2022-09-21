import 'characters_api_resp_location.dart';
import 'characters_api_resp_origin.dart';

class CharacterModel {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  CharactersApiRespOriginModel origin;
  CharactersApiRespLocationModel location;
  String image;
  List<dynamic> episode;
  String url;
  String created;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });
}
