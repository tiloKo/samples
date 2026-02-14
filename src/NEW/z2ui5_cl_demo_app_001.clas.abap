CLASS z2ui5_cl_demo_app_001 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA mv_quantity TYPE string.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS on_init.
    METHODS display_view.
    METHODS on_event.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_001 IMPLEMENTATION.

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

  METHOD display_view.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    view->shell(
        )->page(
            title          = `abap2UI5 - First Example`
            navbuttonpress = client->_event_nav_app_leave( )
            shownavbutton  = client->check_app_prev_stack( )
        )->simple_form(
            title    = `Form Title`
            editable = abap_true
        )->content( `form`
        )->title( `Input`
        )->label( `quantity`
        )->input( client->_bind_edit( mv_quantity )
        )->label( `product`
        )->input(
            value   = 'My Product'
            enabled = abap_false
        )->button(
            text  = `post`
            press = client->_event( `BUTTON_POST` ) ).
    client->view_display( view->stringify( ) ).
      
  ENDMETHOD.

  METHOD on_event.

    CASE client->get_event( ).
      WHEN `BUTTON_POST`.
        client->message_toast_display( |My Product: { mv_quantity } - send to the server| ).
    ENDCASE.

  ENDMETHOD.

  METHOD on_init.

    mv_quantity = `500`.

  ENDMETHOD.
  
ENDCLASS.
