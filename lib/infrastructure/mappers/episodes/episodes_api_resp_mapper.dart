import '../../../domain/models/episodes/episodes_api_resp.dart';
import 'episodes_api_resp_info_mapper.dart';

class EpisodesApiRespMapper {
  Map<String, dynamic> data;

  EpisodesApiRespMapper(this.data);

  EpisodesApiRespModel execute() => EpisodesApiRespModel(
        info: EpisodesApiRespInfoMapper(data['info']).execute(),
        results: data['results'],
      );
}
