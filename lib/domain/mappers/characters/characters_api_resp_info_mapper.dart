import '../../models/characters/characters_api_resp_info.dart';

class CharactersApiRespInfoMapper {
  Map<String, dynamic> data;

  CharactersApiRespInfoMapper(this.data);

  CharactersApiRespInfoModel execute() => CharactersApiRespInfoModel(
        next: data['next'],
        prev: data['prev'],
        pages: data['pages'],
        count: data['count'],
      );
}
