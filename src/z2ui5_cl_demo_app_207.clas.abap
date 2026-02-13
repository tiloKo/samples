CLASS z2ui5_cl_demo_app_207 DEFINITION PUBLIC.
  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA mo_client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.

    METHODS display_view.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_207 IMPLEMENTATION.

  METHOD display_view.

    DATA(lo_view) = z2ui5_cl_xml_view=>factory( ).
    DATA(lo_page) = lo_view->shell(
         )->page(
            title          = `abap2UI5 - Sample: Radio Button`
            navbuttonpress = mo_client->_event_nav_app_leave( )
            shownavbutton  = mo_client->check_app_prev_stack( ) ).

    DATA(lo_layout) = lo_page->vbox( class = `sapUiSmallMargin`
                          )->label( text     = `Default RadioButton use`
                                    labelfor = `GroupA`
                          )->radio_button_group( id = `GroupA`
                              )->radio_button( text     = `Option 1`
                                               selected = abap_true )->get_parent(
                              )->radio_button( text = `Option 2` )->get_parent(
                              )->radio_button( text = `Option 3` )->get_parent(
                              )->radio_button( text = `Option 4` )->get_parent(
                              )->radio_button( text = `Option 5` )->get_parent( )->get_parent( )->get_parent(
                      )->vbox( class = `sapUiSmallMargin`
                          )->label( text = `RadioButton in various ValueState variants`
                          )->hbox( class = `sapUiTinyMarginTopBottom`
                              )->vbox( class = `sapUiMediumMarginEnd`
                                  )->label( text     = `Success`
                                            labelfor = `GroupB`
                                  )->radio_button_group( id         = `GroupB`
                                                         valuestate = `Success`
                                      )->radio_button( text     = `Option 1`
                                                       selected = abap_true )->get_parent(
                                      )->radio_button( text = `Option 2` )->get_parent( )->get_parent( )->get_parent(
                              )->vbox( class = `sapUiMediumMarginEnd`
                                  )->label( text     = `Error`
                                            labelfor = `GroupC`
                                  )->radio_button_group( id         = `GroupC`
                                                         valuestate = `Error`
                                      )->radio_button( text     = `Option 1`
                                                       selected = abap_true )->get_parent(
                                      )->radio_button( text = `Option 2` )->get_parent( )->get_parent( )->get_parent(
                              )->vbox( class = `sapUiMediumMarginEnd`
                                  )->label( text     = `Warning`
                                            labelfor = `GroupD`
                                  )->radio_button_group( id         = `GroupD`
                                                         valuestate = `Warning`
                                      )->radio_button( text     = `Option 1`
                                                       selected = abap_true )->get_parent(
                                      )->radio_button( text = `Option 2` )->get_parent( )->get_parent( )->get_parent(
                              )->vbox( class = `sapUiMediumMarginEnd`
                                  )->label( text     = `Information`
                                            labelfor = `GroupE`
                                  )->radio_button_group( id         = `GroupE`
                                                         valuestate = `Information`
                                      )->radio_button( text     = `Option 1`
                                                       selected = abap_true )->get_parent(
                                      )->radio_button( text = `Option 2` )->get_parent( ).

    mo_client->view_display( lo_view->stringify( ) ).
  ENDMETHOD.

  METHOD z2ui5_if_app~main.

    me->mo_client = client.

    IF client->check_on_init( ).
      display_view( ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
