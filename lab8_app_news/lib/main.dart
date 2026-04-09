import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Лента новостей КубГАУ',
      home: MyHomePage(),
    );
  }
}

class News {
  final String id;
  final String activeFrom;
  final String title;
  final String previewText;
  final String previewPictureSrc;
  final String detailPageUrl;
  final String detailText;

  const News({
    required this.id,
    required this.activeFrom,
    required this.title,
    required this.previewText,
    required this.previewPictureSrc,
    required this.detailPageUrl,
    required this.detailText,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['ID'] as String,
      activeFrom: json['ACTIVE_FROM'] as String,
      title: Bidi.stripHtmlIfNeeded(json['TITLE'] as String),
      previewText: Bidi.stripHtmlIfNeeded(json['PREVIEW_TEXT'] as String),
      previewPictureSrc: json['PREVIEW_PICTURE_SRC'] as String,
      detailPageUrl: json['DETAIL_PAGE_URL'] as String,
      detailText: Bidi.stripHtmlIfNeeded(json['DETAIL_TEXT'] as String),
    );
  }
}

Future<List<News>> fetchNews() async {
  final response = await http.get(
    Uri.parse(
      'https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90',
    ),
  );
  return parseNews(response.body);
}

List<News> parseNews(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<News>((json) => News.fromJson(json)).toList();
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Лента новостей КубГАУ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<List<News>>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка запроса: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return NewsList(news: snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.news});
  final List<News> news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return NewsCard(news: news[index]);
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            news.previewPictureSrc,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: const Icon(Icons.error),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.activeFrom,
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  news.previewText,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
