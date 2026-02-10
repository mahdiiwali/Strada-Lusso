import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing favorite cars persistence using SharedPreferences
///
/// This service provides methods to save and load favorite cars to/from local storage.
/// Favorites are stored as a list of car model names.
class FavoritesStorageService {
  // Storage key for favorites list
  static const String _favoritesKey = 'favorite_cars';

  /// Load the list of favorite car models from local storage
  ///
  /// Returns a Set of car model names that have been favorited by the user.
  /// If no favorites exist, returns an empty Set.
  ///
  /// Example usage:
  /// ```dart
  /// final favorites = await FavoritesStorageService.loadFavorites();
  /// ```
  static Future<Set<String>> loadFavorites() async {
    try {
      // Get SharedPreferences instance
      final prefs = await SharedPreferences.getInstance();

      // Retrieve the string list from storage (returns null if doesn't exist)
      final List<String>? favoritesList = prefs.getStringList(_favoritesKey);

      // Convert list to Set (or return empty Set if null)
      // Using Set ensures no duplicates
      return favoritesList != null ? Set<String>.from(favoritesList) : {};
    } catch (e) {
      // If there's any error loading, return empty set
      print('Error loading favorites: $e');
      return {};
    }
  }

  /// Save the list of favorite car models to local storage
  ///
  /// Takes a Set of car model names and saves them to SharedPreferences.
  ///
  /// Example usage:
  /// ```dart
  /// await FavoritesStorageService.saveFavorites({'BMW M5', 'Audi RS7'});
  /// ```
  static Future<void> saveFavorites(Set<String> favorites) async {
    try {
      // Get SharedPreferences instance
      final prefs = await SharedPreferences.getInstance();

      // Convert Set to List (SharedPreferences only supports List, not Set)
      final List<String> favoritesList = favorites.toList();

      // Save to storage
      await prefs.setStringList(_favoritesKey, favoritesList);
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  /// Add a single car model to favorites
  ///
  /// Convenience method that loads current favorites, adds the new one,
  /// and saves back to storage.
  static Future<void> addFavorite(String carModel) async {
    final favorites = await loadFavorites();
    favorites.add(carModel);
    await saveFavorites(favorites);
  }

  /// Remove a single car model from favorites
  ///
  /// Convenience method that loads current favorites, removes the specified one,
  /// and saves back to storage.
  static Future<void> removeFavorite(String carModel) async {
    final favorites = await loadFavorites();
    favorites.remove(carModel);
    await saveFavorites(favorites);
  }

  /// Check if a specific car model is in favorites
  ///
  /// Returns true if the car model is favorited, false otherwise.
  static Future<bool> isFavorite(String carModel) async {
    final favorites = await loadFavorites();
    return favorites.contains(carModel);
  }

  /// Clear all favorites from storage
  ///
  /// Useful for debugging or if implementing a "clear all favorites" feature
  static Future<void> clearFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_favoritesKey);
    } catch (e) {
      print('Error clearing favorites: $e');
    }
  }
}
