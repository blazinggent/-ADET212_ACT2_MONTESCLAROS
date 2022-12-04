import 'package:flutter/material.dart';
import 'db_helper.dart';

import 'contact_details.dart';

class AddContactDetails extends StatefulWidget {
  const AddContactDetails({Key? key, this.contact}) : super(key: key);

  final ContactDetails? contact;

  @override
  State<AddContactDetails> createState() => _AddContactDetailsState();
}

class _AddContactDetailsState extends State<AddContactDetails> {
  final _nameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _emailAddressController = TextEditingController();

  @override
  void initState() {
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _mobileNumberController.text = widget.contact!.mobileNumber;
      _emailAddressController.text = widget.contact!.emailAddress;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileNumberController.dispose();
    _emailAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create contact'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTextField(_nameController, 'Name'),
              const SizedBox(
                height: 20,
              ),
              _buildTextField(_mobileNumberController, 'Mobile Number'),
              const SizedBox(
                height: 20,
              ),
              _buildTextField(_emailAddressController, 'Email Address'),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (widget.contact != null) {
                    await DBHelper.updateContacts(ContactDetails(
                        id: widget.contact!.id,
                        name: _nameController.text,
                        mobileNumber: _mobileNumberController.text,
                        emailAddress: _emailAddressController.text));

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop(true);
                  } else {
                    await DBHelper.createContacts(ContactDetails(
                        name: _nameController.text,
                        mobileNumber: _mobileNumberController.text,
                        emailAddress: _emailAddressController.text));

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop(true);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: no_leading_underscores_for_local_identifiers
  TextField _buildTextField(TextEditingController _controller, String hint) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: hint,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
