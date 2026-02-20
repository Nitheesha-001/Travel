CLASS lhc_bookingsuppl DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS Setbookingsupplementid FOR DETERMINE ON SAVE
      IMPORTING keys FOR Bookingsuppl~Setbookingsupplementid.
    METHODS calculateTotalprice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Bookingsuppl~calculateTotalprice.

ENDCLASS.

CLASS lhc_bookingsuppl IMPLEMENTATION.

  METHOD Setbookingsupplementid.

    DATA: max_bookingsupplementid  TYPE /dmo/booking_supplement_id,
          bookingsupplyment        TYPE STRUCTURE FOR READ RESULT zuj_bksuppl_i,
          bookingsupplement_update TYPE TABLE FOR UPDATE zuj_travel_i\\Bookingsuppl.


*  Reading booking Supplement entity using BookingUuid field for the current booking Supplement instance

    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Bookingsuppl BY \_Booking
    FIELDS ( BookingUuid )
    WITH CORRESPONDING #( keys  )
    RESULT DATA(bookingsupplements).


*    read all Booking supplement details
    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Booking BY \_BookingSupplement
    FIELDS ( BookingSupplementId )
    WITH CORRESPONDING #( bookingsupplements )
    LINK DATA(bookingsupply_links)
    RESULT DATA(bookingsupplyments).

    LOOP AT bookingsupplements INTO DATA(bookingsupplement).


      max_bookingsupplementid = '0000'.

      LOOP AT  bookingsupply_links INTO DATA(bookingsupply_link) USING KEY id WHERE source-%tky = bookingsupplement-%tky.

        bookingsupplyment = bookingsupplyments[ KEY id
                            %tky = bookingsupply_link-target-%tky ].

        IF bookingsupplyment-BookingSupplementId > max_bookingsupplementid.

          max_bookingsupplementid = bookingsupplyment-BookingSupplementId.

        ENDIF.

      ENDLOOP.

      LOOP AT bookingsupply_links INTO bookingsupply_link USING KEY id WHERE source-%tky = bookingsupplement-%tky.
        bookingsupplyment = bookingsupplyments[ KEY id
                            %tky = bookingsupply_link-target-%tky ].

        IF bookingsupplyment-BookingSupplementId IS INITIAL.

          max_bookingsupplementid += 1.

          APPEND VALUE #( %tky = bookingsupplyment-%tky
                          BookingSupplementId = max_bookingsupplementid ) TO bookingsupplement_update.

        ENDIF.

      ENDLOOP.

    ENDLOOP.

* Modify entities of update the booking Supplement entity with new Booking Supplement Id number which is maximum booking SupplemntId

    MODIFY ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Bookingsuppl
    UPDATE FIELDS ( BookingSupplementId )
    WITH bookingsupplement_update.

  ENDMETHOD.

  METHOD calculateTotalprice.

    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Bookingsuppl BY \_Travel
    FIELDS ( TravelUuid )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    MODIFY ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    EXECUTE recalcTotalprice
    FROM CORRESPONDING #( travels ).

  ENDMETHOD.

ENDCLASS.

CLASS lhc_booking DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS setbookingdate FOR DETERMINE ON SAVE
      IMPORTING keys FOR Booking~setbookingdate.

    METHODS setbookingid FOR DETERMINE ON SAVE
      IMPORTING keys FOR Booking~setbookingid.
    METHODS calculateTotalprice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateTotalprice.

ENDCLASS.

CLASS lhc_booking IMPLEMENTATION.

  METHOD setbookingdate.
  ENDMETHOD.

  METHOD setbookingid.

    DATA: max_bookingid   TYPE /dmo/booking_id,
          booking         TYPE STRUCTURE FOR READ RESULT zuj_booking_i,
          bookings_update TYPE TABLE FOR UPDATE zuj_travel_i\\Booking.

*  Reading booking entity using TravelUuid field for the current booking instance
    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Booking BY \_Travel
    FIELDS ( TravelUuid )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

*  Read all booking details based on Travel Entity
    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel BY \_Booking
    FIELDS ( BookingId )
    WITH CORRESPONDING #( travels )
    LINK DATA(booking_links)
    RESULT DATA(bookings).


    LOOP AT travels INTO DATA(travel).

