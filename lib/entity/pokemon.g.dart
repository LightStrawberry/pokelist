// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  print(json);
  return Pokemon(
      json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      (json['type'] as List)?.map((e) => e as String)?.toList(),
      json['base'] == null
          ? null
          : Base.fromJson(json['base'] as Map<String, dynamic>),
      json['species'] as String,
      json['description'] as String,
      json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      json['color'] as String);
}

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'base': instance.base,
      'species': instance.species,
      'description': instance.description,
      'profile': instance.profile,
      'color': instance.color
    };

Name _$NameFromJson(Map<String, dynamic> json) {
  return Name(json['english'] as String, json['japanese'] as String,
      json['chinese'] as String);
}

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'english': instance.english,
      'japanese': instance.japanese,
      'chinese': instance.chinese
    };

Base _$BaseFromJson(Map<String, dynamic> json) {
  return Base(json['HP'] as int, json['Attack'] as int, json['Defense'] as int,
      json['Speed'] as int, json['SpAttack'] as int, json['SpDefense'] as int);
}

Map<String, dynamic> _$BaseToJson(Base instance) => <String, dynamic>{
      'HP': instance.hP,
      'Attack': instance.attack,
      'Defense': instance.defense,
      'Speed': instance.speed,
      'SpAttack': instance.spAttack,
      'SpDefense': instance.spDefense
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
      json['Height'] as String,
      json['Weight'] as String,
      json['Abilities'] as String,
      json['EVs'] as String,
      json['CatchRate'] as String,
      json['GenderRatio'] as String,
      json['EggGroups'] as String,
      json['HatchSteps'] as String);
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'Height': instance.height,
      'Weight': instance.weight,
      'Abilities': instance.abilities,
      'EVs': instance.eVs,
      'CatchRate': instance.catchRate,
      'GenderRatio': instance.genderRatio,
      'EggGroups': instance.eggGroups,
      'HatchSteps': instance.hatchSteps
    };
