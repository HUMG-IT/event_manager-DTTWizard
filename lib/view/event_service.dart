import 'package:localstore/localstore.dart';
import 'event_model.dart';

class EventService {
  final db = Localstore.instance;
  final String collectionPath = 'events'; // Tên collection cho sự kiện

  /// Lấy danh sách tất cả sự kiện từ localstore.
  Future<List<EventModel>> getAllEvents() async {
    final eventsMap = await db.collection(collectionPath).get();

    if (eventsMap != null) {
      return eventsMap.entries.map((entry) {
        final data = entry.value as Map<String, dynamic>;
        data['id'] = entry.key; // Đặt ID từ key của tài liệu
        return EventModel.fromMap(data);
      }).toList();
    }
    return [];
  }

  /// Thêm hoặc cập nhật một sự kiện vào localstore.
  ///
  /// [event] là đối tượng EventModel cần lưu trữ.
  Future<void> addOrUpdateEvent(EventModel event) async {
    try {
      final eventData = event.toMap();
      await db.collection(collectionPath).doc(event.id).set(eventData);
    } catch (e) {
      print('Lỗi khi thêm hoặc cập nhật sự kiện: $e');
    }
  }

  /// Xóa một sự kiện khỏi localstore bằng ID.
  ///
  /// [id] là ID của sự kiện cần xóa.
  Future<void> deleteEvent(String id) async {
    try {
      await db.collection(collectionPath).doc(id).delete();
    } catch (e) {
      print('Lỗi khi xóa sự kiện: $e');
    }
  }

  saveEvent(event) {}
}
