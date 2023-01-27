import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MotivationData {
  Future<http.Response> getMotivationData() async {
    // String requestURL = 'https://jsonplaceholder.typicode.com/albums/1';

    return await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  }
}
