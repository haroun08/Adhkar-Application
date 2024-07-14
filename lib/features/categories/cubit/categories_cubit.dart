import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../core/ data/json_loader.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  Future<void> loadCategories() async {
    emit(CategoriesLoading());
    try {
      final List<Map<String, dynamic>> response = await JsonLoader().loadJson();
      final List<String> categories = response.map((item) => item['category'] as String).toList();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
