class MessageProvider {
  String title = "";
  String message = "";
  bool needToLog = false;

  void createMessage(String title, String message){
    this.setMessage(message);
    this.setTitle(title);
    this.needToLog = true;
  }
  void setMessage(String message){
    this.message = message;
  }

  void setTitle(String title){
    this.title = title;
  }

  String getMessage(){
    this.needToLog = false;
    return this.message;
  }

  String getTitle(){
    return this.title;
  }





}