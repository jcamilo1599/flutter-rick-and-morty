class CharactersApiRespInfoModel {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  CharactersApiRespInfoModel({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });
}
