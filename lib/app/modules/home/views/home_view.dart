import 'package:adv_database/app/modules/home/views/query_table.dart';


import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';


class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Presented to Dr. Ensaf Hussein',
            textAlign: TextAlign.center,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Colors.blueGrey,
                child: Center(
                  child: Text(
                    "Pokemon RDF",
                    style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Obx(
                    () => Container(
                  height: controller.noResponse ? Get.height * 0.8 : Get.height * 0.30,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                  Form(
                                    key: controller.formKey,
                                    child: SizedBox(
                                      width: Get.width * 0.4,
                                      height: controller.noResponse ? Get.height * 0.3 : null,
                                      child: TextFormField(
                                        maxLines: null,
                                        minLines: controller.noResponse ? 16 : 5,
                                        validator: (value){
                                          if(value == null || value.isEmpty){
                                            return "Enter query";
                                          }
                                          return null;
                                        },
                                        controller: controller.queryController,
                                        decoration: InputDecoration(
                                          labelText: controller.labelText.value,
                                          hintText: "",
                                          floatingLabelAlignment:FloatingLabelAlignment.center ,
                                          alignLabelWithHint: true,
                                          isDense: true,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey.withOpacity(0.7),
                                              width: 2.0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red),
                                              borderRadius: BorderRadius.circular(8)),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red),
                                              borderRadius: BorderRadius.circular(8)),

                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(onPressed: () => controller.performQuery(), child: Text("Query"))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() {
                if (controller.queryResponse.value != null)
                  return SizedBox(
                      width: Get.width * 0.8,
                      height: Get.height * 0.8,
                      child: QueryTable());
                return SizedBox();
              }),

            ],
          ),
        ),
      ),
    );
  }
}
