import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String bookmarkedHousesKey = 'bookmarked_houses';

  static Future<void> saveBookmarkedHouses(List<int> houseIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> houseIdsString = houseIds.map((id) => id.toString()).toList();
    await prefs.setStringList(bookmarkedHousesKey, houseIdsString);
  }


  static Future<List<int>> getBookmarkedHouses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? houseIdsString = prefs.getStringList(bookmarkedHousesKey);
    if (houseIdsString == null) {
      return [];
    } else {
      return houseIdsString.map((id) => int.parse(id)).toList();
    }
  }


  static Future<void> addHouseToBookmarks(int houseId) async {
    List<int> currentBookmarks = await getBookmarkedHouses();
    if (!currentBookmarks.contains(houseId)) {
      currentBookmarks.add(houseId);
      await saveBookmarkedHouses(currentBookmarks);
    }
  }


  static Future<void> removeHouseFromBookmarks(int houseId) async {
    List<int> currentBookmarks = await getBookmarkedHouses();
    currentBookmarks.remove(houseId);
    await saveBookmarkedHouses(currentBookmarks);
  }

  
  static Future<bool> isHouseBookmarked(int houseId) async {
    List<int> currentBookmarks = await getBookmarkedHouses();
    return currentBookmarks.contains(houseId);
  }
}
