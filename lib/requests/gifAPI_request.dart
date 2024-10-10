import 'package:http/http.dart' as http;
import 'dart:convert';

String? search;
int offset = 0;

Future<Map> getGifs() async {
  http.Response response;

  if (search == null || search!.isEmpty) {
    var trendingUrl = Uri.parse(
        "https://api.giphy.com/v1/gifs/trending?api_key=8CHBPqQM0U6geAQ2S4OnLuQShYjVBpjQ&limit=25&offset=$offset&rating=g&bundle=messaging_non_clips");
    response = await http.get(trendingUrl);
  } else {
    var searchUrl = Uri.parse(
        "https://api.giphy.com/v1/gifs/search?api_key=8CHBPqQM0U6geAQ2S4OnLuQShYjVBpjQ&q=$search&limit=19&offset=$offset&rating=g&lang=en&bundle=messaging_non_clips");
    response = await http.get(searchUrl);
  }

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Falha ao carregar GIFs');
  }
}
