CLASS ltcl_test DEFINITION DEFERRED.
CLASS ycl_simple_class_ci DEFINITION LOCAL FRIENDS ltcl_test.
CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.
  PUBLIC SECTION.
  PRIVATE SECTION.
    METHODS is_sum_correct FOR TESTING
        RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD is_sum_correct.
    cl_abap_unit_assert=>assert_equals( act = ycl_simple_class_ci=>sum_two_numbers( i_number1 = 1 i_number2 = 2 )
                                        exp = 3
                                        msg = 'Sum of 1 and 2 should be 3' ).
  ENDMETHOD.

ENDCLASS.
