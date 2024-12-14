
import 'package:hive_flutter/hive_flutter.dart';
import '../models/verse.dart';

class Hivecrud {
  final String _boxName = "verseBox";

  Future<Box<Verse>> get _box async =>
        await Hive.openBox(_boxName);
    
  Future<void> addAllVerses(List<Verse> verses) async{
    var box = await _box;
    await box.addAll(verses);
  } 

  Future<List<Verse>> getAllVerses() async{
    var box = await _box;
    return  box.values.toList();
  }

  Future<Verse?> getLastVerse() async{
    var box = await _box;
    var index = getBoxLength() as int;
    return box.get(index-1);
  }
  Future<int> getBoxLength() async{
    var box = await _box;
    return box.length;
  }
}