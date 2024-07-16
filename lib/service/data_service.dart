import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokedex_flutter/models/pokemon.dart';

class DataService {
  Future<List<Pokemon>> fetchPokemons({required int offset}) async {
    var pokemonsUrlString = await http.read(Uri.parse(
        "https://pokeapi.co/api/v2/pokemon/?offset=$offset&limit=10"));

    var pokemonsUrlJson = jsonDecode(pokemonsUrlString);

    List<String> pokemonsUrl = pokemonsUrlJson["results"]
        .map((pokemon) => pokemon['url'].toString())
        .toList()
        .cast<String>();

    List<Pokemon> pokemons = [];

    for (var url in pokemonsUrl) {
      var rawPokemonString = await http.read(Uri.parse(url));
      var rawPokemon = json.decode(rawPokemonString);
      Pokemon pokemon = Pokemon(
          id: rawPokemon['id'],
          name: rawPokemon['name'],
          imageUrl: rawPokemon['sprites']['other']['official-artwork']
                  ['front_default']
              .toString(),
          abilities: rawPokemon['abilities']
              .map((ability) => ability['ability']['name'])
              .toList()
              .cast<String>(),
          stats: {
            for (var item in rawPokemon['stats'])
              item['stat']['name'].toString(): item['base_stat']
          },
          types: rawPokemon['types']
              .map((type) => type['type']['name'].toString())
              .toList()
              .cast<String>(),
          height: rawPokemon['height'] * 10 / 100,
          weight: (rawPokemon['weight']) / 10);
      pokemons.add(pokemon);
    }

    return pokemons;
  }
}
