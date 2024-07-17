// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pokedex_flutter/commom/loading_widget.dart';
import 'package:pokedex_flutter/commom/pokemon_card.dart';
import 'package:pokedex_flutter/pages/search_page.dart';
import 'package:pokedex_flutter/service/pokemon_repository.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Flutter Pokedex",
                  style: TextStyle(color: Colors.white, fontFamily: 'Pokemon'),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                  },
                  icon: const Icon(Icons.search_rounded),
                  color: Colors.white,
                )
              ],
            )),
        body: PokemonsList());
  }
}

class PokemonsList extends StatefulWidget {
  @override
  State<PokemonsList> createState() => _PokemonsListState();
}

class _PokemonsListState extends State<PokemonsList> {
  late PokemonRepository pokemonRepository;
  ValueNotifier<bool> loading = ValueNotifier(true);
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    pokemonRepository = PokemonRepository();
    loadPokemons();
    _scrollController = ScrollController();
    _scrollController.addListener(infinityScrolling);
  }

  loadPokemons() async {
    loading.value = true;
    await pokemonRepository.fetchPokemons();
    loading.value = false;
  }

  infinityScrolling() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !loading.value) {
      loadPokemons();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2 - 110;
    return AnimatedBuilder(
        animation: pokemonRepository,
        builder: (context, snapshot) {
          return Stack(
            children: [
              ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(10),
                separatorBuilder: (_, __) => Divider(
                  height: 5,
                  thickness: 2,
                  indent: width,
                  endIndent: width,
                  color: Theme.of(context).primaryColor,
                ),
                itemCount: pokemonRepository.pokemons.length,
                itemBuilder: (_, index) {
                  var pokemon = pokemonRepository.pokemons[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 260,
                        child: PokemonCard(pokemon: pokemon),
                      )
                    ],
                  );
                },
              ),
              loadingIndicatorWidget(loading),
            ],
          );
        });
  }
}
