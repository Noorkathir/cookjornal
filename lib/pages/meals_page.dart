import 'package:flutter/material.dart';
import '../api_service.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  List<Map<String, dynamic>> meals = [];
  Map<String, dynamic>? categoryData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryData = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    loadMeals(categoryData!['strCategory']);
  }

  Future<void> loadMeals(String category) async {
    final fetchedMeals = await ApiService().fetchMeals(category);
    setState(() {
      meals = fetchedMeals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryData?['strCategory'] ?? ""),
        backgroundColor: const Color.fromARGB(255, 52, 94, 61),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              categoryData?['strCategoryThumb'] ?? "",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

           
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    categoryData?['strCategoryDescription'] ?? "",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

          
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Meals (${meals.length})",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            meals.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: meals.map((meal) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: Image.network(
                                  meal['strMealThumb'],
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                           
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  meal['strMeal'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

          

                              // const SizedBox(height: 10),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}