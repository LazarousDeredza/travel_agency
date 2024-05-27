import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:travel_agency/tax_hiring_module/src/constants/image_strings.dart';

class Hotel {
  final int id;
  final String name;
  final String address;
  final int minimalPrice;
  final String priceForIt;
  final int rating;
  final String ratingName;
  final List<String> imageUrls;
  final HotelInfo aboutTheHotel;

  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.minimalPrice,
    required this.priceForIt,
    required this.rating,
    required this.ratingName,
    required this.imageUrls,
    required this.aboutTheHotel,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      address: json['adress'],
      minimalPrice: json['minimal_price'],
      priceForIt: json['price_for_it'],
      rating: json['rating'],
      ratingName: json['rating_name'],
      imageUrls: List<String>.from(json['image_urls']),
      aboutTheHotel: HotelInfo.fromJson(json['about_the_hotel']),
    );
  }
}

class HotelInfo {
  final String description;
  final List<String> peculiarities;

  HotelInfo({
    required this.description,
    required this.peculiarities,
  });

  factory HotelInfo.fromJson(Map<String, dynamic> json) {
    return HotelInfo(
      description: json['description'],
      peculiarities: List<String>.from(json['peculiarities']),
    );
  }
}

// Future<Hotel> fetchHotel() async {
//   final response = await http.get(Uri.parse(
//       'https://run.mocky.io/v3/75000507-da9a-43f8-a618-df698ea7176d'));

//   if (response.statusCode == 200) {
//     return Hotel.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load hotel data');
//   }
// }

Future<Hotel> fetchHotel() async {
 //Hotel h=Hotel(id: id, name: name, address: address, minimalPrice: minimalPrice, priceForIt: priceForIt, rating: rating, ratingName: ratingName, imageUrls: imageUrls, aboutTheHotel: aboutTheHotel);

  List<Hotel> hotels = data();


  return hotels.first;
}


List<Hotel> fetchHotels()   {
 //Hotel h=Hotel(id: id, name: name, address: address, minimalPrice: minimalPrice, priceForIt: priceForIt, rating: rating, ratingName: ratingName, imageUrls: imageUrls, aboutTheHotel: aboutTheHotel);

  List<Hotel> hotels =  data();


  return hotels;
}

