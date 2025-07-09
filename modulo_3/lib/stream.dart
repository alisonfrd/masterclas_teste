Stream<String> getStreamList() async* {
  yield 'Masterclass';
  await Future.delayed(Duration(milliseconds: 500));
  yield 'Flutter';
}
