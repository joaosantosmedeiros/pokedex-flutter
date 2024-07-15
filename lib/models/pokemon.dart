class Pokemon implements Comparable<Pokemon> {
  int id;
  String name;
  String imageUrl;
  List<String> types;
  List<String> abilities;
  num height;
  num weight;
  Map<String, int> stats;

  Pokemon(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.abilities,
      required this.height,
      required this.stats,
      required this.types,
      required this.weight});

  @override
  int compareTo(Pokemon other) {
    return id.compareTo(other.id);
  }

  @override
  bool operator ==(Object other) => other is Pokemon && other.id == id;

  @override
  int get hashCode =>
      Object.hash(id, name, imageUrl, abilities, height, stats, types, weight);
}

class Stat {
  String name;
  num points;

  Stat({required this.name, required this.points});
}
