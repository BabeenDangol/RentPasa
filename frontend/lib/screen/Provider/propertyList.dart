import 'package:flutter/material.dart';
import 'package:loginuicolors/screen/dashboard_list/property_list_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import 'dart:convert';

import '../../utils/Property_utils.dart';

class PropertyListProvider extends ChangeNotifier {
  bool isLoading = false;
  List<PropertyList> _propertylist = [];
  List<PropertyList> get propertylist => _propertylist;

//search variable
  String _search = '';
  String get search => _search;

  PropertyListProvider() {
    refreshData();
  }
  Future<void> refreshData() async {
    isLoading = true;
    final data = await DataUtil().getData();

    _propertylist = data;
    notifyListeners();
    isLoading = false;
    // updatePropertyModel(data);
  }

  // void updatePropertyModel(List<PropertyList> data) {
  //   notifyListeners();
  // }

  void updateSearch(String search) {
    _search = search;
    notifyListeners();
  }

  List<PropertyList> get filteredPropertyList {
    if (_search.isEmpty) {
      return _propertylist;
    } else {
      return _propertylist
          .where((property) => property.propertyAddress
              .toLowerCase()
              .contains(_search.toLowerCase()))
          .toList();
    }
  }
}
