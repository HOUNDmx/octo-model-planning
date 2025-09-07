CLASS ltcl_test DEFINITION DEFERRED.
CLASS ycl_model_status_api DEFINITION LOCAL FRIENDS ltcl_test.
CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.
  PUBLIC SECTION.
  PRIVATE SECTION.
    METHODS: setup,
      when_type_create     FOR TESTING,
      when_type_update     FOR TESTING,
      when_type_delete     FOR TESTING,
      when_type_unknown    FOR TESTING,
      when_payload_invalid FOR TESTING,
      teardown.
    CLASS-DATA: go_api  TYPE REF TO ycl_model_status_api,
                payload TYPE yif_model_status_api=>cloudevent.
ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.
  METHOD setup.
    CLEAR payload.
    go_api = NEW ycl_model_status_api( ).
  ENDMETHOD.

  METHOD when_type_create.
    RETURN.
  ENDMETHOD.

  METHOD when_type_update.
    RETURN.
  ENDMETHOD.

  METHOD when_type_delete.
    RETURN.
  ENDMETHOD.

  METHOD when_type_unknown.
    payload-type = 'unknown'.
    cl_abap_unit_assert=>assert_char_cp( act = go_api->process( payload )
                                         exp = 'Unknown event type:*'
                                         msg = 'Payload is empty, so it is invalid' ).
  ENDMETHOD.

  METHOD when_payload_invalid.
    cl_abap_unit_assert=>assert_false( act = go_api->validate_data( payload )
                                       msg = 'Payload is empty, so it is invalid' ).
  ENDMETHOD.

  METHOD teardown.
    FREE go_api.
  ENDMETHOD.

ENDCLASS.
