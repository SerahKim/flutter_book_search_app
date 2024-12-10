import 'package:flutter/material.dart';
import 'package:flutter_book_search/ui/home/home_view_model.dart';
import 'package:flutter_book_search/ui/home/widgets/home_bottom_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    //TextEditingController 사용시에는 반드시 dispose 호출해줘야 메모리에서 소거됨.
    textEditingController.dispose();
    //함수를 재정의할 때는 원래 구현되어 있던 dispose 메서드를 호출해줘야함
    super.dispose();
  }

  void onSearch(String text) {
    // ref
    // TODO: 홈뷰모델의 searchBooks 메서드 호출
    ref.read(homeViewModelProvider.notifier).searchBooks(text);
    print('onSearch 호출됨');
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    return GestureDetector(
      onTap: () {
        //빈 화면을 클릭했을 때 키보드가 내려가는 기능
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                onSearch(textEditingController.text);
              },
              //버튼의 터치영역은 44 디바이스 픽셀 이상으로 해야 버튼 터치 실수가 적음.(UX)
              child: Container(
                width: 50,
                height: 50,
                //컨테이너에 배경색이 없으면 자녀 위젯에만 터치 이벤트가 적용됨
                color: Colors.transparent,
                child: Icon(Icons.search),
              ),
            ),
          ],
          title: TextField(
            maxLines: 1,
            onSubmitted: onSearch,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: '검색어를 입력해주세요.',
              border: MaterialStateUnderlineInputBorder.resolveWith(
                (states) {
                  //검색창을 눌렀을 경우
                  if (states.contains(WidgetState.focused)) {
                    return OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    );
                  }
                  //검색창을 누르지 않았을 경우
                  return OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(20),
          itemCount: homeState.books.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final book = homeState.books[index];
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return HomeBottomSheet(book);
                  },
                );
              },
              child: Image.network(book.image),
            );
          },
        ),
      ),
    );
  }
}
