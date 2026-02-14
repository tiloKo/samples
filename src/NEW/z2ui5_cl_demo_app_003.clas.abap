CLASS z2ui5_cl_demo_app_003 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        title    TYPE string,
        value    TYPE string,
        descr    TYPE string,
        icon     TYPE string,
        info     TYPE string,
        selected TYPE abap_bool,
        checkbox TYPE abap_bool,
      END OF ty_row.

    DATA mt_tab TYPE STANDARD TABLE OF ty_row WITH EMPTY KEY.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS on_init.
    METHODS display_view.
    METHODS on_event.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_003 IMPLEMENTATION.

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

  METHOD on_init.

    mt_tab = VALUE #(
        ( title = `row_01`  info = `completed`   descr = `this is a description` icon = `sap-icon://account` )
        ( title = `row_02`  info = `incompleted` descr = `this is a description` icon = `sap-icon://account` )
        ( title = `row_03`  info = `working`     descr = `this is a description` icon = `sap-icon://account` )
        ( title = `row_04`  info = `working`     descr = `this is a description` icon = `sap-icon://account` )
        ( title = `row_05`  info = `completed`   descr = `this is a description` icon = `sap-icon://account` )
        ( title = `row_06`  info = `completed`   descr = `this is a description` icon = `sap-icon://account` ) ).

  ENDMETHOD.

  METHOD display_view.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    client->view_display( view->shell(
        )->page(
            title           = `abap2UI5 - List`
            navbuttonpress  = client->_event_nav_app_leave( )
            shownavbutton   = client->check_app_prev_stack( )
        )->list(
            headertext      = `List Output`
            items           = client->_bind_edit( mt_tab )
            mode            = `SingleSelectMaster`
            selectionchange = client->_event( `SELCHANGE` )
            )->standard_list_item(
                title       = `{TITLE}`
                description = `{DESCR}`
                icon        = `{ICON}`
                info        = `{INFO}`
                press       = client->_event( `TEST` )
                selected    = `{SELECTED}`
            )->stringify( ) ).
            
  ENDMETHOD.

  METHOD on_event.

    CASE client->get( )-event.
      WHEN `SELCHANGE`.
        client->message_box_display( `go to details for item ` && mt_tab[ selected = abap_true ]-title ).
      WHEN `TEST`.
        client->message_toast_display( `Item pressed` ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
