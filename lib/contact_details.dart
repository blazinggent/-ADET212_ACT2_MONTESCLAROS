class ContactDetails {
  int? id;
  String name;
  String mobileNumber;
  String emailAddress;

  ContactDetails(
      {this.id,
      required this.name,
      required this.mobileNumber,
      required this.emailAddress});

  factory ContactDetails.fromJson(Map<String, dynamic> json) => ContactDetails(
      id: json['id'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      emailAddress: json['emailAddress']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mobileNumber': mobileNumber,
        'emailAddress': emailAddress
      };
}