*    Initialize Booking ID

      max_bookingid = '0000'.

      LOOP AT booking_links INTO DATA(booking_link) USING KEY id WHERE source-%tky = travel-%tky.
        booking = bookings[ KEY id
                            %tky = booking_link-target-%tky ].

        IF booking-BookingId > max_bookingid.

          max_bookingid = booking-BookingId.

        ENDIF.

      ENDLOOP.

      LOOP AT booking_links INTO booking_link USING KEY id WHERE source-%tky = travel-%tky.
        booking = bookings[ KEY id
                            %tky = booking_link-target-%tky ].

        IF booking-BookingId IS INITIAL.

          max_bookingid += 1.

          APPEND VALUE #( %tky = booking-%tky
                          BookingId = max_bookingid ) TO bookings_update.

        ENDIF.

      ENDLOOP.
    ENDLOOP.


* Modify entities of update the booking entity with new Booking Id number which is maximum bookingId.

    MODIFY ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Booking
    UPDATE FIELDS ( BookingId )
    WITH bookings_update.

  ENDMETHOD.

  METHOD calculateTotalprice.

    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Booking BY \_Travel
    FIELDS ( TravelUuid  )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travles).

    MODIFY ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    EXECUTE recalcTotalprice
    FROM CORRESPONDING #( travles ).

  ENDMETHOD.

ENDCLASS.

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
    METHODS acceptTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~acceptTravel RESULT result.

    METHODS rejectTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~rejectTravel RESULT result.
    METHODS deductdiscount FOR MODIFY
      IMPORTING keys FOR ACTION Travel~deductdiscount RESULT result.
    METHODS GetDefaultsFordeductDiscount FOR READ
      IMPORTING keys FOR FUNCTION Travel~GetDefaultsFordeductDiscount RESULT result.
    METHODS recalcTotalprice FOR MODIFY
      IMPORTING keys FOR ACTION Travel~recalcTotalprice.
    METHODS calculateTotalprice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~calculateTotalprice.
    METHODS validatecustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validatecustomer.
    METHODS validateAgency FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateAgency.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateDates.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

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

  METHOD acceptTravel.

*  // Accept the Travel Related Records
    MODIFY ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    UPDATE FIELDS ( OverallStatus )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                    OverallStatus = 'A' )  ).

*   Read all Accept travel records
    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    ALL FIELDS WITH
    CORRESPONDING #( keys )
    RESULT DATA(travels)   .


    result = VALUE #( FOR travel IN travels ( %tky = travel-%tky
                                               %param = travel ) ).

  ENDMETHOD.

  METHOD rejectTravel.


*  *  // Reject the Travel Related Records
    MODIFY ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    UPDATE FIELDS ( OverallStatus )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                    OverallStatus = 'R' )  ).

*   Read all Reject travel records
    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    ALL FIELDS WITH
    CORRESPONDING #( keys )
    RESULT DATA(travels)   .

    result = VALUE #( FOR travel IN travels ( %tky = travel-%tky
                                               %param = travel ) ).
  ENDMETHOD.

  METHOD deductdiscount.

    DATA : travel_for_update TYPE TABLE FOR UPDATE zuj_travel_i.

    DATA(keys_temp) = keys.

    LOOP AT keys_temp ASSIGNING FIELD-SYMBOL(<key_temp>) WHERE  %param-discount_percent IS INITIAL OR
                                                                %param-discount_percent > 100 OR
                                                                %param-discount_percent < 0 .


      APPEND VALUE #( %tky = <key_temp>-%tky ) TO  failed-travel.
      APPEND VALUE #( %tky = <key_temp>-%tky
                      %msg = new_message_with_text(  text = 'Invalid Discount Percentage'
                                                     severity = if_abap_behv_message=>severity-error )
                                   %element-totalprice = if_abap_behv=>mk-on
                                   %action-deductdiscount = if_abap_behv=>mk-on ) TO reported-travel.


      DELETE keys_temp.
    ENDLOOP.

    CHECK keys_temp IS NOT INITIAL.

    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    FIELDS ( TotalPrice )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_travels).


    DATA: lv_percentage TYPE decfloat16.

    LOOP AT lt_travels ASSIGNING FIELD-SYMBOL(<fs_travel>).

      DATA(lv_discount_percentage) = keys[  KEY id %tky = <fs_travel>-%tky ]-%param-discount_percent.
      lv_percentage = lv_discount_percentage / 100 .

      DATA(reduced_value) = <fs_travel>-TotalPrice * lv_percentage.

      reduced_value = <fs_travel>-TotalPrice - reduced_value.

      APPEND VALUE #( %tky = <fs_travel>-%tky
                      totalprice = reduced_value ) TO travel_for_update.

    ENDLOOP.

    MODIFY ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    UPDATE FIELDS ( TotalPrice )
    WITH travel_for_update.


    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    ALL FIELDS WITH
    CORRESPONDING #( keys  )
    RESULT DATA(lt_travel_updated).


    result = VALUE #( FOR ls_travel IN lt_travel_updated ( %tky = ls_travel-%tky
                                                           %param = ls_travel  ) ).


  ENDMETHOD.

  METHOD GetDefaultsFordeductDiscount.


    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    FIELDS ( TotalPrice )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    LOOP AT travels INTO DATA(travel).

      IF travel-TotalPrice >= 1000.
        APPEND VALUE #( %tky = travel-%tky
                         %param-discount_percent = 10 ) TO result.
      ELSE.

        APPEND VALUE #( %tky = travel-%tky
                             %param-discount_percent = 05 ) TO result.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD recalcTotalprice.

    TYPES : BEGIN OF ty_amount_per_currencycode,
              amount        TYPE /dmo/total_price,
              currency_code TYPE /dmo/currency_code,
            END OF ty_amount_per_currencycode.

    DATA: amounts_per_currencycode TYPE STANDARD TABLE OF ty_amount_per_currencycode.

