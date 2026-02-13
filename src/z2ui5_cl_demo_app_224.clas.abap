CLASS z2ui5_cl_demo_app_224 DEFINITION PUBLIC.
  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA mo_client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.

    METHODS display_view.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_224 IMPLEMENTATION.

  METHOD display_view.

    DATA(lo_view) = z2ui5_cl_xml_view=>factory( ).
    DATA(lo_page) = lo_view->shell(
         )->page(
            title          = `Sample: Icon Tab Bar - Text Only`
            navbuttonpress = mo_client->_event_nav_app_leave( )
            shownavbutton  = mo_client->check_app_prev_stack( ) ).

    DATA(lo_layout) = lo_page->icon_tab_bar( id       = `idIconTabBarNoIcons`
                                       expanded = `{device>/isNoPhone}`
                                       class    = `sapUiResponsiveContentPadding`
                          )->items(
                              )->icon_tab_filter( text = `Info`
                                                  key  = `info`
                                                  )->text( text = `Info content goes here ...` )->get_parent(
                              )->icon_tab_filter( text = `Attachments`
                                                  key  = `attachments`
                                                  )->text( text = `Attachments go here ...` )->get_parent(
                              )->icon_tab_filter( text = `Notes`
                                                  key  = `notes`
                                                  )->text( text = `Notes go here ...` )->get_parent(
                              )->icon_tab_filter( text = `People`
                                                  key  = `people`
                                                  )->text( text = `People content goes here ...` ).

    mo_client->view_display( lo_view->stringify( ) ).
  ENDMETHOD.

  METHOD z2ui5_if_app~main.

    me->mo_client = client.

    IF client->check_on_init( ).
      display_view( ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
