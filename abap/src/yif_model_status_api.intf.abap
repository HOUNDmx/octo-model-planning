INTERFACE yif_model_status_api PUBLIC.

  TYPES: BEGIN OF ty_payload,
            id          TYPE string,
            description TYPE string,
            status      TYPE string,
          END OF ty_payload.
  TYPES: BEGIN OF cloudevent,
           specversion     TYPE string,
           id              TYPE string,
           source          TYPE string,
           type            TYPE string,
           datacontenttype TYPE string,
           time            TYPE timestampl,
           data            TYPE ty_payload,
         END OF cloudevent.

  CONSTANTS: c_type_created TYPE string VALUE 'com.modelproductioncase.item.created',
             c_type_updated TYPE string VALUE 'com.modelproductioncase.item.updated',
             c_type_deleted TYPE string VALUE 'com.modelproductioncase.item.deleted'.

ENDINTERFACE.