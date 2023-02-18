// Paintings

List<Map> paintings = [
  {
    'image': 'assets/paintings/painting6.jpeg',
    'name': 'The Sower',
  },
  {
    'image': 'assets/paintings/painting2.jpg',
    'name': 'The Starry Night',
  },
  {
    'image': 'assets/paintings/painting3.jpg',
    'name': 'The Potato Eaters',
  },
  {
    'image': 'assets/paintings/painting4.jpg',
    'name': 'Irises',
  },
  {
    'image': 'assets/paintings/painting5.jpg',
    'name': 'Starry Night Over the Rhône',
  },
  {
    'image': 'assets/paintings/painting7.jpg',
    'name': 'Landscape with Snow',
  },
  {
    'image': 'assets/paintings/painting8.jpg',
    'name': 'The Night Café',
  },
];

class Painting {
  String image;
  String name;
  Painting({
    required this.image,
    required this.name,
  });
}

List<Painting> myPaintings = List.generate(
    paintings.length,
    (index) => Painting(
        image: paintings[index]['image'],
        name: paintings[index]['name']));

/// Places
class Place {
  String image;
  String name;
  Place({
    required this.image,
    required this.name,
  });
}

// Vertical
List<Map> placesVertical = [
  {
    'image': 'assets/places/vertical/australia.jpg',
    'name': 'Australia',
  },
  {
    'image': 'assets/places/vertical/canada.jpg',
    'name': 'Canada',
  },
  {
    'image': 'assets/places/vertical/indonesia.jpg',
    'name': 'Indonesia',
  },
  {
    'image': 'assets/places/vertical/italy.jpg',
    'name': 'Italy',
  },
  {
    'image': 'assets/places/vertical/japan.jpg',
    'name': 'Japan',
  },
  {
    'image': 'assets/places/vertical/newzealand.jpg',
    'name': 'New Zealand',
  },
  {
    'image': 'assets/places/vertical/paris.jpg',
    'name': 'Paris',
  },
  {
    'image': 'assets/places/vertical/singapore.jpg',
    'name': 'Singapore',
  },
];

List<Place> myPlacesVertical = List.generate(
    placesVertical.length,
    (index) => Place(
        image: placesVertical[index]['image'],
        name: placesVertical[index]['name']));

// Horizontal
List<Map> placesHorizontal = [
  {
    'image': 'assets/places/horizontal/australia.jpg',
    'name': 'Australia',
  },
  {
    'image': 'assets/places/horizontal/canada.jpg',
    'name': 'Canada',
  },
  {
    'image': 'assets/places/horizontal/indonesia.jpg',
    'name': 'Indonesia',
  },
  {
    'image': 'assets/places/horizontal/italy.jpg',
    'name': 'Italy',
  },
  {
    'image': 'assets/places/horizontal/japan.jpg',
    'name': 'Japan',
  },
  {
    'image': 'assets/places/horizontal/newzealand.jpg',
    'name': 'New Zealand',
  },
  {
    'image': 'assets/places/horizontal/paris.jpg',
    'name': 'Paris',
  },
  {
    'image': 'assets/places/horizontal/singapore.jpg',
    'name': 'Singapore',
  },
];

List<Place> myPlacesHorizontal = List.generate(
    placesHorizontal.length,
    (index) => Place(
        image: placesHorizontal[index]['image'],
        name: placesHorizontal[index]['name']));

class MiltipleImage {
  String fg;
  String bg;
  String name;
  MiltipleImage({
    required this.fg,
    required this.bg,
    required this.name,
  });
}

List<Map> multiplePlaces = [
  {
    'imagef': 'assets/fg_bg/christ_fg.png',
    'imageb': 'assets/fg_bg/christ_bg.png',
    'name': 'Brazil',
  },
  {
    'imagef': 'assets/fg_bg/mountain_fg.png',
    'imageb': 'assets/fg_bg/paris_bg.jpg',

    'name': 'Iceland',
  },
  {
    'imagef': 'assets/fg_bg/paris_fg.png',
    'imageb': 'assets/fg_bg/mountain_bg.jpg',

    'name': 'Paris',
  },
];

List<MiltipleImage> myMultiplePlaces = List.generate(
    multiplePlaces.length,
    (index) => MiltipleImage(
        fg: multiplePlaces[index]['imagef'],
        bg: multiplePlaces[index]['imageb'],
        name: multiplePlaces[index]['name']));

//////////
///

// List<Map> yeahh = [
//   {
//     'imagef': 'assets/fgbg/christfg.png',
//     'imageb': 'assets/fgbg/christbg.jpg',
//     'name': 'Brazil',
//   },
//   {
//     'imagef': 'assets/fgbg/japanfg.png',
//     'imageb': 'assets/fgbg/ingobg.jpg',
//     'name': 'Indonesia',
//   },
//   {
//     'imagef': 'assets/fgbg/indofg.png',
//     'imageb': 'assets/fgbg/japanbg.jpg',
//     'name': 'Iceland',
//   },
// ];

// List<MiltipleImage> yesss = List.generate(
//     yeahh.length,
//     (index) => MiltipleImage(
//         fg: yeahh[index]['imagef'],
//         bg: yeahh[index]['imageb'],
//         name: yeahh[index]['name']));
