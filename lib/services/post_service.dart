import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kisanagi/models/post_model.dart';

class PostService extends ChangeNotifier {
  static const String _postsKey = 'posts';
  List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final postsJson = prefs.getString(_postsKey);
      
      if (postsJson == null) {
        await _createSamplePosts(prefs);
      } else {
        final List<dynamic> decoded = jsonDecode(postsJson) as List;
        _posts = decoded.map((p) => PostModel.fromJson(p as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      debugPrint('Failed to initialize post service: $e');
      await _createSamplePosts(await SharedPreferences.getInstance());
    } finally {
      notifyListeners();
    }
  }

  Future<void> _createSamplePosts(SharedPreferences prefs) async {
    _posts = [
      PostModel(
        id: 'post_1',
        userId: 'user_2',
        userName: 'सुरेश पटेल',
        content: 'My wheat crop showing yellow spots. Anyone faced this issue before? Need urgent help! 🌾',
        imageUrl: 'assets/images/Wheat_Field_null_1766472199081.jpg',
        upvotes: 24,
        replies: 8,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      PostModel(
        id: 'post_2',
        userId: 'user_3',
        userName: 'रमेश शर्मा',
        content: 'Successfully treated leaf rust on my rice crop! Used the fungicide recommended by the app. Thank you Kisan-AGI! 🙏',
        imageUrl: 'assets/images/Rice_Plant_null_1766472197874.jpg',
        upvotes: 56,
        replies: 15,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      PostModel(
        id: 'post_3',
        userId: 'user_4',
        userName: 'विजय कुमार',
        content: 'Weather forecast says heavy rain next week. Should I harvest my cotton early or wait?',
        imageUrl: 'assets/images/Cotton_Plant_null_1766472200135.jpg',
        upvotes: 18,
        replies: 12,
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      PostModel(
        id: 'post_4',
        userId: 'user_5',
        userName: 'प्रकाश देसाई',
        content: 'New organic pesticide working great for tomatoes! No side effects on soil. Highly recommended! 🍅',
        upvotes: 42,
        replies: 6,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      PostModel(
        id: 'post_5',
        userId: 'user_6',
        userName: 'अजय सिंह',
        content: 'Looking for advice on best time to plant sugarcane in Maharashtra region. Any experienced farmers here?',
        imageUrl: 'assets/images/Sugarcane_Field_null_1766472201015.jpg',
        upvotes: 31,
        replies: 20,
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 12)),
      ),
      PostModel(
        id: 'post_6',
        userId: 'user_7',
        userName: 'गोपाल राव',
        content: 'Just joined this community! Excited to learn from fellow farmers. Growing rice for the first time. 🌱',
        upvotes: 67,
        replies: 25,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
    await _savePosts(prefs);
  }

  Future<void> _savePosts(SharedPreferences prefs) async {
    await prefs.setString(_postsKey, jsonEncode(_posts.map((p) => p.toJson()).toList()));
  }

  Future<void> addPost(PostModel post) async {
    try {
      _posts.insert(0, post);
      final prefs = await SharedPreferences.getInstance();
      await _savePosts(prefs);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to add post: $e');
    }
  }

  Future<void> upvotePost(String postId) async {
    try {
      final index = _posts.indexWhere((p) => p.id == postId);
      if (index != -1) {
        _posts[index] = _posts[index].copyWith(upvotes: _posts[index].upvotes + 1);
        final prefs = await SharedPreferences.getInstance();
        await _savePosts(prefs);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to upvote post: $e');
    }
  }
}
