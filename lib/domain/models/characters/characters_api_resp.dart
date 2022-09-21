import 'character.dart';
import 'characters_api_resp_info.dart';

class CharactersApiRespModel {
  final CharactersApiRespInfoModel? info;
  final List<CharacterModel>? results;
  final String? message;

  CharactersApiRespModel({
    required this.info,
    required this.results,
    this.message,
  });
}