List<Hotel> data() {

  List<Map<String, dynamic>> hotels = [
//     {
//       "id": 1,
//       "name": "Hotel A",
//       "address": "123 Main Street",
//       "minimalPrice": 100,
//       "priceForIt": "Starting from \$100",
//       "rating": 4,
//       "ratingName": "Excellent",
//       "imageUrls": [
//        tHotel1,
// tHotel1      ],
//       "about_the_hotel": {
//         "description": "Hotel A is a luxurious hotel with stunning views.",
//         "peculiarities": ["Swimming pool", "Gym", "Spa"]
//       }
//     },
//     {
//       "id": 2,
//       "name": "Hotel B",
//       "address": "456 Elm Street",
//       "minimalPrice": 150,
//       "priceForIt": "Starting from \$150",
//       "rating": 3,
//       "ratingName": "Good",
//       "imageUrls": [
//         tHotel1,
//         tHotel1
//       ],
//       "about_the_hotel": {
//         "description": "Hotel B offers comfortable rooms and friendly service.",
//         "peculiarities": ["Restaurant", "Bar", "Conference rooms","Casino","Play Grounds"]
//       }
//     },
//     // Additional hotel details omitted for brevity
 
 {
"id": 1,
"name": "The Royal Livingstone Hotel",
"address": "Victoria Falls, Zambia",
"minimalPrice": 500,
"priceForIt": "Starting from \$500",
"rating": 5,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/royal-livingstone/image1.jpg",
"https://example.com/royal-livingstone/image2.jpg"
],
"about_the_hotel": {
"description": "The Royal Livingstone Hotel is a luxury old-world hotel located in Victoria Falls, bordering the Zambezi National Park. It offers uninterrupted views of the Zambezi River and is just a 5-minute walk to Victoria Falls. The hotel provides a private butler service and offers activities such as boating safaris on the river and exploring Victoria Falls via a luxury steam train. It is perfect for travelers seeking a lavish and laidback holiday.",
"peculiarities": [
"Luxury old-world hotel",
"Uninterrupted views of the Zambezi River",
"5-minute walk to Victoria Falls",
"Private butler service",
"Boating safari on the river",
"Explore Vic Falls via a luxury steam train"
]
}
},
{
"id": 2,
"name": "Royal Chundu",
"address": "Zambezi River, Zambia",
"minimalPrice": 600,
"priceForIt": "Starting from \$600",
"rating": 5,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/royal-chundu/image1.jpg",
"https://example.com/royal-chundu/image2.jpg"
],
"about_the_hotel": {
"description": "Royal Chundu is an award-winning 5-star luxury lodge located on the banks of the Zambezi River. It is Zambia's first and only Relais & Châteaux property. The lodge offers uninterrupted views of the surroundings and is just 40 minutes away from Victoria Falls. Guests can enjoy activities such as canoeing and cruises on the river, as well as scenic helicopter flights. It is ideal for families and romantic getaways.",
"peculiarities": [
"Award-winning 5-star luxury lodge",
"Uninterrupted views of the Zambezi River",
"40 minutes away from Victoria Falls",
"Canoeing and cruises on the river",
"Scenic helicopter flights"
]
}
},
{
"id": 3,
"name": "Sanctuary Sussi & Chuma",
"address": "Mosi-oa-Tunya National Park, Zambia",
"minimalPrice": 400,
"priceForIt": "Starting from \$400",
"rating": 4,
"ratingName": "Great",
"imageUrls": [
"https://example.com/sussi-chuma/image1.jpg",
"https://example.com/sussi-chuma/image2.jpg"
],
"about_the_hotel": {
"description": "Sanctuary Sussi & Chuma is a treehouse-style luxury lodge located in Mosi-oa-Tunya National Park. It offers uninterrupted views of the Zambezi River and is 20 kilometers (12 miles) from Victoria Falls. The lodge provides a secluded location away from the crowds and offers activities such as guided walking safaris, river cruises, and canoeing safaris. Guests can also enjoy white-water rafting and helicopter flights. It is suitable for solo travelers, families, and couples.",
"peculiarities": [
"Treehouse-style luxury lodge",
"Uninterrupted views of the Zambezi River",
"20 kilometers from Victoria Falls",
"Secluded location away from the crowds",
"Guided walking safaris, river cruises, and canoeing safaris"
]
}
},
{
"id": 4,
"name": "The River Club",
"address": "Zambezi River, Zambia",
"minimalPrice": 450,
"priceForIt": "Starting from \$450",
"rating": 4,
"ratingName": "Great",
"imageUrls": [
"https://example.com/river-club/image1.jpg",
"https://example.com/river-club/image2.jpg"
],
"about_the_hotel": {
"description": "The River Club is an upscale old-world lodge overlooking the Zambezi River. It offers game drives through Mosi-oa-Tunya National Park and boat cruises on the river. Guests can also enjoy activities such as tennis, croquet, boules, and snooker. The lodge provides nature trails for running or walking and offers entertainment for kids at The Club. It is perfect for honeymoons, family holidays, and romantic getaways.",
"peculiarities": [
"Upscale old-world lodge",
"Game drives through Mosi-oa-Tunya National Park",
"Boat cruises on the river",
"Tennis, croquet, boules, and snooker",
"Run or walk on nature trails",
"Kids @ The Club keeps the little ones entertained"
]
}
},
{
"id": 5,
"name": "Victoria Falls River & Island Lodges",
"address": "Zambezi National Park, Zambia",
"minimalPrice": 550,
"priceForIt": "Starting from \$550",
"rating": 5,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/river-island-lodges/image1.jpg",
"https://example.com/river-island-lodges/image2.jpg"
],
"about_the_hotel": {
"description": "Victoria Falls River Lodge and Island Lodge are opulent 5-star lodges located in Zambezi National Park. They offer uninterrupted views of the Zambezi River and riverine forest. The lodges are upstream from Victoria Falls and its adventure activities. Island Lodge provides personal butler service and offers star-bed sleepouts under the night sky. These lodges are perfect for family holidays, romantic getaways, and honeymoons.",
"peculiarities": [
"Opulent 5-star lodges",
"Uninterrupted views of the Zambezi River and riverine forest",
"Upstream from Victoria Falls and its adventure activities",
"Personal butler service at Island Lodge",
"Star-bed sleepouts under the night sky at Island Lodge"
]
}
},
{
"id": 6,
"name": "Old Drift Lodge",
"address": "Zambezi National Park, Zambia",
"minimalPrice": 400,
"priceForIt": "Starting from \$400",
"rating": 4,
"ratingName": "Great",
"imageUrls": [
"https://example.com/old-drift-lodge/image1.jpg",
"https://example.com/old-drift-lodge/image2.jpg"
],
"about_the_hotel": {
"description": "Old Drift Lodge is an elegant and opulent lodge located in Zambezi National Park. It offers panoramic views of the Zambezi River and allows guests to have lunch over Batoka Gorge. The lodge provides the opportunity to swim on the edge of Victoria Falls in Devil's Pool and offers guided walking safaris through the park. Guests can also enjoy scenic helicopter flights, canopy tours through Vic Fall's rainforest, and more. It is suitable for families, small groups, and couples.",
"peculiarities": [
"Elegant and opulent lodge",
"Panoramic views of the Zambezi River",
"Have lunch over Batoka Gorge",
"Swim on the edge of Victoria Falls in Devil's Pool",
"Guided walking safaris through the park",
"Scenic helicopter flights over the Falls",
"Canopy tours through Vic Fall's rainforest"
]
}
},

