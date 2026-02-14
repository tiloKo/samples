CLASS z2ui5_cl_demo_app_005 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA mv_value1 TYPE int4.
    DATA mv_value2 TYPE int4.
  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS on_init.
    METHODS display_view.
    METHODS on_event.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_005 IMPLEMENTATION.

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
      WHEN `SLIDER_CHANGE`.
        client->message_toast_display( |Range Slider { cl_abap_char_utilities=>newline }value1 { mv_value1 } { cl_abap_char_utilities=>newline }value2 { mv_value2 }| ).
    ENDCASE.

  ENDMETHOD.

  METHOD on_init.

    mv_value1 = 10.
    mv_value2 = 90.

  ENDMETHOD.

  METHOD display_view.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    view->shell(
        )->page(
                title          = `abap2UI5 - Range Slider Example`
                navbuttonpress = client->_event_nav_app_leave( )
                shownavbutton  = client->check_app_prev_stack( )
        )->grid( `L12 M12 S12` )->content( `layout`
            )->simple_form( title    = `More Controls`
                            editable = abap_true )->content( `form`
                )->label( `Range Slider`
                )->range_slider(
                    max              = `100`
                    min              = `0`
                    step             = `10`
                    startvalue       = `10`
                    endvalue         = `20`
                    showtickmarks    = abap_true
                    labelinterval    = `2`
                    width            = `80%`
                    class            = `sapUiTinyMargin`
                    value            = client->_bind_edit( mv_value1 )
                    value2           = client->_bind_edit( mv_value2 )
                    change           = client->_event( `SLIDER_CHANGE` ) ).
    
    client->view_display( view->stringify( ) ).
  ENDMETHOD.
ENDCLASS.
