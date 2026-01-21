CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.
    METHODS setTravelId FOR DETERMINE ON SAVE
      IMPORTING keys FOR Travel~setTravelId.
    METHODS setOverallStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~setOverallStatus.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setTravelId.

*  Read entities of Travel details
    READ ENTITIES OF ZUJ_TRAVEl_I IN LOCAL MODE
    ENTITY Travel
    FIELDS ( TravelId )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travel).

*  Delete the record where already existing in Travel table
    DELETE lt_travel WHERE TravelId IS NOT INITIAL.


    SELECT SINGLE FROM zuj_travel FIELDS MAX( travel_id ) INTO @DATA(lv_travelid_max).

*    Modify Entities
    MODIFY ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    UPDATE FIELDS ( TravelId )
    WITH VALUE #(  FOR ls_Travel_id IN lt_travel INDEX INTO lv_index
                    ( %tky = ls_travel_id-%tky
                    TravelId = lv_travelid_max + lv_index

                    ) ).


  ENDMETHOD.

  METHOD setOverallStatus.

* Read Overall status

    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    FIELDS ( OverallStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_status).

    DELETE lt_status WHERE OverallStatus IS NOT INITIAL.

*    Modify Status
    MODIFY ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    UPDATE FIELDS ( OverallStatus )
    WITH VALUE #( FOR ls_status IN lt_status
                   (  %tky = ls_status-%tky
                    OverallStatus = 'O' )  ).

  ENDMETHOD.

ENDCLASS.
