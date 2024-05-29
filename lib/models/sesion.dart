class Sesion{
  final String token;
  final int expiresIn;
  final DateTime createdAt;

  Sesion({
    required this.token,
    required this.expiresIn,
    required this.createdAt}
    );

    static Sesion fromJson(Map<String, dynamic> json){
      return Sesion(
        token: json['token'],
        expiresIn: json['expiresIn'],
        createdAt: DateTime.parse(json['createdAt']),
        );
    }

    Map<String, dynamic> toJson(){
      return {
        "token": this.token,
        "expiresIn": this.expiresIn,
        "createdAt": this.createdAt.toIso8601String(),
      };
    }


}