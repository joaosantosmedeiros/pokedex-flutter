// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pokedex_flutter/commom/loading_widget.dart';
import 'package:pokedex_flutter/commom/pokemon_card.dart';
import 'package:pokedex_flutter/service/pokemon_repository.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.red,
          title: const Text(
            "Flutter Pokedex",
            style: TextStyle(color: Colors.white, fontFamily: 'Pokemon'),
          ),
        ),
        body: SearchWidget());
  }
}

class SearchWidget extends StatefulWidget {
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final myController = TextEditingController();
  late PokemonRepository pokemonRepository;
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<bool> error = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    pokemonRepository = PokemonRepository();
  }

  searchPokemon(String pokemonName) async {
    loading.value = true;
    await pokemonRepository.fetchOnePokemon(pokemonName);
    loading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 30),
                width: width < 600 ? width - 50 : 600,
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                      hintText: 'Search for Pokemons',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            searchPokemon(myController.text.toLowerCase());
                          },
                          icon: const Icon(Icons.search))),
                ))
          ],
        ),
        Expanded(
            child: AnimatedBuilder(
                animation: pokemonRepository,
                builder: (context, snapshot) {
                  return Stack(
                    children: [
                      pokemonRepository.searchedPokemon.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 260,
                                  margin: const EdgeInsets.only(
                                      top: 30, bottom: 30),
                                  child: PokemonCard(
                                      pokemon:
                                          pokemonRepository.searchedPokemon[0]),
                                )
                              ],
                            )
                          : Container(
                              margin:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Nenhum pokemon foi encontrado.")
                                ],
                              ),
                            ),
                      loadingIndicatorWidget(loading)
                    ],
                  );
                }))
      ],
    );
  }
}
