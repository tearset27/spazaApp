import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simple_calc_state.dart';

class SimpleCalcCubit extends Cubit<SimpleCalcState> {
  SimpleCalcCubit() : super(SimpleCalcCalculated({}, 0, ''));

  List<num> validDenominations = [200, 50, 20, 10, 5, 2, 1, 0.5, 0.2, 0.1];

  void calculateWithMod(double? cost, double? tender) {
    // if (cost == null || tender == null) return;

    num totalChange = (tender ?? 0) - (cost ?? 0);
    num changeLeftToPay = totalChange;
    Map<String, num> breakdown = {};

    // TODO - Calculate your breakdown here, put the results in a map, with the validDenominations as the key, and the result as the value

    try{
      num currentChange = 0;
      for(var i = 0; i < validDenominations.length; i++){
        if(validDenominations[i] <= changeLeftToPay){
          while(changeLeftToPay / validDenominations[i] >= 1){
            changeLeftToPay -= validDenominations[i];
            currentChange += 1;
            changeLeftToPay = double.parse(changeLeftToPay.toStringAsFixed(1));
          }
        }
        if(changeLeftToPay < 0){
          throw('Insufficient funds');

        }

        if(currentChange != 0){
          breakdown[validDenominations[i].toString()] = currentChange;
        }

        if(cost == null){
          throw('Please enter a valid amount');
        }
        currentChange = 0;
      }
      emit(SimpleCalcCalculated(breakdown, totalChange, ''));
    } catch (error) {
      emit(SimpleCalcCalculated({}, 0, error.toString()));
    }

  }

  void clearAll() {
    emit(SimpleCalcCalculated({}, 0, ''));
  }


}
