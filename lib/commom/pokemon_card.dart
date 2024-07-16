import 'package:flutter/material.dart';
import 'package:pokedex_flutter/models/pokemon.dart';
import 'package:pokedex_flutter/utils/type_to_color.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    var pokemonNumber =
        '#${'0' * (3 - pokemon.id.toString().length)}${pokemon.id}';
    var color = TypeToColor.convert(pokemon.types[0]);
    var colorsMapped = [
      (color[0] * 0.6).round(),
      (color[1] * 0.6).round(),
      (color[2] * 0.6).round()
    ];

    return Card(
        color: Color.fromARGB(255, color[0], color[1], color[2]),
        shadowColor: Theme.of(context).primaryColor,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      pokemon.name.replaceFirst(
                          pokemon.name[0], pokemon.name[0].toUpperCase()),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white)),
                  Text(
                    pokemonNumber,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, colorsMapped[0],
                            colorsMapped[1], colorsMapped[2])),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: pokemon.types
                      .map(
                        (type) => Container(
                          margin: const EdgeInsets.only(bottom: 3.0, top: 3.0),
                          padding: const EdgeInsets.only(
                              top: 2.0, right: 10.0, bottom: 2.0, left: 10.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(
                              255,
                              (TypeToColor.convert(type)[0] * 1.05).toInt(),
                              (TypeToColor.convert(type)[1] * 1.05).toInt(),
                              (TypeToColor.convert(type)[2] * 1.05).toInt(),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Text(
                            type,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Image.network(
                  pokemon.imageUrl,
                  width: 160.0,
                ),
              ],
            ),
            const SizedBox(height: 10)
          ],
        ));
  }
}
