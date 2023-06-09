
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorState.initial()) {
    on<AddColors>((event, emit) {
      emit(state.copyWith(colorPrimary: event.colorPrimary, colorSecondary: event.colorSecondary));
    });
  }
}