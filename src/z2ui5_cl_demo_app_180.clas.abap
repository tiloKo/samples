CLASS z2ui5_cl_demo_app_180 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .
    DATA mv_url TYPE string.

    METHODS on_event.
    METHODS view_display.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_180 IMPLEMENTATION.


  METHOD on_event.

    IF client->check_on_event( 'CALL_EF' ) IS NOT INITIAL.
      mv_url = `https://www.google.com`.
      client->view_model_update( ).
      DATA temp1 TYPE string_table.
      CLEAR temp1.
      INSERT mv_url INTO TABLE temp1.
      client->follow_up_action( val = client->_event_client( val = client->cs_event-open_new_tab t_arg = temp1 ) ).
    ENDIF.

  ENDMETHOD.


  METHOD view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->shell( )->page(
        title          = `Client->FOLLOW_UP_ACTION use cases`
        class          = `sapUiContentPadding`
        navbuttonpress = client->_event_nav_app_leave( )
        shownavbutton  = client->check_app_prev_stack( ) ).
    page = page->vbox( ).
    page->button( text  = `call frontend event from backend event`
                  press = client->_event( `CALL_EF` ) ).
    page->label( text = `MV_URL was set AFTER backend event and model update to:` ).
    page->label( text = client->_bind_edit( mv_url ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->check_on_init( ) IS NOT INITIAL.
      view_display( ).
    ENDIF.

    on_event( ).

  ENDMETHOD.
ENDCLASS.
