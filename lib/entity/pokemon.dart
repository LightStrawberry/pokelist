import 'package:json_annotation/json_annotation.dart'; 
  
part 'pokemon.g.dart';


@JsonSerializable()
  class Pokemon extends Object {

  @JsonKey(name: 'name')
  Name name;

  @JsonKey(name: 'type')
  List<String> type;

  @JsonKey(name: 'base')
  Base base;

  @JsonKey(name: 'species')
  String species;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'profile')
  Profile profile;

  @JsonKey(name: 'color')
  String color;

  Pokemon(this.name,this.type,this.base,this.species,this.description,this.profile,this.color,);

  factory Pokemon.fromJson(Map<String, dynamic> srcJson) => _$PokemonFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PokemonToJson(this);

}

  
@JsonSerializable()
  class Name extends Object {

  @JsonKey(name: 'english')
  String english;

  @JsonKey(name: 'japanese')
  String japanese;

  @JsonKey(name: 'chinese')
  String chinese;

  Name(this.english,this.japanese,this.chinese,);

  factory Name.fromJson(Map<String, dynamic> srcJson) => _$NameFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NameToJson(this);

}

  
@JsonSerializable()
  class Base extends Object {

  @JsonKey(name: 'HP')
  int hP;

  @JsonKey(name: 'Attack')
  int attack;

  @JsonKey(name: 'Defense')
  int defense;

  @JsonKey(name: 'Speed')
  int speed;

  @JsonKey(name: 'SpAttack')
  int spAttack;

  @JsonKey(name: 'SpDefense')
  int spDefense;

  Base(this.hP,this.attack,this.defense,this.speed,this.spAttack,this.spDefense,);

  factory Base.fromJson(Map<String, dynamic> srcJson) => _$BaseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BaseToJson(this);

}

  
@JsonSerializable()
  class Profile extends Object {

  @JsonKey(name: 'Height')
  String height;

  @JsonKey(name: 'Weight')
  String weight;

  @JsonKey(name: 'Abilities')
  String abilities;

  @JsonKey(name: 'EVs')
  String eVs;

  @JsonKey(name: 'CatchRate')
  String catchRate;

  @JsonKey(name: 'GenderRatio')
  String genderRatio;

  @JsonKey(name: 'EggGroups')
  String eggGroups;

  @JsonKey(name: 'HatchSteps')
  String hatchSteps;

  Profile(this.height,this.weight,this.abilities,this.eVs,this.catchRate,this.genderRatio,this.eggGroups,this.hatchSteps,);

  factory Profile.fromJson(Map<String, dynamic> srcJson) => _$ProfileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

}