// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pokedex_flutter/commom/pokemon_card.dart';
import 'package:pokedex_flutter/service/pokemon_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
            "Flutter Pokedex",
            style: TextStyle(color: Colors.white, fontFamily: 'Pokemon'),
          ),
        ),
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
                  indent: 10,
                  endIndent: 10,
                  color: Theme.of(context).primaryColor,
                ),
                itemCount: pokemonRepository.pokemons.length,
                itemBuilder: (_, index) {
                  var pokemon = pokemonRepository.pokemons[index];
                  return PokemonCard(pokemon: pokemon);
                },
              ),
              loadingIndicatorWidget(),
            ],
          );
        });
  }

  loadingIndicatorWidget() {
    return ValueListenableBuilder(
        valueListenable: loading,
        builder: (context, bool isLoading, _) {
          return isLoading
              ? Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 20,
                  bottom: 24,
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircleAvatar(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ))
              : Container();
        });
  }
}
