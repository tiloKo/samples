CLASS z2ui5_cl_demo_app_354 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA name     TYPE string.
    DATA quantity TYPE string.

  PRIVATE SECTION.
    DATA client TYPE REF TO z2ui5_if_client.

    METHODS render.
    METHODS event.

ENDCLASS.


CLASS z2ui5_cl_demo_app_354 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    client = z2ui5_if_app~main-client.

    IF client->check_on_init( ).
      render( ).
    ENDIF.

    event( ).

  ENDMETHOD.

  METHOD render.

    DATA(view) = z2ui5_cl_xml_view_generic=>factory( ).

    DATA(page) = view->add( n = `Shell`
      )->add( n = `Page`
              p = VALUE #( ( n = `title`          v = `abap2UI5 - Generic XML View Builder` )
                           ( n = `navButtonPress` v = client->_event( `BACK` ) )
                           ( n = `showNavButton`  v = client->check_app_prev_stack( ) ) ) ).

    DATA(content) = page->add( n  = `SimpleForm`
                               ns = `form`
                               p  = VALUE #( ( n = `title`    v = `Generic Builder Demo` )
                                             ( n = `editable` v = `true` ) )
      )->add( n  = `content`
              ns = `form` ).

    content->leaf( n  = `Title`
                   ns = `core`
                   p  = VALUE #( ( n = `text` v = `Input` ) ) ).

    content->leaf( n = `Label`
                   p = VALUE #( ( n = `text` v = `Name` ) ) ).

    content->leaf( n = `Input`
                   p = VALUE #( ( n = `value` v = client->_bind_edit( name ) ) ) ).

    content->leaf( n = `Label`
                   p = VALUE #( ( n = `text` v = `Quantity` ) ) ).

    content->leaf( n = `Input`
                   p = VALUE #( ( n = `value` v = client->_bind_edit( quantity ) ) ) ).

    content->leaf( n = `Button`
                   p = VALUE #( ( n = `text`  v = `Send` )
                                ( n = `press` v = client->_event( `POST` ) )
                                ( n = `icon`  v = `sap-icon://paper-plane` )
                                ( n = `type`  v = `Emphasized` ) ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.

  METHOD event.

    CASE client->get( )-event.
      WHEN `POST`.
        client->message_box_display( |Name: { name }, Quantity: { quantity }| ).
      WHEN `BACK`.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.

ENDCLASS.
