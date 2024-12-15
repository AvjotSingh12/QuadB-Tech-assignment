import 'package:flutter/material.dart';
import '../utils/apiService.dart';
import 'detailsScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> searchResults = [];
  TextEditingController searchController = TextEditingController();
  bool _isLoading = false;

  void searchMovies() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final data = await ApiService.fetchMovies(searchController.text.trim());
      setState(() {
        searchResults = data;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1F1F), // Consistent dark background
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: TextField(
          controller: searchController,
          style: TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white70),
            hintText: "Search for movies...",
            hintStyle: TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Color(0xFF2E2E2E),
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onSubmitted: (value) => searchMovies(),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.red[900],
              ),
            )
          : searchResults.isEmpty
              ? Center(
                  child: Text(
                    "No results found",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final movie = searchResults[index]['show'];
                    return FadeInAnimation(
                      delay: index * 0.1, // Staggered effect
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFF2E2E2E),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              movie['image']?['medium'] ??
                                  'https://via.placeholder.com/150',
                              width: 60,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            movie['name'] ?? 'No Title',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            movie['summary']
                                    ?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                                'No summary available',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white54,
                            size: 18,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(movie: movie),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

// FadeIn Animation Widget
class FadeInAnimation extends StatelessWidget {
  final Widget child;
  final double delay;

  FadeInAnimation({required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
      child: child,
      builder: (context, double opacity, Widget? widget) {
        return Opacity(
          opacity: opacity,
          child: widget,
        );
      },
    );
  }
}
