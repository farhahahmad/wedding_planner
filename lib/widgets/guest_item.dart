import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/card_model.dart';
import '../model/guest_model.dart';
import '../constants/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class GuestItem extends StatelessWidget {
  final GuestModel guest;
  final CardModel card;
  final onToDoChanged;
  final onDeleteItem;

  const GuestItem({
    Key? key,
    required this.guest,
    required this.card,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // onToDoChanged(guest);
          guest.isDone ? 
          onToDoChanged(guest): 
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: const Text("Invite Guest", style: TextStyle(fontSize: 15)),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 80,
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: HexColor("#C0ABAF")
                        ),
                        child: const Text('Send Invitation Card', style: TextStyle(fontSize: 15)),
                        onPressed: () async {
                          final response = await http.get(Uri.parse(card.cardImage!));
                          final bytes = response.bodyBytes;
                          final directory = await Directory.systemTemp.create();
                          final filePath = '${directory.path}/file.png';
                          File file = await File(filePath).writeAsBytes(bytes);
                          XFile newFile = XFile(file.path);
                          final result = await Share.shareXFiles([newFile], text: 'We would be honored to have you join us in celebrating our special day.');
                          if (result.status == ShareResultStatus.success) {
                            onToDoChanged(guest);
                          }
                          Navigator.pop(context);
                        },
                      )
                    ),
                    Container(
                      height: 80,
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: HexColor("#C0ABAF")
                        ),
                        child: const Text('Set Guest as Invited', style: TextStyle(fontSize: 15)),
                        onPressed: () {
                          onToDoChanged(guest);
                          Navigator.pop(context);
                        },
                      )
                    ),
                  ]
                ),
              ),
            )
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          guest.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: HexColor("#489363"),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              guest.name!,
              style: TextStyle(
                color: tdBlack,
                decoration: guest.isDone ? TextDecoration.lineThrough : null,
                fontSize: 15
              ),
            ),
            const SizedBox(height: 5),
            Text(
              guest.address!,
              style: TextStyle(
                color: Colors.grey,
                decoration: guest.isDone ? TextDecoration.lineThrough : null,
                fontSize: 15
              ),
            ),
          ],
        ),
        trailing: 
        // Row(
        //   children: [
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: HexColor("#C0ABAF"),
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  onDeleteItem(guest);
                },
              ),
            ),
            // IconButton(
            //   onPressed: (){
            //     showDialog(
            //       context: context, 
            //       builder: (context) => AlertDialog(
            //         title: Text("Send Invitation Card", style: TextStyle(fontSize: 15)),
            //         // content: 
            //         // actions: [
            //         //   TextButton(
            //         //     onPressed: (){
            //         //       _con.addGuest(_nameController.text, _addressController.text);
            //         //       _nameController.clear();
            //         //       _addressController.clear();
            //         //       Navigator.of(context).pop();
            //         //     },
            //         //     child: Text("Add", style: TextStyle(fontSize: 15))
            //         //   )
            //         // ],
            //       )
            //     );
            //   }, 
            //   icon: Icon(
            //     Icons.forward_to_inbox_outlined,
            //     color: HexColor("#B69EA2")
            //   )
            // )
        //   ],
        // ),
      ),
    );
  }
}