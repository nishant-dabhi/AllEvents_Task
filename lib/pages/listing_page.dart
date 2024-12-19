import 'package:allevents_task/widgets/listing_page_gridTile.dart';
import 'package:allevents_task/widgets/listing_page_listTile.dart';
import 'package:allevents_task/models/api_model.dart';
import 'package:allevents_task/pages/webview.dart';
import 'package:flutter/material.dart';

// this page shows all Items of perticular Category

class ListingPage extends StatefulWidget {
  ListingPage({required this.category, required this.itemsFuture, super.key});
  final String? category;
  final Future<List<Item>> itemsFuture;

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text('${widget.category!.toUpperCase()} Events',style: Theme.of(context).textTheme.displaySmall),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (_isGridView) {
                      _isGridView = false;
                    } else {
                      _isGridView = true;
                    }
                  });
                },
                icon: _isGridView
                    ? const Icon(Icons.grid_view_sharp)
                    : const Icon(Icons.list))
          ],
        ),
        body: FutureBuilder<List<Item>>(
            future: widget.itemsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No events available'));
              }

              final items = snapshot.data!;

              return _isGridView
                  ? _buildGridView(items)
                  : _buildListView(items);
            }));
  }

  Widget _buildListView(List<Item> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListingPageTile(
          imageUrl: item.bannerUrl,
          title: item.eventname,
          location: item.location,
          dateInfo: item.label,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventWebView(eventUrl: item.eventUrl),
            ));
          },
        );
      },
    );
  }

  Widget _buildGridView(List<Item> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.75),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListingPageGridTile(
          imageUrl: item.bannerUrl,
          title: item.eventname,
          location: item.location,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventWebView(eventUrl: item.eventUrl),
            ));
          },
        );
      },
    );
  }
}
