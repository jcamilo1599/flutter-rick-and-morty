import 'package:flutter/material.dart';

import '../../../domain/models/characters/character.dart';
import '../../pages/detail_characters/detail_characters.dart';

class CardWidget extends StatelessWidget {
  final CharacterModel character;

  const CardWidget({
    required this.character,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        character.name,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Estado: ${character.status}',
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Especie: ${character.species}',
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(character.image),
      ),
      trailing: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                CharactersDetailPage(character: character),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text('Detalle'),
            Icon(Icons.arrow_right_rounded)
          ],
        ),
      ),
    );
  }
}
