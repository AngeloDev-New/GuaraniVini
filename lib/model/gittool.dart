import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Map<String, String>>> getGithub(String link) async {
  final token = dotenv.env['GITHUB_TOKEN'];
  final url = Uri.parse(link);

  final headers = {
    if (token != null) 'Authorization': 'token $token',
    'Accept': 'application/vnd.github.v3.raw',
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      print('Json capturado com sucesso!');
      return jsonList.map<Map<String, String>>((item) => Map<String, String>.from(item)).toList();
    } else {
      print('Erro na requisição: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro ao fazer requisição do json: $e');
  }

  return [];
}
