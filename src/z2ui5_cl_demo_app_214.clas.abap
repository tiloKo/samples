CLASS z2ui5_cl_demo_app_214 DEFINITION PUBLIC.
  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA mo_client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.

    METHODS display_view.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_214 IMPLEMENTATION.

  METHOD display_view.

    DATA(lo_view) = z2ui5_cl_xml_view=>factory( ).
    DATA(lo_page) = lo_view->shell(
         )->page(
            title          = `abap2UI5 - Sample: Standalone Icon Tab Header`
            navbuttonpress = mo_client->_event_nav_app_leave( )
            shownavbutton  = mo_client->check_app_prev_stack( ) ).

    DATA(lo_layout) = lo_page->icon_tab_header( mode = `Inline`
                          )->items(
                              )->icon_tab_filter( key  = `info`
                                                  text = `Info` )->get_parent(
                              )->icon_tab_filter( key   = `attachments`
                                                  text  = `Attachments`
                                                  count = `3` )->get_parent(
                              )->icon_tab_filter( key   = `notes`
                                                  text  = `Notes`
                                                  count = `12` )->get_parent(
                              )->icon_tab_filter( key  = `people`
                                                  text = `People` ).

    mo_client->view_display( lo_view->stringify( ) ).
  ENDMETHOD.

  METHOD z2ui5_if_app~main.

    me->mo_client = client.

    IF client->check_on_init( ).
      display_view( ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
