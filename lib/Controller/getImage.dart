// ignore_for_file: prefer_const_declarations

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_gallery/model/ImagesModel.dart';
class GetImages{

  static Future<ImagesModel> getImageList()async{
    final String url="https://pixabay.com/api/?key=17949085-90eaf118f2a719b7893f93643";
final response=await http.get(Uri.parse(url));
 if (response.statusCode==200) {
  
            return ImagesModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>) ;

      //return Document.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Document');
    }  }
}