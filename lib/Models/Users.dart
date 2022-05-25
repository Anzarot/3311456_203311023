class User{
  final String ?userID;
  final String ?userEMail;
  final String ?userPassword;

  User({this.userID,this.userEMail,this.userPassword});

  Map<String,dynamic> toMap(){
    return {
      'userID': userID,
      'userEMail': userEMail,
      'userPassword': userPassword
    };
  }

User.fromFirestore(Map<String, dynamic> firestore):
userID = firestore['userID'],
userEMail = firestore['userEMail'],
userPassword = firestore['userPassword'];
}