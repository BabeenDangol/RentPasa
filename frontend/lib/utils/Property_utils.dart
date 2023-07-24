import 'dart:convert';

import 'package:loginuicolors/screen/dashboard_list/property_list_model.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class DataUtil {
  Future<List<PropertyList>> getData() async {
    List<PropertyList> propertyData = [];
    try {
      final response = await http.get(Uri.parse(getUserBookings));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("Data;${jsonData}");
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
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      print("Exception in Data $e");
      throw (e);
    }
  }
}
