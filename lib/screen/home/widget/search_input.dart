import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final Function(String) onSearch;

  SearchInput({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: 'Search here...',
          prefixIcon: Container(
            padding: EdgeInsets.all(15),
            child: SvgPicture.asset('assets/icons/search-4-svgrepo-com.svg'),
          ),
          contentPadding: EdgeInsets.all(2),
        ),
        onSubmitted: (query) {
          onSearch(query);
        },
      ),
    );
  }
}
