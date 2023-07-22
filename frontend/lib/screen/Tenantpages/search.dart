import 'package:flutter/material.dart';
import 'package:loginuicolors/utils/route_names.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String selectedPropertyType = '';

  int minBudget = 0;

  int maxBudget = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Search Filters',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(height: 16),
              Text('Keyword'),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'Enter a keyword',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 25),
              Text('Property Type'),
              Wrap(
                spacing: 16,
                children: [
                  _buildPropertyTypeOption('room', Icons.home),
                  _buildPropertyTypeOption('apartment', Icons.apartment),
                  _buildPropertyTypeOption('office', Icons.work),
                  _buildPropertyTypeOption('house', Icons.house),
                ],
              ),
              SizedBox(height: 25),
              Text('Budget'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        hintText: 'Min Budget',
                        suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        // Handle min budget text change
                        setState(() {
                          minBudget = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        hintText: 'Max Budget',
                        suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        // Handle min budget text change
                        setState(() {
                          minBudget = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.listing);
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyTypeOption(String propertyType, IconData icon) {
    return ChoiceChip(
      label: Text(propertyType),
      selected: selectedPropertyType == propertyType,
      onSelected: (bool selected) {
        setState(() {
          selectedPropertyType = selected ? propertyType : '';
        });
      },
      avatar: Icon(icon),
    );
  }
}
