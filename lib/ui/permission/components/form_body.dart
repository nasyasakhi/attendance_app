import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormBody extends StatelessWidget {
  const FormBody({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final formController = TextEditingController();
    final toController = TextEditingController();
    String dropValueCategories = "Please Choose";
    var categoriesList = <String> [ // bisa dimainkan warna tergantung permit nya, tinggal diganti jadi dynamic
      "Please Choose:",
      "Sick",
      "IDN Teaching",
      "Others"
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           TextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            controller: nameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              labelText: "Your Name",
              labelStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
              hintText: "Please enter your name",
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Colors.grey
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blueAccent)
              )
            ),
           ),
           const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blueAccent,
                style: BorderStyle.solid,
                width: 1
              )
            ),
            child: DropdownButton(
              dropdownColor: Colors.white,
              value: dropValueCategories,
              onChanged: (value) {
                dropValueCategories = value.toString();
              },
              items: categoriesList.map((value){ //Iterable : ngacak , List : berurutan
                return DropdownMenuItem(
                  value: value.toString(),
                  child: Text(
                    value.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black
                    ),
                  )
                );
              }).toList(), // untuk mengubah iterable menjadi list, yg dimana mengkorversi data acak menjadi berurutan
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
              underline: Container(
                height: 2,
                color: Colors.blueGrey,
              ),
              isExpanded: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        "From",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          onTap: () async { // pake async proses krn dia adalah sebuah Future dateTime
                            DateTime? pickedDate = await 
                            showDatePicker(
                              context: context, 
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2025), 
                              lastDate: DateTime(2025)
                            );
                            if (pickedDate != null) {
                              formController.text = DateFormat('dd/mm/yy').format(pickedDate); 
                              // untuk mengkonversi data detail tanggal yg diambil dr pickerdate menjadi format dd/mm/yy
                            }
                          },
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black
                          ),
                          controller: formController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            hintText: "Starting from",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.grey
                            )
                          ),
                        )
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Row(
                          children: [
                            const Text(
                              "Until:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await 
                                  showDatePicker(
                                    context: context, 
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2025), 
                                    lastDate: DateTime(2025)
                                  );
                                  if (pickedDate != null) {
                                    toController.text = DateFormat('dd/mm/yy').format(pickedDate);
                                  }
                                },
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                                ),
                                controller: toController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: "Until",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey
                                  )
                                ),
                            ))
                          ],
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
            )
        ],
      ),
    );
  }
}