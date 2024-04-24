import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCaller {
  final String baseUrl =
      'https://englishtofol-api.onrender.com'; // Replace with your API base URL

  Future callGenerateEndpoint(prompt) async {
    final url = Uri.parse("$baseUrl/generate");
    final httpreq = http.Client();

    try {
      final response = await httpreq.post(url, body: {'prompt': prompt});

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        throw Exception('Failed to call generate endpoint');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
