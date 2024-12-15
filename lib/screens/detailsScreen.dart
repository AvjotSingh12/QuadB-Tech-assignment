import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF1F1F1F), // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          movie['name'] ?? 'No Title',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Image with Realistic and Responsive View
            Stack(
              children: [
                Container(
                  height: screenHeight * 0.4, // 40% of screen height
                  width: screenWidth, // Full screen width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(0, 4), // Shadow effect
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.network(
                      movie['image']?['original'] ??
                          'https://via.placeholder.com/300',
                      fit: BoxFit.cover, // Ensure full coverage
                    ),
                  ),
                ),
                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                // Movie Title on Image
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Text(
                    movie['name'] ?? 'No Title',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black87,
                          blurRadius: 8,
                          offset: Offset(2, 2), // Text shadow for readability
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Overview Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Overview",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Summary Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                        'No Summary Available',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Additional Info Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 24),
                      SizedBox(width: 8),
                      Text(
                        "IMDB Rating: ${movie['rating']?.toString() ?? '7.5'}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Language: ${movie['language'] ?? 'N/A'}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Premiered: ${movie['premiered'] ?? 'N/A'}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
