class Fact {
  final String id;
  final String text;
  final String source;
  final String sourceUrl;
  final String language;
  final String permalink;

  const Fact({
    required this.id,
    required this.text,
    required this.source,
    required this.sourceUrl,
    required this.language,
    required this.permalink,
  });

  factory Fact.fromJson(Map<String, dynamic> json) {
    return Fact(
      id: json['id'] as String,
      text: json['text'] as String,
      source: json['source'] as String,
      sourceUrl: json['source_url'] as String,
      language: json['language'] as String,
      permalink: json['permalink']as String,
    );
  }
}
