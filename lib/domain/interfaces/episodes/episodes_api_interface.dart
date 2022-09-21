import '../../models/episodes/episodes_api_resp.dart';

abstract class EpisodesApiInterface {
  Future<EpisodesApiRespModel> execute();
}
