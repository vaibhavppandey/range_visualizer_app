import 'dart:io';
import 'dart:convert';

import 'package:range_visualizer_app/constant/api_constants.dart';

class APIService {
  static final _client = HttpClient();
  static final _baseUrl = Uri.parse(ApiConstants.baseUrl);

  Future<void> getRanges() async {

  }
}