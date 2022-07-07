import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/_.txt');
  }

  static Future<File> saveToFile(String data) async {
    final file = await getFile;
    return file.writeAsString(data);
  }

  static Future<String?> readFromFile() async {
    String? fileContents;
    try{
      final file = await getFile;
      fileContents = await file.readAsString();
    } catch (error) {
      print('File not found or corrupted.');
    }return fileContents;
  }

  static Future<FileSystemEntity> deleteFile() async {
    final file = await getFile;
    return file.delete();
  }
}