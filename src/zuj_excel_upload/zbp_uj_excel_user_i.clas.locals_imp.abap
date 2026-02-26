CLASS lhc_XLHead DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR XLHead RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR XLHead RESULT result.
    METHODS fillfilestatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR XLHead~fillfilestatus.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE XLHead.

ENDCLASS.

CLASS lhc_XLHead IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA(lv_user) = cl_abap_context_info=>get_user_technical_name( ).

    LOOP AT entities REFERENCE INTO DATA(lo_entities).
      APPEND CORRESPONDING #( lo_entities->* ) TO mapped-xlhead
          REFERENCE INTO DATA(lo_xluser).
      lo_xluser->EndUser = lv_user.
      IF lo_xluser->FileId IS INITIAL.
        TRY.
            lo_xluser->fileid = cl_system_uuid=>create_uuid_x16_static( ).
          CATCH cx_uuid_error.

        ENDTRY.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

  METHOD fillfilestatus.


  ENDMETHOD.

ENDCLASS.
