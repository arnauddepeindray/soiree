import 'package:soiree/data/ApiData.dart';
import 'package:soiree/data/prefParty.dart';

import 'imageParty.dart';

class Party extends ApiData{
  final List<ImageParty>? imageParty;
  final List<PrefParty>? prefParty;

  final String? date;
  final String? address;
  final String? description;
  final String? number_people;
  final String? title;

  const Party({this.imageParty, this.prefParty, this.date, this.address, this.description, this.number_people, this.title}) :super(collection: "party");
}