*  Calculating Total price
*  Travel entity Data
    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    FIELDS ( BookingFee CurrencyCode )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

*  Booking entity Data
    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY travel BY \_Booking
    FIELDS ( FlightPrice CurrencyCode )
    WITH CORRESPONDING #( travels )
    RESULT DATA(bookings)
    LINK DATA(booking_links).

*  Booking Supplements Data
    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY booking BY \_BookingSupplement
    FIELDS ( Price CurrencyCode )
    WITH CORRESPONDING #( bookings )
    RESULT DATA(bookingsupplements)
    LINK DATA(bookingsupplement_links).


    LOOP AT travels ASSIGNING FIELD-SYMBOL(<travel>).

      amounts_per_currencycode = VALUE #(  ( amount = <travel>-BookingFee
                                           currency_code = <travel>-CurrencyCode ) ).


      LOOP AT booking_links INTO DATA(booking_link) USING KEY id WHERE source-%tky = <travel>-%tky.
        DATA(booking) = bookings[ KEY id %tky = booking_link-target-%tky ].

        COLLECT VALUE ty_amount_per_currencycode(  amount = booking-FlightPrice
                                                   Currency_code = booking-CurrencyCode ) INTO amounts_per_currencycode .

        LOOP AT bookingsupplement_links INTO DATA(bookingsupplement_link) USING KEY id WHERE source-%tky =  booking-%tky.
          DATA(bookingsupplement) = bookingsupplements[ KEY id %tky = bookingsupplement_link-target-%tky ] .

          COLLECT VALUE ty_amount_per_currencycode( amount = bookingsupplement-Price
                                                    currency_code = bookingsupplement-CurrencyCode ) INTO amounts_per_currencycode.

        ENDLOOP.

      ENDLOOP.

    ENDLOOP.

    DELETE amounts_per_currencycode WHERE currency_code IS INITIAL.

    LOOP AT amounts_per_currencycode INTO DATA(amount_per_currencycode).

      IF <travel>-CurrencyCode = amount_per_currencycode-currency_code.
        <travel>-TotalPrice = amount_per_currencycode-amount.

      ELSE.
        /dmo/cl_flight_amdp=>convert_currency(
        EXPORTING
        iv_amount = amount_per_currencycode-amount
        iv_currency_code_source = amount_per_currencycode-currency_code
        iv_currency_code_target = <travel>-CurrencyCode
        iv_exchange_rate_date = cl_abap_context_info=>get_system_date(  )
        IMPORTING
        ev_amount = DATA(total_booking_per_curr)   ).

        <travel>-TotalPrice += total_booking_per_curr.

      ENDIF.

      MODIFY ENTITIES OF zuj_travel_i IN LOCAL MODE
      ENTITY Travel
      UPDATE FIELDS ( TotalPrice )
      WITH CORRESPONDING #( travels  ).


    ENDLOOP.

  ENDMETHOD.

  METHOD calculateTotalprice.

    MODIFY ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    EXECUTE recalcTotalprice
    FROM CORRESPONDING #( keys ).

  ENDMETHOD.

  METHOD validatecustomer.

    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    FIELDS ( CustomerId )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels) .

    DATA: customers TYPE SORTED TABLE OF /dmo/customer WITH UNIQUE KEY customer_id.
    customers = CORRESPONDING #( travels DISCARDING DUPLICATES MAPPING customer_id = CustomerId EXCEPT * ).

    SELECT FROM /dmo/customer FIELDS customer_id
    FOR ALL ENTRIES IN @customers
    WHERE customer_id = @customers-customer_id
    INTO TABLE @DATA(valid_customers).

    LOOP AT travels INTO DATA(travel).
      APPEND VALUE #( %tky = travel-%tky
                      %state_area = 'VALIDATE_CUSTOMER'
                      ) TO reported-travel.

      IF travel-CustomerId IS NOT INITIAL AND NOT line_exists( valid_customers[ customer_id = travel-CustomerId ] ) .

        APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
        APPEND VALUE #( %tky = travel-%tky
                        %state_area = 'VALIDATE_CUSTOMER'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = | { travel-CustomerId } Customer does not exist |
                         )
                         %element-customerid = if_abap_behv=>mk-on
                          ) TO reported-travel.
      ENDIF.

    ENDLOOP.




  ENDMETHOD.

  METHOD validateAgency.

    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    FIELDS ( AgencyId )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels) .

    DATA: Agencies TYPE SORTED TABLE OF /dmo/agency WITH UNIQUE KEY agency_id.
    Agencies = CORRESPONDING #( travels DISCARDING DUPLICATES MAPPING agency_id = AgencyId EXCEPT * ).

    SELECT FROM /dmo/agency FIELDS agency_id
    FOR ALL ENTRIES IN @Agencies
    WHERE agency_id = @Agencies-agency_id
    INTO TABLE @DATA(valid_agencies).

    LOOP AT travels INTO DATA(travel).
      APPEND VALUE #( %tky = travel-%tky
                       %state_area = 'VALIDATE_AGENT'
                       ) TO reported-travel.

      IF travel-AgencyId IS NOT INITIAL AND NOT line_exists( valid_agencies[ agency_id = travel-AgencyId ] ) .

        APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
        APPEND VALUE #( %tky = travel-%tky
                        %state_area = 'VALIDATE_AGENT'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = |{ travel-AgencyId } Agent does not exist|
                         )
                         %element-AgencyId = if_abap_behv=>mk-on
                          ) TO reported-travel.
      ENDIF.

    ENDLOOP.


  ENDMETHOD.

  METHOD validateDates.

    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    FIELDS ( BeginDate EndDate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels) .

    LOOP AT travels INTO DATA(travel).
      APPEND VALUE #( %tky = travel-%tky
                         %state_area = 'VALIDATE_DATES'
                         ) TO reported-travel.

      IF travel-BeginDate IS INITIAL.

        APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
        APPEND VALUE #( %tky = travel-%tky
                        %state_area = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = |Begin date cannot be empty|
                         )
                         %element-BeginDate = if_abap_behv=>mk-on
                          ) TO reported-travel.

      ENDIF.

      IF travel-EndDate IS INITIAL.

        APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
        APPEND VALUE #( %tky = travel-%tky
                        %state_area = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = |End date cannot be empty|
                         )
                         %element-EndDate = if_abap_behv=>mk-on
                          ) TO reported-travel.
      ENDIF.

      IF travel-EndDate < travel-BeginDate AND travel-BeginDate IS NOT INITIAL
                                           AND travel-EndDate IS NOT INITIAL.

        APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.
        APPEND VALUE #( %tky = travel-%tky
                        %state_area = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = |End date must be greater than or equal to the start date|
                         )
                         %element-BeginDate = if_abap_behv=>mk-on
                         %element-EndDate = if_abap_behv=>mk-on
                          ) TO reported-travel.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zuj_travel_i IN LOCAL MODE
    ENTITY Travel
    FIELDS ( OverallStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(travels).

    result = VALUE #( FOR ls_travel IN travels
                       ( %tky = ls_travel-%tky
                       %field-BookingFee = COND #( WHEN ls_travel-OverallStatus = 'A'
                                                   THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted  )

                        %action-acceptTravel = COND #(  WHEN ls_travel-OverallStatus = 'A'
                                                        THEN if_abap_behv=>fc-o-disabled
                                                        ELSE if_abap_behv=>fc-o-enabled )

                        %action-rejectTravel = COND #( WHEN ls_travel-OverallStatus = 'R'
                                                        THEN if_abap_behv=>fc-o-disabled
                                                        ELSE if_abap_behv=>fc-o-enabled )

                        %action-deductdiscount = COND #( WHEN ls_travel-OverallStatus = 'A'
                                                         THEN if_abap_behv=>fc-o-disabled
                                                         ELSE if_abap_behv=>fc-o-enabled )
                       )   ).


  ENDMETHOD.

ENDCLASS.