{
"id": 7,
"name": "Mukwa River Lodge",
"address": "Lower Zambezi, Zambia",
"minimalPrice": 350,
"priceForIt": "Starting from \$350",
"rating": 4,
"ratingName": "Great",
"imageUrls": [
"https://example.com/mukwa-river-lodge/image1.jpg",
"https://example.com/mukwa-river-lodge/image2.jpg"
],
"about_the_hotel": {
"description": "Mukwa River Lodge is located on the banks of the Lower Zambezi, offering seamless elegance and private accommodation with stunning views of the ebbing and flowing Zambezi River. The lodge provides various experiences such as river cruises, game drives, and a tour of the mighty Victoria Falls from the Zambia side. Guests can enjoy private plunge pools, outdoor showers, and furnished decks. The lodge also offers a spa, gym, outdoor pool, and heated pool. It is perfect for couples and groups of friends.",
"peculiarities": [
"Stunning, panoramic views of the Zambezi River",
"Close to Victoria Falls and all its offerings",
"Fishing, white-water rafting, boating, game drives, and helicopter flights",
"Armchair safari moments from your private patio",
"Private plunge pools, outdoor showers"
]
}
},
{
"id": 8,
"name": "Victoria Falls Hotel",
"address": "1 Mallet Drive, Victoria Falls, Zimbabwe",
"minimalPrice": 300,
"priceForIt": "Starting from \$300",
"rating": 5,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/victoriaFallsHotel/image1.jpg",
"https://example.com/victoriaFallsHotel/image2.jpg"
],
"about_the_hotel": {
"description": "The Victoria Falls Hotel is a historic hotel located near the iconic Victoria Falls. It offers luxurious accommodations and stunning views of the falls.",
"peculiarities": [
"Swimming pool",
"Spa",
"Restaurants and bars"
]
}
},
{
"id": 9,
"name": "Elephant Hills Resort",
"address": "Nakavango Estate, Victoria Falls, Zimbabwe",
"minimalPrice": 250,
"priceForIt": "Starting from \$250",
"rating": 4,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/elephantHillsResort/image1.jpg",
"https://example.com/elephantHillsResort/image2.jpg"
],
"about_the_hotel": {
"description": "Elephant Hills Resort is a luxury resort situated on the banks of the Zambezi River, offering stunning views and a wide range of amenities.",
"peculiarities": [
"Swimming pool",
"Golf course",
"Spa"
]
}
},
{
"id": 10,
"name": "The Kingdom at Victoria Falls",
"address": "32 Livingstone Way, Victoria Falls, Zimbabwe",
"minimalPrice": 200,
"priceForIt": "Starting from \$200",
"rating": 4,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/kingdomAtVictoriaFalls/image1.jpg",
"https://example.com/kingdomAtVictoriaFalls/image2.jpg"
],
"about_the_hotel": {
"description": "The Kingdom at Victoria Falls is a unique hotel that combines traditional African design with modern amenities, offering a memorable experience.",
"peculiarities": [
"Swimming pool",
"Restaurants and bars",
"Entertainment complex"
]
}
},
{
"id": 11,
"name": "Ilala Lodge Hotel",
"address": "Parkway Drive, Victoria Falls, Zimbabwe",
"minimalPrice": 180,
"priceForIt": "Starting from \$180",
"rating": 4,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/ilalaLodgeHotel/image1.jpg",
"https://example.com/ilalaLodgeHotel/image2.jpg"
],
"about_the_hotel": {
"description": "Ilala Lodge Hotel is a family-owned hotel located just a short walk from the mighty Victoria Falls, offering a peaceful and comfortable stay.",
"peculiarities": [
"Swimming pool",
"Restaurants and bars",
"River cruises"
]
}
},
{
"id": 12,
"name": "A'Zambezi River Lodge",
"address": "Old Ursula Road, Victoria Falls, Zimbabwe",
"minimalPrice": 160,
"priceForIt": "Starting from \$160",
"rating": 4,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/aZambeziRiverLodge/image1.jpg",
"https://example.com/aZambeziRiverLodge/image2.jpg"
],
"about_the_hotel": {
"description": "A'Zambezi River Lodge is a serene and tranquil hotel situated on the banks of the Zambezi River, offering a peaceful escape from the hustle and bustle.",
"peculiarities": [
"Swimming pool",
"River-view rooms",
"Sunset cruises"
]
}
},
{
"id": 13,
"name": "Hwange Safari Lodge",
"address": "Hwange National Park, Zimbabwe",
"minimalPrice": 300,
"priceForIt": "Starting from \$300",
"rating": 4,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/hwangeSafariLodge/image1.jpg",
"https://example.com/hwangeSafariLodge/image2.jpg"
],
"about_the_hotel": {
"description": "Hwange Safari Lodge is a luxury safari lodge located in the heart of Hwange National Park, offering an authentic and immersive wildlife experience.",
"peculiarities": [
"Game drives",
"Bush walks",
"Infinity pool"
]
}
},
{
"id": 14,
"name": "Mana Pools Safari Camp",
"address": "Mana Pools National Park, Zimbabwe",
"minimalPrice": 350,
"priceForIt": "Starting from \$350",
"rating": 5,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/manaPoolsSafariCamp/image1.jpg",
"https://example.com/manaPoolsSafariCamp/image2.jpg"
],
"about_the_hotel": {
"description": "Mana Pools Safari Camp is a luxurious tented camp located in the heart of the UNESCO World Heritage Site of Mana Pools National Park.",
"peculiarities": [
"Game drives",
"Canoeing",
"Guided walks"
]
}
},
{
"id": 15,
"name": "Caribbea Bay Resort",
"address": "Kariba, Zimbabwe",
"minimalPrice": 180,
"priceForIt": "Starting from \$180",
"rating": 4,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/caribbeaBayResort/image1.jpg",
"https://example.com/caribbeaBayResort/image2.jpg"
],
"about_the_hotel": {
"description": "Caribbea Bay Resort is a beachfront resort located on the shores of Lake Kariba, offering a perfect blend of relaxation and water-based activities.",
"peculiarities": [
"Swimming pool",
"Water sports",
"Restaurants and bars"
]
}
},
{
"id": 16,
"name": "Gorges Lodge",
"address": "Batoka Gorge, Zambezi River, Zimbabwe",
"minimalPrice": 280,
"priceForIt": "Starting from \$280",
"rating": 4,
"ratingName": "Excellent",
"imageUrls": [
"https://example.com/gorgesLodge/image1.jpg",
"https://example.com/gorgesLodge/image2.jpg"
],
"about_the_hotel": {
"description": "Gorges Lodge is a luxury eco-lodge perched on the edge of the Batoka Gorge, offering stunning views of the Zambezi River and the surrounding wilderness.",
"peculiarities": [
"Hiking trails",
"River activities",
"Wildlife viewing"
]
}
},
  ];

  List<Hotel> hs = [];
print("Hotels length... = "+  hotels.length.toString());

   


  for (var i = 0; i < hotels.length ; i++) {

 List<String> images = [];

for (var i = 0; i < 3; i++) {
  int imgNum=Random().nextInt(26)+1;
  String imgUrl="assets/hotels/hotel"+imgNum.toString()+".jpg";
  images.add(imgUrl);
}

    HotelInfo info = HotelInfo(
        description: hotels[i]["about_the_hotel"]["description"],
        peculiarities: hotels[i]["about_the_hotel"]["peculiarities"]);

    Hotel h = Hotel(
      id: hotels[i]["id"],
      name: hotels[i]["name"],
      address: hotels[i]["address"],
      minimalPrice: hotels[i]["minimalPrice"],
      priceForIt: hotels[i]["priceForIt"],
      rating: hotels[i]["rating"],
      ratingName: hotels[i]["ratingName"],
      imageUrls: images,
      aboutTheHotel: info,
    );

    hs.add(h);
  }

  print(hotels[0]["name"]); // Output: "Hotel A"

  return hs;
}
