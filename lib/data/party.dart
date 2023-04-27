import 'package:soiree/data/ApiData.dart';
import 'package:soiree/data/prefParty.dart';

import 'imageParty.dart';

class Party extends ApiData{
   List<ImageParty>? imageParty;
   List<PrefParty>? prefParty;

   String? date;
   String? address;
   String? description;
   String? number_people;
   String? title;

   Party({this.imageParty, this.prefParty, this.date, this.address, this.description, this.number_people, this.title}) :super(collection: "party");
}