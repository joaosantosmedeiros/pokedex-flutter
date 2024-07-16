// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pokedex_flutter/commom/pokemon_card.dart';
import 'package:pokedex_flutter/models/pokemon.dart';
import 'package:pokedex_flutter/service/data_service.dart';

void main() => runApp(const MyApp());

final dataService = DataService();

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
  late Future<List<Pokemon>> pokemons;

  @override
  void initState() {
    super.initState();
    pokemons = dataService.fetchPokemons(offset: 0);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: pokemons,
        builder: (context, snapshot) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            separatorBuilder: (_, __) => Divider(
              height: 5,
              thickness: 2,
              indent: 10,
              endIndent: 10,
              color: Theme.of(context).primaryColor,
            ),
            itemCount: snapshot.hasData ? (snapshot.data!.length + 1) : 10,
            itemBuilder: (_, index) {
              if (!snapshot.hasData) {
                return const SizedBox(
                  height: 100.0,
                  width: 50.0,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (index == snapshot.data!.length) {
                return const Center(child: LinearProgressIndicator());
              }

              var pokemon = snapshot.data![index];
              return PokemonCard(pokemon: pokemon);
            },
          );
        });
  }
}
