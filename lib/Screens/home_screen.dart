import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/addnote.dart';
import '../Screens/settings_screen.dart';
import '../models/note_model.dart';
import '../provider/note_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState  extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Notes",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          actions: [

            IconButton(
              icon: const Icon(Icons.settings),
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),

          ]
      ),
      body: Consumer<DbProvider>(builder: (ctx, Provider, __) {
        List<NoteModel> allNotes = Provider.notes;
        return allNotes.isNotEmpty ?
        ListView.builder(
            itemCount: allNotes.length, itemBuilder: (_, index) {
          return ListTile(
            leading: Text("${index + 1}"),
            title: Text(allNotes[index].title),
            subtitle: Text(allNotes[index].description),
            trailing: SizedBox(
              width: 50,
              child: Row(
                children: [
                  InkWell(onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) =>
                        Addnote(
                          isupdate: true,
                          title: allNotes[index].title,
                          desc: allNotes[index].description,
                          sno: allNotes[index].id!,
                        )));
                  },
                      child: Icon(Icons.edit)),
                  InkWell(
                    onTap: () async {
                      bool? delete = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Delete Note"),
                            content: const Text(
                              "Are you sure you want to delete this note?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );

                      if (delete == true) {
                        context.read<DbProvider>().deleteNote(
                          allNotes[index].id!,
                        );
                      }
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),

                  ),
                ],
              ),
            ),
          );
        }) : Center(
          child: Text("No notes is yet!!"),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addnote()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}