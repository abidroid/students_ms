class Student {
  late int? id;
  late String name;
  late String course;
  late String mobile;
  late int totalFee;
  late int feePaid;

  Student({
    this.id,
    required this.name,
    required this.course,
    required this.mobile,
    required this.totalFee,
    required this.feePaid,
  });

  // function to convert object to map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['name'] = name;
    map['course'] = course;
    map['mobile'] = mobile;
    map['totalFee'] = totalFee;
    map['feePaid'] = feePaid;

    return map;
  }

  // function to convert map to object
  // named constructor

  Student.fromMap( Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    course = map['course'];
    mobile = map['mobile'];
    totalFee = map['totalFee'];
    feePaid = map['feePaid'];
  }


}
