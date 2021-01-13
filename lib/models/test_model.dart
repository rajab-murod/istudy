class Test {
  int id;
  int lesson_id;
  String question;
  int answer;

  Test({this.id, this.lesson_id, this.question, this.answer});

  factory Test.fromJson(Map<String, dynamic> json){
    return Test(
        id: json['id'],
        lesson_id: json['lesson_id'],
        question: json['question'],
        answer: json['answer'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lesson_id': lesson_id,
      'question': question,
      'answer': answer,
    };
  }

  static List<Test> test_lists = [
    Test(
      id: 1,
      lesson_id: 1,
      question: 'q1',
      answer: 1
    ),
    Test(
        id: 2,
        lesson_id: 1,
        question: 'q2',
        answer: 3
    ),
  ];

}

class Variant {
  int id;
  int test_id;
  String variant_text;

  Variant({this.id, this.test_id, this.variant_text});

  factory Variant.fromJson(Map<String, dynamic> json){
    return Variant(
      id: json['id'],
      test_id: json['test_id'],
      variant_text: json['variant_text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'test_id': test_id,
      'variant_text': variant_text,
    };
  }

  static List<Variant> variant_lists = [
    //variant for test 1
    Variant(
      id: 1,
      test_id: 1,
      variant_text: 'v1'
    ),
    Variant(
        id: 2,
        test_id: 1,
        variant_text: 'v2'
    ),
    Variant(
        id: 3,
        test_id: 1,
        variant_text: 'v3'
    ),
    Variant(
        id: 4,
        test_id: 1,
        variant_text: 'v4'
    ),

    //variant for test 2
    Variant(
        id: 5,
        test_id: 2,
        variant_text: 'vv1'
    ),
    Variant(
        id: 6,
        test_id: 2,
        variant_text: 'vv2'
    ),
    Variant(
        id: 7,
        test_id: 2,
        variant_text: 'vv3'
    ),
    Variant(
        id: 8,
        test_id: 2,
        variant_text: 'vv4'
    ),
  ];

}