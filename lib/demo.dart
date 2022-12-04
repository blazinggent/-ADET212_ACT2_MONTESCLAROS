import 'package:flutter/material.dart';
import 'add_contact_details.dart';
import 'contact_details.dart';
import 'db_helper.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder<List<ContactDetails>>(
        future: DBHelper.readContacts(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ContactDetails>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Loading...'),
                ],
              ),
            );
          }
          return snapshot.data!.isEmpty
              ? const Center(
                  child: Text('There are no contacts yet'),
                )
              : ListView(
                  children: snapshot.data!.map((contacts) {
                    return Center(
                      child: ListTile(
                        title: Text(contacts.name),
                        subtitle: Text(
                            '${contacts.mobileNumber}\n${contacts.emailAddress}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await DBHelper.deleteContacts(contacts.id!);
                            setState(() {});
                          },
                        ),
                        onTap: () async {
                          final refresh = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => AddContactDetails(
                                        contact: ContactDetails(
                                            id: contacts.id,
                                            name: contacts.name,
                                            mobileNumber: contacts.mobileNumber,
                                            emailAddress:
                                                contacts.emailAddress),
                                      )));

                          if (refresh) {
                            setState(() {});
                          }
                        },
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final refresh = await Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AddContactDetails()));

          if (refresh) {
            setState(() {});
          }
        },
      ),
    );
  }
}
