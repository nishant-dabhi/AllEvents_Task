import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String dateLabel;
  final String eventName;
  final String location;
  final VoidCallback onTap;

  const EventCard(
      {Key? key,
      required this.imageUrl,
      required this.dateLabel,
      required this.eventName,
      required this.location,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Container(
          width: MediaQuery.of(context).size.width *
                  0.90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 160,
                width: MediaQuery.of(context).size.width *
                    0.90, // Occupy 90% of the screen's width
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      imageUrl,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date label
                    Text(dateLabel.toUpperCase(),
                    maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    // Event name
                    Text(eventName, 
                    maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 4),
                    // Location
                    Text(location, 
                    maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
