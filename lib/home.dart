import 'package:flutter/material.dart';
import 'complaint_form.dart'; // Import the ComplaintForm

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/img.png', // Your background image path
            fit: BoxFit.cover,
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                _buildOptionCard(
                    context, 'Food', Colors.orange, 'assets/images/food.png'),
                SizedBox(height: 20),
                _buildOptionCard(context, 'Hostel', Colors.green,
                    'assets/images/hostel.jpg'),
                SizedBox(height: 20),
                _buildOptionCard(context, 'College', Colors.blue,
                    'assets/images/college.png'),
                SizedBox(height: 20),
                _buildOptionCard(
                    context, 'Others', Colors.red, 'assets/images/others.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each option card with larger images
  Widget _buildOptionCard(
      BuildContext context, String title, Color color, String imagePath) {
    return GestureDetector(
      onTap: () {
        if (title == 'Food') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComplaintForm()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title button tapped!')),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7), // Semi-transparent background
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                imagePath,
                height: 220, // Increased image height
                width: double.infinity, // Full width
                fit: BoxFit.cover, // Cover the container
              ),
              Container(
                color: Colors.black54, // Semi-transparent overlay
                padding: EdgeInsets.all(10),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
