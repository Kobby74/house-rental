import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookmarksScreen extends StatefulWidget {
  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<dynamic> bookmarkedProperties = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookmarkedProperties();
  }

  Future<void> fetchBookmarkedProperties() async {
    var url = Uri.parse('https://rentapp-api.drevap.com/api/');
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ',
    });

    if (response.statusCode == 200) {
      setState(() {
        bookmarkedProperties = jsonDecode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load bookmarks'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Properties'),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: bookmarkedProperties.length,
              itemBuilder: (context, index) {
                final property = bookmarkedProperties[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                    leading: Icon(Icons.bookmark, color: Colors.blueAccent),
                    title: Text(property['property']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(property['location']),
                        Text(property['price']),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                      
                      },
                    ),
                    onTap: () {
                     
                    },
                  ),
                );
              },
            ),
    );
  }
}
