CLASS z2ui5_cl_demo_app_336 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    METHODS view_display.

    DATA ms_struc        TYPE z2ui5_t_01.
    DATA mo_layout_obj   TYPE REF TO z2ui5_cl_demo_app_333.
    DATA mo_layout_obj_2 TYPE REF TO z2ui5_cl_demo_app_333.

    CLASS-METHODS factory
      RETURNING
        VALUE(result) TYPE REF TO z2ui5_cl_demo_app_336.

    DATA mo_client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_336 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    me->mo_client = client.

    IF client->check_on_init( ).

      mo_layout_obj = z2ui5_cl_demo_app_333=>factory( i_data   = REF #( ms_struc )
                                                      vis_cols = 3 ).
      mo_layout_obj_2 = z2ui5_cl_demo_app_333=>factory( i_data   = REF #( ms_struc )
                                                        vis_cols = 3 ).

      view_display( ).

    ENDIF.
    client->view_model_update( ).
  ENDMETHOD.

  METHOD view_display.

    DATA(lo_view) = z2ui5_cl_xml_view=>factory( ).
    DATA(lo_page) = lo_view->shell( )->page( title          = `RTTI IV`
                                                                navbuttonpress = mo_client->_event_nav_app_leave( )
                                                                shownavbutton  = mo_client->check_app_prev_stack( ) ).

    lo_page->button( text  = `BACK`
                  press = mo_client->_event_nav_app_leave( )
                  type  = `Success` ).

    mo_client->view_display( lo_view->stringify( ) ).
  ENDMETHOD.

  METHOD factory.

    result = NEW #( ).
  ENDMETHOD.
ENDCLASS.
