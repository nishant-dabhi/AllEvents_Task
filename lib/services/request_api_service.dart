import 'package:allevents_task/models/api_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Item>> fetchItems(String category) async {
  String url = 'https://allevents.s3.amazonaws.com/tests/$category.json';

  try {
    // Make the HTTP GET request
    final response = await http.get(Uri.parse(url));

    // Check if the response is successful
    if (response.statusCode == 200) {
      // Decode the JSON data
      final Map<String, dynamic> jsonData = json.decode(response.body);

      // Extract the list of items from the JSON
      List<dynamic> itemsJson = jsonData['item'] ?? [];

      // Convert JSON to List<Item> using fromJson factory
      List<Item> items = itemsJson.map((item) => Item.fromJson(item)).toList();

      return items;
    } else {
      // Print error if the status code is not 200
      print('Error: Failed to load data. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    // Print error if something goes wrong
    print('Error: $e');
    return [];
  }
}

class EventService {
  // Base API endpoint containing all category links
  static const String BASE_API_URL =
      'https://allevents.s3.amazonaws.com/tests/categories.json';

  // Fetch all category data sources
  static Future<Map<String, List<Item>>> fetchCategorySources() async {
    try {
      final response = await http.get(Uri.parse(BASE_API_URL));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);

        // Map to store data for each category
        Map<String, List<Item>> allCategoriesData = {};

        // Fetch data for each category
        for (var categoryJson in jsonList) {
          String category = categoryJson['category'];
          String dataUrl = categoryJson['data'];

          try {
            final response = await http.get(Uri.parse(dataUrl));

            if (response.statusCode == 200) {
              final Map<String, dynamic> jsonData = json.decode(response.body);

              List<dynamic> itemsJson = jsonData['item'] ?? [];

              List<Item> items =
                  itemsJson.map((item) => Item.fromJson(item)).toList();

              allCategoriesData[category] = items;
            } else {
              print(
                  'Error: Failed to load data. Status code: ${response.statusCode}');
            }
          } catch (e) {
            print('Error: $e');
          }
        }
        return allCategoriesData;
      } else {
        throw Exception('Failed to load category sources');
      }
    } catch (e) {
      print('Error fetching category sources: $e');
      rethrow;
    }
  }
}
