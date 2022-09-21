import '../../models/characters/characters_api_resp.dart';

abstract class CharactersApiInterface {
  Future<CharactersApiRespModel> execute({required String path});
}
