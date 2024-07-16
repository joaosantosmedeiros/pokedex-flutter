import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokedex_flutter/models/pokemon.dart';

class PokemonRepository extends ChangeNotifier {
  int _offset = 0;
  final List<Pokemon> _pokemons = [];

  List<Pokemon> get pokemons => _pokemons;

  fetchPokemons() async {
    var pokemonsUrlString = await http.read(Uri.parse(
        "https://pokeapi.co/api/v2/pokemon/?offset=$_offset&limit=10"));

    var pokemonsUrlJson = jsonDecode(pokemonsUrlString);

    List<String> pokemonsUrl = pokemonsUrlJson["results"]
        .map((pokemon) => pokemon['url'].toString())
        .toList()
        .cast<String>();


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
      _pokemons.add(pokemon);
    }
    _offset += 10;
    notifyListeners();
  }
}
