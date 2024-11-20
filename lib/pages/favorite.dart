import 'package:flutter/material.dart';
import 'package:responsi/pages/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<String> favoriteRestaurants = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Filter keys that are marked as favorite and store the IDs.
      favoriteRestaurants = prefs.getKeys()
          .where((key) => key.startsWith('favorite_') && prefs.getBool(key) == true)
          .map((key) => key.replaceFirst('favorite_', ''))
          .toList();
    });
  }

  Future<void> _removeFromFavorites(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('favorite_$id', false);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit Saya'),
      ),
      body: favoriteRestaurants.isEmpty
          ? const Center(
              child: Text(
                'Belum ada restoran favorit.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: favoriteRestaurants.length,
              itemBuilder: (context, index) {
                final restaurantId = favoriteRestaurants[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(
                      Icons.restaurant,
                      size: 40,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      'Restaurant ID: $restaurantId',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => _removeFromFavorites(restaurantId),
                    ),
                    onTap: () {
                      // Navigasi ke halaman detail.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailPage(
                            restaurantId: restaurantId,
                          ),
                        ),
                      ).then((_) => _loadFavorites());
                    },
                  ),
                );
              },
            ),
    );
  }
}
