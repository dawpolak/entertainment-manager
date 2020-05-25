import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiMovieService{
  static String _apiKey = 'useYourKey';
  static String _baseURL = 'http://www.omdbapi.com/?apikey=${_apiKey}';


  Future<dynamic> fetchMovieSuggestions(String title,{ String type}) async {
    final response = await http.get(_baseURL+'&s=${title}&type=${type}');

    if (response.statusCode == 200){
      return json.decode(response.body)['Search'];
    } else{

    }
  }
}