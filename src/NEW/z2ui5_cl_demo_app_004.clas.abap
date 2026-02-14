CLASS z2ui5_cl_demo_app_004 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    
    DATA mv_view_main TYPE string.

    METHODS on_init.
    METHODS display_view.
    METHODS on_event.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_004 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    me->client = client.
    CASE abap_true.
      WHEN client->check_on_init( ).
        on_init( ).
        display_view( ).
      WHEN client->check_on_event( ).
        on_event( ).
    ENDCASE.

  ENDMETHOD.

  METHOD on_event.

    CASE client->get( )-event.
      WHEN `BUTTON_ROUNDTRIP`.
        client->message_box_display( `server-client roundtrip, method on_event of the abap controller was called` ).
      WHEN `BUTTON_RESTART`.
        client->nav_app_leave( NEW z2ui5_cl_demo_app_004( ) ).
      WHEN `BUTTON_CHANGE_VIEW`.
        mv_view_main = SWITCH #( mv_view_main WHEN `MAIN` THEN `SECOND` ELSE `SECOND` ).
        display_view( ).
      WHEN `BUTTON_ERROR`.
        DATA(lv_dummy) = 1 / 0.
    ENDCASE.

  ENDMETHOD.

  METHOD on_init.

    mv_view_main = `MAIN`.
    client->message_box_display( `app started, init values set` ).

  ENDMETHOD.

  METHOD display_view.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    
    CASE mv_view_main.
      WHEN `MAIN`.
        view->shell(
            )->page(
                title            = `abap2UI5 - Controller`
                navbuttonpress   = client->_event_nav_app_leave( )
                shownavbutton    = client->check_app_prev_stack( )
            )->grid( `L6 M12 S12` )->content( `layout`
                )->simple_form( title    = `Controller`
                                editable = abap_true )->content( `form`
                    )->label( `Roundtrip`
                    )->button(
                        text  = `Client/Server Interaction`
                        press = client->_event( `BUTTON_ROUNDTRIP` )
                    )->label( `System`
                    )->button(
                        text  = `Restart App`
                        press = client->_event( `BUTTON_RESTART` )
                    )->label( `Change View`
                    )->button(
                        text  = `Display View SECOND`
                        press = client->_event( `BUTTON_CHANGE_VIEW` )
                    )->label( `CX_SY_ZERO_DIVIDE`
                    )->button(
                        text  = `Error not catched by the user`
                        press = client->_event( `BUTTON_ERROR` ) ).
      
      WHEN `SECOND`.
        view->shell( )->page(
            title          = `abap2UI5 - Controller`
            navbuttonpress = client->_event_nav_app_leave( )
            shownavbutton  = client->check_app_prev_stack( )
        )->grid( `L12 M12 S12` )->content( `layout`
            )->simple_form( `View Second` )->content( `form`
                )->label( `Change View`
                )->button(
                    text  = `Display View MAIN`
                    press = client->_event( `BUTTON_CHANGE_VIEW` ) ).
    ENDCASE.
    client->view_display( view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
