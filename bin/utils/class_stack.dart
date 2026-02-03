class Stack<T> {
  final List<T> _items = [];

  void push(T item) => _items.add(item);

  T pop() => _items.removeLast();
  T peek() => _items.last;

  int get length => _items.length;
  bool get isEmpty => _items.isEmpty;

  @override
  String toString() => _items.toString();
}
