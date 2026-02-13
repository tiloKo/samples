CLASS z2ui5_cl_demo_app_352 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.
    DATA mv_input TYPE string.

    METHODS display_view.

    METHODS on_event.

    DATA mo_client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_352 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    me->mo_client = client.

    IF client->check_on_init( ).
      display_view( ).
    ENDIF.
    on_event( ).
  ENDMETHOD.

  METHOD display_view.

    DATA(lo_view) = z2ui5_cl_xml_view=>factory( ).

    lo_view->_generic( name = `script`
                    ns   = `html` )->_cc_plain_xml( `z2ui5.afterBE = (id , mode) => { ` &&
                       `debugger;` &&
                        `var input = z2ui5.oView.byId(id).getDomRef();` &&
                        `input = input.childNodes[0].childNodes[0];` &&
                        `input.setAttribute("inputmode" , mode);` &&
                        ` alert("inputmode changed to" + mode); }` ).

    DATA(lo_page) = lo_view->shell(
             )->page( title          = `abap2UI5 - Softkeyboard on/off`
                      navbuttonpress = mo_client->_event_nav_app_leave( )
                      shownavbutton  = mo_client->check_app_prev_stack( )
                      )->_z2ui5( )->focus( focusid = `ZINPUT`
      )->simple_form( editable = abap_true
                 )->content( `form`
                     )->title( `Keyboard on/off`
                     )->label( `Input`
                     )->input( id               = `ZINPUT`
                               value            = mo_client->_bind_edit( mv_input )
                               showvaluehelp    = abap_true
                               valuehelprequest = mo_client->_event( `CALL_KEYBOARD` )
                               valuehelpiconsrc = `sap-icon://keyboard-and-mouse` ).

    mo_client->view_display( lo_view->stringify( ) ).
  ENDMETHOD.

  METHOD on_event.

    IF mo_client->check_on_event( `CALL_KEYBOARD` ).
      mo_client->follow_up_action( `z2ui5.afterBE("ZINPUT", "none");` ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
