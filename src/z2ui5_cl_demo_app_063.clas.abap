CLASS z2ui5_cl_demo_app_063 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA mo_client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.

    METHODS display_view.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_063 IMPLEMENTATION.

  METHOD display_view.

    DATA(lo_view) = z2ui5_cl_xml_view=>factory( ).
    DATA(lo_page) = lo_view->shell(
         )->page(
            title          = `abap2UI5 - Badge Example`
            navbuttonpress = mo_client->_event_nav_app_leave( )
            shownavbutton  = mo_client->check_app_prev_stack( ) ).

    DATA(lo_layout) = lo_page->vertical_layout( class = `sapUiContentPadding`
                                          width = `100%` ).
    lo_layout->button(
                text  = `Emphasized Button with Badge`
                type  = `Emphasized`
                class = `sapUiTinyMarginBeginEnd`
                icon  = `sap-icon://cart` )->get(
                )->custom_data(
                    )->badge_custom_data(
                        key     = `badge`
                        value   = `23`
                        visible = abap_true ).

    mo_client->view_display( lo_view->stringify( ) ).
  ENDMETHOD.

  METHOD z2ui5_if_app~main.

    me->mo_client = client.

    IF client->check_on_init( ).
      display_view( ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
