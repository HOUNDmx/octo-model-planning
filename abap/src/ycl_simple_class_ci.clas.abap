CLASS ycl_simple_class_ci DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    CLASS-METHODS
    sum_two_numbers
      IMPORTING
        i_number1 TYPE i
        i_number2 TYPE i
      RETURNING
        VALUE(r_result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS ycl_simple_class_ci IMPLEMENTATION.

  METHOD sum_two_numbers.
    r_result = i_number1 + i_number2.
  ENDMETHOD.

ENDCLASS.