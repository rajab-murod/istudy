
class Lesson{
  int id;
  int category_id;
  String title;
  String content;
  int week;
  int hour;
  String image;


  Lesson({this.id, this.category_id, this.title, this.content, this.week, this.hour, this.image});

  factory Lesson.fromJson(Map<String, dynamic> json){
    return Lesson(
      id: json['id'],
      category_id: json['category_id'],
      title: json['title'],
      content: json['content'],
      week: json['week'],
      hour: json['hour'],
      image: json['image']
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': category_id,
      'title': title,
      'content': content,
      'week': week,
      'hour': hour,
      'image': image,
    };
  }


  static List<Lesson> lesson_lists = [
    Lesson(
        id: 1,
        category_id: 2,
        title: 'Big Data Analytics: Challenges and the Future',
        content: 'Big data analytics helps us to understand the huge volume of information our world now generates. We can use analytics to uncover hidden patterns, predict trends, gauge customer opinions and so much more.',
        week: 1,
        hour: 6,
        image: 'assets/courses/analytics.png'
    ),
    Lesson(
        id: 2,
        category_id: 1,
        title: 'A History of Public Health in Post-War Britain',
        content: 'History can offer us a unique insight into the public health problems, policies, and practices of the past, and is of critical importance to our understanding of healthcare in the contemporary world.',
        week: 2,
        hour: 4,
        image: 'assets/courses/biological.png'
    ),
    Lesson(
        id: 3,
        category_id: 3,
        title: 'An Introduction to Cryptography',
        content: 'During the course you will also get an opportunity to try encrypting data yourself by completing a cryptography and cryptanalysis challenge.',
        week: 1,
        hour: 2,
        image: 'assets/courses/consulting.png'
    ),
    Lesson(
        id: 4,
        category_id: 5,
        title: 'Neuroplasticians and Neuromyths',
        content: 'Many neuromyths abound and educators have often been at the forefront of promulgating them. This sample course exposes these misconceptions.',
        week: 2,
        hour: 4,
        image: 'assets/courses/mental-health.png'
    ),
    Lesson(
        id: 5,
        category_id: 1,
        title: 'A History of Public Health in Post-War Britain',
        content: 'History can offer us a unique insight into the public health problems, policies, and practices of the past, and is of critical importance to our understanding of healthcare in the contemporary world.',
        week: 2,
        hour: 4,
        image: 'assets/courses/biological.png'
    ),
    Lesson(
        id: 6,
        category_id: 1,
        title: 'A History of Public Health in Post-War Britain',
        content: 'History can offer us a unique insight into the public health problems, policies, and practices of the past, and is of critical importance to our understanding of healthcare in the contemporary world.',
        week: 2,
        hour: 4,
        image: 'assets/courses/biological.png'
    ),
    Lesson(
        id: 7,
        category_id: 1,
        title: 'A History of Public Health in Post-War Britain',
        content: 'History can offer us a unique insight into the public health problems, policies, and practices of the past, and is of critical importance to our understanding of healthcare in the contemporary world.',
        week: 2,
        hour: 4,
        image: 'assets/courses/biological.png'
    ),
    Lesson(
        id: 8,
        category_id: 1,
        title: 'A History of Public Health in Post-War Britain',
        content: 'History can offer us a unique insight into the public health problems, policies, and practices of the past, and is of critical importance to our understanding of healthcare in the contemporary world.',
        week: 2,
        hour: 4,
        image: 'assets/courses/biological.png'
    ),
  ];
}