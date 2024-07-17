import 'package:flutter/material.dart';
import 'package:pokedex_flutter/models/pokemon.dart';
import 'package:pokedex_flutter/utils/type_to_color.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonDetail({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    var colors = TypeToColor.convert(pokemon.types[0]);
    Color mainColor = Color.fromARGB(255, colors[0], colors[1], colors[2]);
    String title = pokemon.name[0].toUpperCase() +
        pokemon.name.substring(1, pokemon.name.length);
    String pokemonNumber =
        '#${'0' * (3 - pokemon.id.toString().length)}${pokemon.id}';

    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(color: Colors.white, fontFamily: 'Pokemon'),
              ),
              Text(
                pokemonNumber,
                style:
                    const TextStyle(color: Colors.white, fontFamily: 'Pokemon'),
              ),
            ],
          )),
      body: Column(
        children: [
          // Imagem
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: mainColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Image.network(pokemon.imageUrl)],
                  ),
                ),
              ),
            ],
          ),
          // Tipos
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.types
                  .map(
                    (type) => Container(
                      margin: const EdgeInsets.only(right: 3.0, left: 3.0),
                      padding: const EdgeInsets.only(
                          top: 2.0, right: 10.0, bottom: 2.0, left: 10.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                          255,
                          TypeToColor.convert(type)[0],
                          TypeToColor.convert(type)[1],
                          TypeToColor.convert(type)[2],
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Text(
                        type[0].toUpperCase() + type.substring(1, type.length),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          // Peso, altura e habilidades
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Weight
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.balance_rounded,
                              color: Colors.grey,
                            ),
                            Text("${pokemon.weight}kg"),
                          ],
                        ),
                      ),
                      Text(
                        "Weight",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                // Height
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_upward_rounded,
                              color: Colors.grey,
                            ),
                            Text("${pokemon.height}m"),
                          ],
                        ),
                      ),
                      Text(
                        "Height",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                // Moves
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              pokemon.abilities.map((e) => Text(e)).toList(),
                        ),
                      ),
                      Text(
                        "Moves",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Status
          Container(
            child: Column(
              children: [
                Text(
                  "Base Status",
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                Column(
                  children: pokemon.stats.keys
                      .map((key) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 160,
                                  child: Text(
                                    "${key[0].toUpperCase()}${key.substring(1, key.length)}",
                                    style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(pokemon.stats[key].toString())
                              ]))
                      .toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
