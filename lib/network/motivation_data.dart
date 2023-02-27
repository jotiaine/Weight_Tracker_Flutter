import 'dart:convert';
import 'package:http/http.dart' as http;

class MotivationData {
  final String _apiKey = '';
  final String _apiHost = '';
  final String _url = '';

  late final String _motivationText;
  late final String _motivationTextAuthor;

  Future getMotivationData() async {
    try {
      var request = http.Request('GET', Uri.parse(_url));

      request.headers.addAll({
        "X-Rapidapi-Key": _apiKey,
        "X-Rapidapi-Host": _apiHost,
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map data = jsonDecode(await response.stream.bytesToString());

        _motivationText = data['text'];
        _motivationTextAuthor = data['author'];

        // check if the text is null
        if (_motivationText.isEmpty) {
          _motivationText = 'You can do it. Just keep going forward.';
        }

        // check if the author is null
        if (_motivationTextAuthor.isEmpty) {
          _motivationTextAuthor = 'Unknown';
        }

        return response;
      } else {
        // ignore: avoid_print
        print(response.reasonPhrase);
      }

      return response;
    } catch (e) {
      // set default values if there is an error
      _motivationText = 'Loading...';
      _motivationTextAuthor = 'Unknown';

      // ignore: avoid_print
      print(e);
    }
  }

  // getters
  String get motivationText => _motivationText;
  String get motivationTextAuthor => _motivationTextAuthor;
}
