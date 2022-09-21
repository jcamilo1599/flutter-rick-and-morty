import '../../models/episodes/episodes_api_resp_info.dart';

class EpisodesApiRespInfoMapper {
  Map<String, dynamic> data;

  EpisodesApiRespInfoMapper(this.data);

  EpisodesApiRespInfoModel execute() => EpisodesApiRespInfoModel(
        next: data['next'],
        prev: data['prev'],
        pages: data['pages'],
        count: data['count'],
      );
}
