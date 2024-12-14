import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'verse.g.dart';
@HiveType(typeId: 1) 
class Verse{
  @HiveField(0) 
  final String book;
  @HiveField(1) 
  final int chapter;
  @HiveField(2) 
  final int verse;
  @HiveField(3) 
  final String text;
  
  Verse({
    required this.book,
    required this.chapter,
    required this.verse,
    required this.text
  });
}