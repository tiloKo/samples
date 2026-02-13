CLASS z2ui5_cl_demo_app_s_02 DEFINITION PUBLIC.
  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.
    DATA mv_instance_counter TYPE i READ-ONLY.
    DATA mv_session_is_stateful TYPE abap_bool READ-ONLY.
    DATA mv_session_text TYPE string READ-ONLY.

    DATA mo_client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS initialize_view.

    METHODS on_event.

    METHODS set_session_stateful
      IMPORTING
        stateful TYPE abap_bool.

ENDCLASS.

CLASS z2ui5_cl_demo_app_s_02 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    me->mo_client = client.

    TRY.

        IF client->check_on_init( ).
          initialize_view( ).
        ENDIF.

        on_event( ).

      CATCH cx_root INTO DATA(lx).
        client->message_box_display( lx->get_text( ) ).
    ENDTRY.
  ENDMETHOD.

  METHOD initialize_view.

    set_session_stateful( client   = client
                          stateful = abap_true ).

    DATA(lo_view) = z2ui5_cl_xml_view=>factory( ).

    DATA(lo_page) = lo_view->shell( )->page(
      title          = `abap2UI5 - Sample: Sticky Session`
      navbuttonpress = mo_client->_event_nav_app_leave( )
      shownavbutton  = mo_client->check_app_prev_stack( ) ).

    DATA(lo_vbox) = lo_page->vbox( ).
    lo_vbox->info_label( text = mo_client->_bind( mv_session_text ) ).

    DATA(lo_hbox) = lo_vbox->hbox( alignitems = `Center` ).
    lo_hbox->label( text  = `press button to increment counter in backend session`
                 class = `sapUiTinyMarginEnd` ).
    lo_hbox->button(
      text  = mo_client->_bind( mv_instance_counter )
      press = mo_client->_event( `INCREMENT` )
      type  = `Emphasized` ).

    lo_hbox = lo_vbox->hbox( ).
    lo_hbox->button(
      text  = `End session`
      press = mo_client->_event( `END_SESSION` ) ).

    lo_hbox->button(
      text  = `Start session again`
      press = mo_client->_event( `START_SESSION` ) ).

    mo_client->view_display( lo_view->stringify( ) ).
  ENDMETHOD.

  METHOD on_event.

    CASE mo_client->get( )-event.
      WHEN `BACK`.
        set_session_stateful( client   = client
                              stateful = abap_false ).
        mo_client->nav_app_leave( ).
      WHEN `INCREMENT`.
        mv_instance_counter = lcl_static_container=>increment( ).
        mo_client->view_model_update( ).
      WHEN `END_SESSION`.
        set_session_stateful( client   = client
                              stateful = abap_false ).
      WHEN `START_SESSION`.
        set_session_stateful( client   = client
                              stateful = abap_true ).
    ENDCASE.
  ENDMETHOD.

  METHOD set_session_stateful.

    mo_client->set_session_stateful( stateful ).
    mv_session_is_stateful = stateful.
    IF stateful = abap_true.
      mv_session_text = `Session ON (stateful)`.
    ELSE.
      mv_session_text = `Session OFF (stateless)`.
    ENDIF.
    mo_client->view_model_update( ).
  ENDMETHOD.
ENDCLASS.
