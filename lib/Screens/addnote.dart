import 'package:database_flutter/provider/note_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:database_flutter/models/note_model.dart';
import 'package:provider/provider.dart';

class Addnote extends StatelessWidget{
bool isupdate;
String title;
String desc;
int sno;
TextEditingController titleController = TextEditingController();
TextEditingController descController = TextEditingController();
Addnote ({this.isupdate = false,this.sno = 0,this.title = "",this.desc =""});

  @override
  Widget build(BuildContext context) {
  if (isupdate){
  titleController.text = title;
  descController.text = desc;
  }
    return Scaffold(
      appBar: AppBar(
        title: Text(isupdate ? "Update Note":"Add a note",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.6
            +MediaQuery.of(context).viewInsets.bottom,
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Text(isupdate ? "Update Note":"Add a note",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 21,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Enter title here",
                  label: Text("Title*"),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  )
              ),
            ),
            SizedBox(
              height: 21,
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                  hintMaxLines: 4,
                  hintText: "Enter Describe here",
                  label: Text("Description*"),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  )
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Row(
              children: [
                Expanded(child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            width: 1
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11)
                        )
                    ),
                    onPressed: ()async{
                      var title = titleController.text;
                      var description = descController.text;
                      if(title.isNotEmpty && description.isNotEmpty) {
                        final note = NoteModel(
                          id: isupdate ? sno : null,
                          title: title,
                          description: description,
                        );

                        if (isupdate) {
                          await context.read<DbProvider>().updateNote(note);
                        } else {
                          await context.read<DbProvider>().addNote(note);
                        }

                        Navigator.pop(context);

                      }
                       /* await dbref!.addNote(mTitle: title, mDesc: description);
                        if(check){
                        Navigator.pop(context);
                        }
                        
                      }*/
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please fill all the required blanks!!"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 5),
                          ),
                        );
                      }
                      titleController.clear();
                      descController.clear();
                    }, child: Text(isupdate? "Update Note": "Add note"))),
                SizedBox(
                  width: 11,
                ),
                Expanded(child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            width: 1
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11)
                        )
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel"))),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
}