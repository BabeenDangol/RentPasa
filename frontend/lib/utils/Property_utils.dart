import 'dart:convert';

import 'package:loginuicolors/screen/dashboard_list/property_list_model.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

import 'loggers.dart';

class DataUtil {
  final log = logger;
  Future<List<PropertyList>> getData() async {
    List<PropertyList> propertyData = [];
    try {
      final response = await http.get(Uri.parse(getUserBookings));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == true && jsonData['property'] is List) {
          propertyData = (jsonData['property'] as List<dynamic>)
              .map((item) => PropertyList.fromJson(item))
              .toList();
        }
        // json.forEach((element) {
        //   PropertyList property = PropertyList.fromJson(element);
        //   propertyData.add(property);
        // });
        return propertyData;
      } else {
        log.i(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      log.i("Exception in Data $e");
      throw (e);
    }
  }
}
