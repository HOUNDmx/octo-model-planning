CLASS ycl_model_status_api DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS
      receive
        IMPORTING
          binary_payload TYPE xstring.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      deserialize
        IMPORTING
          binary_payload TYPE xstring
        RETURNING
          VALUE(payload) TYPE yif_model_status_api=>cloudevent,
      validate_data
        IMPORTING
          payload TYPE yif_model_status_api=>cloudevent
        RETURNING
          VALUE(is_valid) TYPE abap_bool,
      process
        IMPORTING
          payload TYPE yif_model_status_api=>cloudevent.
    CONSTANTS: c_type_created TYPE string VALUE yif_model_status_api=>c_type_created,
               c_type_updated TYPE string VALUE yif_model_status_api=>c_type_updated,
               c_type_deleted TYPE string VALUE yif_model_status_api=>c_type_deleted.
ENDCLASS.

CLASS ycl_model_status_api IMPLEMENTATION.

  METHOD receive.
    DATA(payload) = deserialize( binary_payload ).
    IF validate_data( payload ) = abap_true.
      process( payload ).
    ELSE.
      " Handle invalid data scenario, call exception class, log error, etc.
      RETURN.
    ENDIF.
  ENDMETHOD.

  METHOD deserialize.
    /ui2/cl_json=>deserialize( EXPORTING jsonx       = binary_payload
                                         pretty_name = /ui2/cl_json=>pretty_mode-camel_case
                               CHANGING  data        = payload ).
  ENDMETHOD.

  METHOD validate_data.
    is_valid = xsdbool( payload IS NOT INITIAL ).
  ENDMETHOD.

  METHOD process.
    CASE payload-type.
      WHEN c_type_created.
        " Handle create logic, e.g., insert into database
        RETURN.
      WHEN c_type_updated.
        " Handle update logic, e.g., modify existing record
        RETURN.
      WHEN c_type_deleted.
        " Handle delete logic, e.g., remove record from database
        RETURN.
      WHEN OTHERS.
        " Handle unknown type scenario, call exception class, log error, etc.
        RETURN.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.