import 'dart:io';
import 'dart:convert';

import 'package:range_visualizer_app/constant/api_constants.dart';
import 'package:range_visualizer_app/model/range_model.dart';

class APIService {
  static final _baseUrl = Uri.parse(ApiConstants.baseUrl);

  static Future<List<RangeModel>> getRanges() async {
    final client = HttpClient();
    try {
      final req = await client.getUrl(_baseUrl);
      req.headers.set(
        HttpHeaders.authorizationHeader,
        'Bearer ${ApiConstants.token}',
      );
      final response = await req.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final data = jsonDecode(responseBody);
        List<RangeModel> ranges = (data as List)
            .map((item) => RangeModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return ranges;
      } else {
        throw Exception('Failed to load ranges: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load ranges: $e');
    } finally {
      client.close();
    }
  }
}
