import 'dart:convert';

import 'package:flutter_book_search/data/model/book.dart';
import 'package:http/http.dart';

class BookRepository {
  Future<List<Book>> searchBooks(String query) async {
    final client = Client();
    final response = await client.get(
        Uri.parse('https://openapi.naver.com/v1/search/book.json?query=$query'),
        headers: {
          'X-Naver-Client-Id': '0yfUM5Jprc7tjhlJeYiQ',
          'X-Naver-Client-Secret': 'lgV0PZ_MuV'
        });

    // Get 요청 시 성공 => 200
    // 응답 코드가 200일 때
    //    body데이터를 jsonDecode 함수 사용해서 map으로 바꾼 후 List<Book>로 반환
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      final items = List.from(map['items']);
      // MaooedIterable 이라는 클래스에 함수를 넘겨줄테니
      // 나중에 요청하면, 그때 List(item)들을 하나씩 반복문을 돌면서
      // 내가 넘겨준 함수를 실행시켜서 새로운 리스트로 돌려줘!
      final iterable = items.map((e) {
        return Book.fromJson(e);
      });

      final list = iterable.toList();
      return list;
    }

    //    빈 리스트 반환
    return [];
  }
}
