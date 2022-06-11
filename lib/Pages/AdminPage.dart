import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maestro2/Models/Users.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:maestro2/Services/linkPopularity.dart';
import 'package:uuid/uuid.dart';
class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Uuid randomid = Uuid();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Sayfası'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                final addPop = TextEditingController();
                final addID = TextEditingController();
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Kayıt Ekle'),
                    content: Column(
                      children: [
                        TextField(
                          controller: addPop,
                          decoration: InputDecoration(hintText: 'Popülerlik'),
                        ),
                        Divider(),
                        TextField(
                            controller: addID,
                            decoration: InputDecoration(hintText: 'ID'))
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          String id ='';
                          if (sayiMi(addPop.text)) {
                            if(addID.text.isEmpty){
                              id = randomid.v4();
                            }
                            else {id = addID.text;}
                            linkPopularity(
                                popularity: int.parse(addPop.text),
                                userID: id);
                            final snackBar = SnackBar(
                              backgroundColor:
                              Colors.lightGreen,
                              content: const Text(
                                  'Kayıt başarıyla yaratıldı.'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          else{
                            final snackBar = SnackBar(
                              backgroundColor:
                              Colors.red,
                              content: const Text(
                                  'Bir hatadan dolayı kayıt yaratılamadı'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: readPopularity(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data!;
              List<popUser> userList = users as List<popUser>;
              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String tileID = users[index].id.toString();
                    final VeriEdit = TextEditingController();
                    final tileDoc = FirebaseFirestore.instance
                        .collection('userPopularity')
                        .doc(tileID + '-pop');
                    return Column(
                      children: [
                        Slidable(
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) => {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Veri Düzenleme'),
                                      content: Column(
                                        children: [
                                          TextField(
                                            controller: VeriEdit,
                                            decoration: InputDecoration(
                                                hintText: 'Popülerlik'),
                                          )
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (sayiMi(VeriEdit.text)) {
                                              tileDoc.update({
                                                'Popularity':
                                                    int.parse(VeriEdit.text)
                                              });
                                              final snackBar = SnackBar(
                                                backgroundColor:
                                                    Colors.lightGreen,
                                                content: const Text(
                                                    'Kayıt başarıyla güncellendi'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              final snackBar = SnackBar(
                                                backgroundColor: Colors.red,
                                                content: const Text(
                                                    'Bir hatadan dolayı kayıt güncellenemedi'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                            return Navigator.pop(context, 'OK');
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  )
                                },
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.black,
                                icon: Icons.create_outlined,
                                label: 'Düzenle',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  tileDoc.delete();
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.lightGreen,
                                    content:
                                        const Text('Kayıt başarıyla silindi.'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Sil',
                              )
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor: popRenk(users[index].pop!),
                                child: Text(
                                  users[index].pop.toString(),
                                  style: TextStyle(color: Colors.black),
                                )),
                            title: Text(
                              users[index].id.toString(),
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                          ),
                        ),
                        Divider(
                          height: 0,
                        )
                      ],
                    );
                  });
            } else {
              return Text('${snapshot.error}');
            }
          },
        ),
      ),
    );
  }
}


MaterialColor popRenk(int _pop) {
  if (_pop < 20)
    return Colors.red;
  else if (_pop >= 20 && _pop < 40)
    return Colors.orange;
  else if (_pop >= 40 && _pop < 60)
    return Colors.yellow;
  else if (_pop > 60 && _pop < 80)
    return Colors.lightGreen;
  else
    return Colors.green;
}

bool sayiMi(String str) {
  try {
    double.parse(str);
    return true;
  } catch (NumberFormatException) {
    return false;
  }
}
