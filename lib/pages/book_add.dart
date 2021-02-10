import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/api_models.dart';

class BookAdd extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController subtitleEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();

  final Function onValid;

  BookAdd({Key key, @required this.onValid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleEditingController,
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                ),
                TextFormField(
                  controller: subtitleEditingController,
                  decoration: InputDecoration(
                    labelText: "Subtitle",
                  ),
                ),
                TextFormField(
                  controller: priceEditingController,
                  decoration: InputDecoration(
                    labelText: "Price",
                  ),
                  validator: (String value) {
                    if (double.tryParse(value) != null) {
                      return null;
                    }
                    return 'Please enter float number.';
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        onValid(
                          Book(
                            title: titleEditingController.text,
                            subtitle: subtitleEditingController.text,
                            price: '\$${priceEditingController.text}',
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Add'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
