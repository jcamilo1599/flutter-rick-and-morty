import 'episodes_api_resp_info.dart';

class EpisodesApiRespModel {
  final EpisodesApiRespInfoModel? info;
  final List<dynamic>? results;
  final String? message;

  EpisodesApiRespModel({
    required this.info,
    required this.results,
    this.message,
  });
}
