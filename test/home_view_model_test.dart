import 'package:flutter_book_search/ui/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "HomeViewModel test",
    () async {
      // 앱내에서는 ProviderScope 안에서 뷰모델 관리
      // 테스트 환경에서 Widget을 생성하지 않고 테스트할 수 있게 ProviderContainer 제공
      final providerConatiner = ProviderContainer();
      addTearDown(providerConatiner.dispose);
      final homeVm = providerConatiner.read(homeViewModelProvider.notifier);

      // 처음 HomeViewModel의 상태 ==> 빈 리스트 테스트
      final firstState = providerConatiner.read(homeViewModelProvider);
      expect(firstState.books.isEmpty, true);

      // HomeViewModeldptj searchBooks 메서드 호출 후 상태 변경이 정상적으로 되는지 테스트
      await homeVm.searchBooks('harry');
      final afterState = providerConatiner.read(homeViewModelProvider);
      expect(afterState.books.isEmpty, false);

      afterState.books.forEach(
        (element) {
          print(element.toJson());
        },
      );
    },
  );
}
