class ErrorResponse {
  ErrorResponse({
    this.data,
    required this.message,
    required this.status,
  });
  late final Null data;
  late final String message;
  late final int status;

  ErrorResponse.fromJson(Map<String, dynamic> json){
    data = null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data;
    _data['message'] = message;
    _data['status'] = status;
    return _data;
  }
}