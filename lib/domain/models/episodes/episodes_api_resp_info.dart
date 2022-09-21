class EpisodesApiRespInfoModel {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  EpisodesApiRespInfoModel({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });
}
