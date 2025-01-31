import 'package:e_commerce/logic/controllers/add_product/add_product.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:e_commerce/logic/data/states/add_product/add_product.dart';
import 'package:e_commerce/presentation/widgets/error_dialog.dart';
import 'package:e_commerce/presentation/widgets/loading_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddProductScreen({super.key});

  String? requiredField(String? value) {
    if (value == null || value.isEmpty) {
      return 'this field is required';
    }
    return null;
  }

  String? categoryValidator(Category? value) {
    if (value == null) {
      return 'this field is required';
    }
    return null;
  }

  String? imageValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'this field is required';
    }
    if (!(value.startsWith('https://'))) {
      return 'please enter valid url';
    }

    return null;
  }

  String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'this field is required';
    }
    //validate format
    RegExp regExp = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!regExp.hasMatch(value)) {
      return "Please enter valid price";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductBloc()..load(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        body: BlocConsumer<AddProductBloc, AddProductState>(
          listener: (context, state) {
            if (state is AddProductDone) {
              Navigator.of(context).pop();
            }
            if (state is AddProductError) {
              showDialog(
                  context: context,
                  builder: (_) => ErrorDialog(error: state.message));
            }
          },
          buildWhen: (previous, current) => previous is! AddProductLoaded,
          builder: (context, state) {
            if (state is AddProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AddProductError) {
              return LoadingError(
                retryCallback: () => context.read<AddProductBloc>().load(),
                error: state.message,
              );
            }
            if (state is AddProductLoaded) {
              final cubit = context.read<AddProductBloc>();
              //form
              return Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      validator: requiredField,
                      controller: cubit.nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: imageValidator,
                      controller: cubit.imageController,
                      decoration: const InputDecoration(labelText: 'Image'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: priceValidator,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: cubit.priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: requiredField,
                      maxLines: 5,
                      minLines: 5,
                      controller: cubit.descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DropdownButtonFormField<Category>(
                      hint: const Text('Category'),
                      validator: categoryValidator,
                      value: state.selectedCategory,
                      items: state.categories
                          .map((e) => DropdownMenuItem<Category>(
                                value: e,
                                child: Text(e.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        cubit.selectCategory(value!);
                      },
                    ),
                    BlocBuilder<AddProductBloc, AddProductState>(
                      builder: (context, state) {
                        return SizedBox.square(
                          dimension: 64,
                          child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Visibility(
                                  visible: state is AddProductSubmitting,
                                  child: const CircularProgressIndicator())),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.submit();
                        }
                      },
                      child: const Text('Add Product'),
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
