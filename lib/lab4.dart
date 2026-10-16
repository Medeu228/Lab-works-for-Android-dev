import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ProfileCardScreen(),
    );
  }
}

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileCardScreenState();
}

class _ProfileCardScreenState extends State<ProfileCardScreen> {
  static const bool _defaultIsFollowing = false;
  static const bool _defaultIsLiked = false;
  static const int _defaultLikeCount = 66;
  static const int _defaultFollowersCount = 1487;

  bool isFollowing = _defaultIsFollowing;
  bool isLiked = _defaultIsLiked;
  int likeCount = _defaultLikeCount;
  int followersCount = _defaultFollowersCount;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
      followersCount += isFollowing ? 1 : -1;
    });
  }

  void _reset() {
    setState(() {
      isFollowing = _defaultIsFollowing;
      isLiked = _defaultIsLiked;
      likeCount = _defaultLikeCount;
      followersCount = _defaultFollowersCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile Card'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 146,
              height: 146,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[400]!, width: 3),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/avatar.png',
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 140,
                    height: 140,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 32,
                        onPressed: _toggleLike,
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey[500],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$likeCount likes',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 60),

                Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _toggleFollow,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isFollowing
                              ? Colors.blue[100]
                              : Colors.blue,
                          foregroundColor: isFollowing
                              ? Colors.blue[800]
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          elevation: 0,
                        ),
                        child: Text(isFollowing ? 'Following' : 'Follow'),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$followersCount followers',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),
            TextButton(onPressed: _reset, child: const Text('Reset')),
          ],
        ),
      ),
    );
  }
}
