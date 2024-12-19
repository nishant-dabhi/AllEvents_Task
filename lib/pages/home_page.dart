import 'package:allevents_task/widgets/event_card_widget.dart';
import 'package:allevents_task/pages/listing_page.dart';
import 'package:allevents_task/models/api_model.dart';
import 'package:allevents_task/services/request_api_service.dart';
import 'package:allevents_task/pages/webview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, List<Item>> _categoriesData = {};
  bool _isLoading = true;
  String? _error;

// fatching all data from categories API and store into _categoriesData
  Future<void> _fetchAllCategoriesData() async {
    try {
      final data = await EventService.fetchCategorySources();

      setState(() {
        _categoriesData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAllCategoriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
        title:
            Text('Welcome ${FirebaseAuth.instance.currentUser!.displayName}',style: Theme.of(context).textTheme.displaySmall),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : _buildCategoriesList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
        onPressed: () {
          _showCategoriesBottomSheet(context);
        },
        child: const Icon(Icons.grid_view_rounded),
      ),
    );
  }

  // outer vertical list with each category and its horizontal ListView
  Widget _buildCategoriesList() {
    return ListView(
      children: _categoriesData.keys.map((category) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Title
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ListingPage(
                        category: category,
                        itemsFuture: Future.value(_categoriesData[category]),
                      );
                    },
                  ));
                },
                child: Row(
                  children: [
                    Text(category.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: 24, fontWeight: FontWeight.w800)),
                    const Icon(Icons.arrow_forward_ios_sharp, size: 20,color: Colors.black,)
                  ],
                ),
              ),
            ),

            // Horizontal ListView with each Item
            Container(
              height: 255,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

// show only 6 items and then "SHOW MORE" to view full list
                itemCount: (_categoriesData[category]?.length)! > 6
                    ? 6 + 1
                    : _categoriesData[category]?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = _categoriesData[category]![index];
                  if (index == 6) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListingPage(
                              category: category,
                              itemsFuture:
                                  Future.value(_categoriesData[category]),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 120,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'SHOW MORE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  // Rendering Data in Horizontal ListView
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: EventCard(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EventWebView(eventUrl: item.eventUrl),
                          ));
                        },
                        imageUrl: item.bannerUrl,
                        dateLabel: item.startTimeDisplay,
                        eventName: item.eventname,
                        location: item.location),
                  );
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  // Show Bottom Sheet with all categories
  void _showCategoriesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration:  BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and grid icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Choose Your Preferred ',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: 'Category',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.grid_view, size: 24, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 10),

                // List of categories
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _categoriesData.keys.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final category = _categoriesData.keys.toList()[index];
                    return ListTile(
                      title: Text(
                        category.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context); // Close bottom sheet
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ListingPage(
                            category: category,
                            itemsFuture:
                                Future.value(_categoriesData[category]),
                          ),
                        ));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
