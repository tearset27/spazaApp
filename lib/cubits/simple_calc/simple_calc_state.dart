part of 'simple_calc_cubit.dart';

abstract class SimpleCalcState extends Equatable {
  @override
  List<Object> get props => [];
}

class SimpleCalcCalculated extends SimpleCalcState {
  SimpleCalcCalculated(this.breakdown, this.totalChange, this.error);

  final Map<String, num> breakdown;
  final num totalChange;
  final String error;

  @override
  List<Object> get props => [breakdown, totalChange, error];
}
