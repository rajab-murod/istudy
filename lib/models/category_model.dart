class Category{
  int id;
  String name;
  String image;

  Category({this.id, this.name, this.image});

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  static List<Category> list_categories = [
    Category(
      id: 1,
      name: 'Chemistry',
      image: 'assets/category/chemistry.png'
    ),
    Category(
        id: 2,
        name: 'Business',
        image: 'assets/category/stats.png'
    ),
    Category(
        id: 3,
        name: 'IT & Software',
        image: 'assets/category/it.png'
    ),
    Category(
        id: 4,
        name: 'English',
        image: 'assets/category/language.png'
    ),
    Category(
        id: 5,
        name: 'Psychology',
        image: 'assets/category/mental.png'
    ),
    Category(
        id: 6,
        name: 'Mathematics',
        image: 'assets/category/mathematics.png'
    ),
  ];
}