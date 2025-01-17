class TypeToColor {
  static List<int> convert(String type) {
    var types = {
      'normal': [168, 167, 122],
      'fire': [238, 129, 48],
      'water': [99, 144, 240],
      'electric': [247, 208, 44],
      'grass': [122, 199, 76],
      'ice': [150, 217, 214],
      'fighting': [194, 46, 40],
      'poison': [163, 62, 161],
      'ground': [226, 191, 101],
      'flying': [169, 143, 243],
      'psychic': [249, 85, 135],
      'bug': [166, 185, 26],
      'rock': [182, 161, 54],
      'ghost': [115, 87, 151],
      'dragon': [111, 53, 252],
      'dark': [112, 87, 70],
      'steel': [183, 183, 206],
      'fairy': [214, 133, 173],
    };

    return types.containsKey(type) ? types[type]! : [];
  }
}
