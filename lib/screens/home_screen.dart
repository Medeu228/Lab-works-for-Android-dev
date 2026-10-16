import 'package:flutter/material.dart';
import 'feed_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

// Root screen: owns the BottomNavigationBar and the one piece of state
// shared across tabs — which product ids are favorited.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final Set<int> _favoriteIds = {};

  void _toggleFavorite(int productId) {
    setState(() {
      if (_favoriteIds.contains(productId)) {
        _favoriteIds.remove(productId);
      } else {
        _favoriteIds.add(productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // IndexedStack keeps all three tabs alive and just swaps which one is
    // visible — switching tabs doesn't rebuild/reset them (Feed keeps its
    // scroll position, for example).
    final tabs = [
      FeedScreen(favoriteIds: _favoriteIds, onToggleFavorite: _toggleFavorite),
      FavoritesScreen(favoriteIds: _favoriteIds, onToggleFavorite: _toggleFavorite),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
