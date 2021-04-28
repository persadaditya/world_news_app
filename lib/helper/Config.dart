class Config{
  static String baseUrl = "newsapi.org";
  static String topHeadline = "/v2/top-headlines";
  static Map<String, dynamic> queryHeadline() {
    return {"category" : "general", "country" : "us", "apiKey": apiKey};
  }

  static String apiKey = "YOUR-API-KEY-HERE";

  static Map<String, dynamic> queryCategoryHeadline(String category){
    return {"category" : category, "country" : "us", "apiKey": apiKey};
  }
}