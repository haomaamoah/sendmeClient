const List<String> bread = ["Tea","Butter","Sugar","Wheat"];

const List<String> meat = ["Goat","Sheep","Chicken","Cow","Pig","Egg","Crab"];

const List<String> egg = ["Boiled","Fried"];

const List<String> fish = ["Salmon","Red Fish","Tilapia"];

const List<String> soup = ["Palmnut","Light","Groundnut"];

const List<String> nonAlcohol = ["Water","Coca Cola","Fanta","Malta Guiness","Beta Malt","Sobolo"];

const List<String> alcohol = ["Guiness","Club Beer"];

const List<Map> drinks = [
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Fnon-alcohol.jpeg?alt=media&token=be4c8465-446a-40d4-b58c-be32e737d72a",
    "name": "Non - Alcohol",
    "description": "Chilled non-alcoholic beverage to quench your thirst.",
    "meat": false,"fish": false,"soup": false,"bread": nonAlcohol,"type": false
  },
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Falcohol.jpeg?alt=media&token=f5f327b3-e4a4-420e-b9b8-978132ce8d2d",
    "name": "Alcohol",
    "description": "Refrigerated alcoholic beverages for recreational consumption.\nDRINK RESPONSIBLY!",
    "meat": false,"fish": false,"soup": false,"bread": alcohol,"type": false
  },
];

const List<Map> snacks = [
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Fplantain-chips.jpeg?alt=media&token=03f171d6-5c01-4ada-8b64-353778ee8313",
    "name": "Plantain Chips",
    "description": "Sweet plantain chips fried in vegetable oil.",
    "meat": false,"fish": false,"soup": false,"bread": false,"type": ["Ripe","Unripe"]
  },
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Fbiscuits.jpeg?alt=media&token=4c333d6b-5f38-4080-9b0e-f95726c36324",
    "name": "Biscuits",
    "description": "Delicious biscuits made by factories located in Ghana.",
    "meat": false,"fish": false,"soup": false,"bread": ["Perk","NutriSnax"],"type": false
  }
];

const List<Map> local = [
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Ffufu.jpeg?alt=media&token=1643df06-53a0-4afc-aceb-f1a329b6bdd1",
    "name": "Fufu",
    "description": "Pounded yam/cassava with hot light,groundnut or palmnut soup.",
    "meat": meat,"fish": fish,"soup": soup,"bread": false,"type": false
  },
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Ftuozaafi.jpeg?alt=media&token=2b2e2299-9f5f-4930-87cc-ae36f521a699",
    "name": "Tuozaafi",
    "description": "Pounded corn mixed with flour with hot light,groundnut or palmnut soup.",
    "meat": meat,"fish": fish,"soup": false,"bread": false,"type": false
  },
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Fbanku.jpeg?alt=media&token=a1177a55-708f-4aac-b085-1e826d0549aa",
    "name": "Banku",
    "description": "Kneaded maize with hot light,groundnut or palmnut soup.",
    "meat": meat,"fish": fish,"soup": ["Pepper",...soup],"bread": false,"type": false
  }
];

const List<Map> continental = [
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Fnoodles.jpeg?alt=media&token=4bcafb79-d201-459f-9a73-fd78e2be2042",
    "name": "Noodles",
    "description": "Fresh noodles from Indonesia and Nigeria.",
    "meat": meat,"fish": fish,"soup": false,"bread": false,"type": false
  },
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Ffriedrice.jpeg?alt=media&token=7a365c08-254f-450d-8b9f-4d6b723546ed",
    "name": "Fried Rice",
    "description": "Braised rice with vegetables and pepper sauce.",
    "meat": meat,"fish": fish,"soup": false,"bread": false,"type": false

  },
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Fjollof.jpeg?alt=media&token=27c6a5fb-38d8-4828-a862-45f08412388c",
    "name": "Jollof",
    "description": "Rice cooked in stew and mixed with vegetables.",
    "meat": meat,"fish": fish,"soup": false,"bread": false,"type": false
  },
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Fsalad.jpeg?alt=media&token=7179b35d-6e8c-4e5c-866a-da9140339aaa",
    "name": "Salad",
    "description": "Assorted mixture of fruits or vegetables.\nFresh for consumption from local groceries and fruit stands.",
    "meat": ["Chicken"],"fish": ["Sardine"],"soup": false,"bread": true,"type": ["Vegetable","Fruit"]
  },
];

const List<Map> breakfast = [
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Fkoko.jpeg?alt=media&token=323e85bc-0754-40e1-8f38-f2f46fb8c540",
    "name": "Porridge",
    "description": "Cooked powder maize with a touch of ginger",
    "meat": false,"fish": false,"soup": false,"bread": ["Koose",...bread],"type": false
  },
  {
    "img": "https://firebasestorage.googleapis.com/v0/b/sendme-client.appspot.com/o/foods%2Ftea.jpeg?alt=media&token=da347542-7ece-4207-844e-353952dff261",
    "name": "Tea",
    "description": "Chocolate drink or boiled tea leaves.",
    "meat": egg,"fish": false,"soup": false,"bread": bread,"type": ["Chocolate","Tea Bag"]
  }
];

const List<Map> lunch = [
  ...local,...continental
];

const List<Map> foods = [
  ...breakfast,...lunch,...drinks,...snacks
];


