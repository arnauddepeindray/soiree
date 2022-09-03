import 'package:soiree/data/ApiData.dart';

class Categories extends ApiData {
  String? catName;
  bool select = false;
  bool get isSelect {
      return select;
  }

  void set isSelect(bool toSelect){
    select = toSelect;
  }

  Categories(this.catName, this.select) : super(collection: "preferences");

}