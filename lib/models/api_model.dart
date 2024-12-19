class Item {
  String eventId;
  String eventname;
  String eventnameRaw;
  String ownerId;
  String thumbUrl;
  String thumbUrlLarge;
  int startTime;
  String startTimeDisplay;
  int endTime;
  String endTimeDisplay;
  String location;
  Venue venue;
  String label;
  int featured;
  String eventUrl;
  String shareUrl;
  String bannerUrl;
  double score;
  List<String> categories;
  List<String> tags;
  Tickets tickets;
  List<dynamic> customParams;

  Item({
    required this.eventId,
    required this.eventname,
    required this.eventnameRaw,
    required this.ownerId,
    required this.thumbUrl,
    required this.thumbUrlLarge,
    required this.startTime,
    required this.startTimeDisplay,
    required this.endTime,
    required this.endTimeDisplay,
    required this.location,
    required this.venue,
    required this.label,
    required this.featured,
    required this.eventUrl,
    required this.shareUrl,
    required this.bannerUrl,
    required this.score,
    required this.categories,
    required this.tags,
    required this.tickets,
    required this.customParams,
  });

  // Convert JSON to Item object
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      eventId: json['event_id'] ?? '',
      eventname: json['eventname'] ?? '',
      eventnameRaw: json['eventname_raw'] ?? '',
      ownerId: json['owner_id'] ?? '',
      thumbUrl: json['thumb_url'] ?? '',
      thumbUrlLarge: json['thumb_url_large'] ?? '',
      startTime: json['start_time'] ?? 0,
      startTimeDisplay: json['start_time_display'] ?? '',
      endTime: json['end_time'] ?? 0,
      endTimeDisplay: json['end_time_display'] ?? '',
      location: json['location'] ?? '',
      venue: Venue.fromJson(json['venue'] ?? {}),
      label: json['label'] ?? '',
      featured: json['featured'] ?? 0,
      eventUrl: json['event_url'] ?? '',
      shareUrl: json['share_url'] ?? '',
      bannerUrl: json['banner_url'] ?? '',
      score: json['score']?.toDouble() ?? 0.0,
      categories: List<String>.from(json['categories'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      tickets: Tickets.fromJson(json['tickets'] ?? {}),
      customParams: json['custom_params'] ?? [],
    );
  }

  // Convert Item object to JSON
  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'eventname': eventname,
      'eventname_raw': eventnameRaw,
      'owner_id': ownerId,
      'thumb_url': thumbUrl,
      'thumb_url_large': thumbUrlLarge,
      'start_time': startTime,
      'start_time_display': startTimeDisplay,
      'end_time': endTime,
      'end_time_display': endTimeDisplay,
      'location': location,
      'venue': venue.toJson(),
      'label': label,
      'featured': featured,
      'event_url': eventUrl,
      'share_url': shareUrl,
      'banner_url': bannerUrl,
      'score': score,
      'categories': categories,
      'tags': tags,
      'tickets': tickets.toJson(),
      'custom_params': customParams,
    };
  }
}

class Tickets {
  bool hasTickets;
  String ticketUrl;
  TicketCurrency? ticketCurrency;
  int? minTicketPrice;
  int? maxTicketPrice;

  Tickets({
    required this.hasTickets,
    required this.ticketUrl,
    this.ticketCurrency,
    this.minTicketPrice,
    this.maxTicketPrice,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) {
    return Tickets(
      hasTickets: json['has_tickets'] ?? false,
      ticketUrl: json['ticket_url'] ?? '',
      minTicketPrice: json['min_ticket_price'],
      maxTicketPrice: json['max_ticket_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'has_tickets': hasTickets,
      'ticket_url': ticketUrl,
      'min_ticket_price': minTicketPrice,
      'max_ticket_price': maxTicketPrice,
    };
  }
}

enum TicketCurrency { INR }

class Venue {
  String street;
  // City city;
  String city;
  // State state;
  String state;
  // Country country;
  String country;
  double latitude;
  double longitude;
  String fullAddress;

  Venue({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      fullAddress: json['full_address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'full_address': fullAddress,
    };
  }
}

class Request {
  String venue;
  String ids;
  String type;
  String city;
  int edate;
  int page;
  String keywords;
  int sdate;
  String category;
  String cityDisplay;
  int rows;

  Request({
    required this.venue,
    required this.ids,
    required this.type,
    required this.city,
    required this.edate,
    required this.page,
    required this.keywords,
    required this.sdate,
    required this.category,
    required this.cityDisplay,
    required this.rows,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        venue: json["venue"],
        ids: json["ids"],
        type: json["type"],
        city: json["city"],
        edate: json["edate"],
        page: json["page"],
        keywords: json["keywords"],
        sdate: json["sdate"],
        category: json["category"],
        cityDisplay: json["city_display"],
        rows: json["rows"],
      );

  Map<String, dynamic> toJson() => {
        "venue": venue,
        "ids": ids,
        "type": type,
        "city": city,
        "edate": edate,
        "page": page,
        "keywords": keywords,
        "sdate": sdate,
        "category": category,
        "city_display": cityDisplay,
        "rows": rows,
      };
}

class EventsCategory {
  String category;
  String data;

  EventsCategory({
    required this.category,
    required this.data,
  });

  factory EventsCategory.fromJson(Map<String, dynamic> json) {
    return EventsCategory(
      category: json['category'],
      data: json['data'],
    );
  }
}
