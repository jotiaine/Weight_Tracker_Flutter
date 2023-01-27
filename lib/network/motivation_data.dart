import 'dart:convert';

import 'package:http/http.dart' as http;

class MotivationData {
  Future getMotivationData() async {
// GET /quote?token=ipworld.info HTTP/1.1
// X-Rapidapi-Key: dd6792186dmsh76cb74ea31ac68ap1fd6f6jsna1fcd0a2c466
// X-Rapidapi-Host: quotes-inspirational-quotes-motivational-quotes.p.rapidapi.com
// Host: quotes-inspirational-quotes-motivational-quotes.p.rapidapi.com

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://quotes-inspirational-quotes-motivational-quotes.p.rapidapi.com/quote?token=ipworld.info'));

    request.headers.addAll({
      "X-Rapidapi-Key": "dd6792186dmsh76cb74ea31ac68ap1fd6f6jsna1fcd0a2c466",
      "X-Rapidapi-Host":
          "quotes-inspirational-quotes-motivational-quotes.p.rapidapi.com",
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
    return response;
  }
}
