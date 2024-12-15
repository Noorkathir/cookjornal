import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    const url = "https://www.themealdb.com/api/json/v1/1/categories.php";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return List<Map<String, dynamic>>.from(data['categories']);
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<List<Map<String, dynamic>>> fetchMeals(String category) async {
    final url =
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return List<Map<String, dynamic>>.from(data['meals']);
    } else {
      throw Exception("Failed to load meals");
    }
  }
}