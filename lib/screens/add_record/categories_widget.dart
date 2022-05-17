import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense/model/categories_model.dart';
import 'package:expense/screens/add_record/categories_item_widget.dart';
import 'package:expense/services/firebase_servcies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesWidget extends StatefulWidget {
  final Function(CategoryModel categoryModel) callback;

  const CategoriesWidget({
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  RxList listCategories = [].obs;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        children: List.generate(
          listCategories.length,
          (index) => CategoriesItemWidget(
            categoryModel: listCategories.elementAt(index),
            onTapItem: () {
              var categoryModel = listCategories.elementAt(index);
              for (final category in listCategories) {
                category.isSelected = false;
              }
              categoryModel.isSelected = !categoryModel.isSelected;
              widget.callback(categoryModel);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    List<QueryDocumentSnapshot> categoriesList =
        await FirebaseServices.getCategoriesData();
    List<CategoryModel> tempList = [];
    for (final category in categoriesList) {
      CategoryModel categoryModel = CategoryModel(
        category['emoji'],
        category['category'],
        false,
      );
      tempList.add(categoryModel);
    }
    listCategories.value = tempList;
  }
}
