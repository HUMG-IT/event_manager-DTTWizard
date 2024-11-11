import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:event_manager/event/event_model.dart';
import 'package:event_manager/event/event_service.dart';

class EventDetailView extends StatefulWidget {
  const EventDetailView({super.key, required EventModel event});
  
  get event => null;
  


  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  final subjectController = TextEditingController();
  final notesController = TextEditingController();
  final eventService = EventService();
  @override
  void initState(){
    super.initState();
    subjectController.text = widget.event.subject;
    notesController.text =widget.event.notes??'';
  }
   Future<void> pickDateTime({required bool isStart}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate:isStart ? widget.event.startTime : widget.event.endTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
if(pickedDate!=null){
  if(!mounted)return;
  final pickedTime =await showTimePicker(
    context:context,
    initialTime: TimeOfDay.fromDateTime(
      isStart?widget.event.startTime :widget.event.endTime,
    ),
  
  );
  if (pickedTime != null) {
  setState(() {
    final newDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    if (isStart) {
      widget.event.startTime = newDateTime;
      if (widget.event.startTime.isAfter(widget.event.endTime)) {
       //tự thiết lập endtime 1 tiếng sau khi starttime
        widget.event.endTime = widget.event.startTime.add(const Duration(hours: 1));
      }
    }
  });
}
}
    
  }
  Future<void>_saveEvent()async{
widget.event.subject =subjectController.text;
widget.event.notes = notesController.text;
await eventService.saveEvent(widget.event);
if(!mounted)return;
Navigator.of(context).pop(true);//trở về màn hình trước đó
  }
Future<void> _deleteEvent()async{
  await eventService.deleteEvent(widget.event);
  if(!mounted)return;
Navigator.of(context).pop(true);// trở về màn hình trước đó
}
  @override
  Widget build(BuildContext context) {
   final al = AppLocalizations.of(context)!;
return Scaffold(
  appBar: AppBar(
    title: Text(widget.event.id == null ? al.addEvents:al.eventDetails),
  ),
);
  }

}


