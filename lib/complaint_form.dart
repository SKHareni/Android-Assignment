import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, String>> vegOptions = [
    {'name': 'Veg Meal', 'image': 'assets/images/vmeal.jpg'},
    {'name': 'Poori', 'image': 'assets/images/poori.jpg'},
    {'name': 'Veg Briyani', 'image': 'assets/images/vegbri.jpg'},
  ];
  List<Map<String, String>> nonVegOptions = [
    {'name': 'Non Veg Meal', 'image': 'assets/images/nvmeal.jpg'},
    {'name': 'Fish Fry', 'image': 'assets/images/fishfry.jpg'},
    {'name': 'Chicken Briyani', 'image': 'assets/images/chibri.jpg'},
  ];
  List<String> selectedFoods = [];
  double rating = 0;
  final TextEditingController queryController = TextEditingController();
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    imageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void _submitComplaint() {
    print('Selected Foods: $selectedFoods');
    print('Rating: $rating');
    print('Query: ${queryController.text}');
    if (imageFile != null) {
      print('Image Path: ${imageFile!.path}');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.blue.withOpacity(0.7),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'GrieveEasy',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Food Type',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          TabBar(
                            controller: _tabController,
                            tabs: [
                              Tab(text: 'Veg'),
                              Tab(text: 'Non-Veg'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 200,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                _buildFoodList(vegOptions),
                                _buildFoodList(nonVegOptions),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text('Rate the food:',
                              style: TextStyle(fontSize: 18)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return IconButton(
                                icon: Icon(
                                  index < rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                ),
                                onPressed: () {
                                  setState(() {
                                    rating = index + 1.0;
                                  });
                                },
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: queryController,
                            decoration: InputDecoration(
                              labelText: 'Your Query',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _pickImage,
                            child: Text('Upload Food Image'),
                          ),
                          SizedBox(height: 10),
                          if (imageFile != null)
                            Text('Selected Image: ${imageFile!.name}'),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _submitComplaint,
                            child: Text('Submit Complaint'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 60),
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodList(List<Map<String, String>> foodOptions) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: foodOptions.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              String foodName = foodOptions[index]['name']!;
              if (selectedFoods.contains(foodName)) {
                selectedFoods.remove(foodName);
              } else {
                selectedFoods.add(foodName);
              }
            });
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 2,
            child: Container(
              width: 120,
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(foodOptions[index]['image']!, height: 60),
                  SizedBox(height: 8),
                  Text(foodOptions[index]['name']!),
                  SizedBox(height: 8),
                  Checkbox(
                    value: selectedFoods.contains(foodOptions[index]['name']),
                    onChanged: (bool? value) {
                      setState(() {
                        String foodName = foodOptions[index]['name']!;
                        if (value == true) {
                          selectedFoods.add(foodName);
                        } else {
                          selectedFoods.remove(foodName);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
