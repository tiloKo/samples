CLASS z2ui5_cl_demo_app_230 DEFINITION PUBLIC.
  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA mo_client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.

    METHODS display_view.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_230 IMPLEMENTATION.

  METHOD display_view.

    DATA(lo_view) = z2ui5_cl_xml_view=>factory( ).
    DATA(lo_page) = lo_view->shell(
         )->page(
            title          = `abap2UI5 - Sample: Segmented Button in Input List Item`
            navbuttonpress = mo_client->_event_nav_app_leave( )
            shownavbutton  = mo_client->check_app_prev_stack( ) ).

    DATA(lo_layout) = lo_page->list(
                          headertext = `Input List Item`
                          )->input_list_item( label = `Battery Saving`
                              )->segmented_button( selected_key = `SBYes`
                                  )->items(
                                      )->segmented_button_item( text = `High`
                                                                key  = `SBYes`
                                      )->segmented_button_item( text = `Low`
                                      )->segmented_button_item( text = `Off` ).

    mo_client->view_display( lo_view->stringify( ) ).
  ENDMETHOD.

  METHOD z2ui5_if_app~main.

    me->mo_client = client.

    IF client->check_on_init( ).
      display_view( ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
