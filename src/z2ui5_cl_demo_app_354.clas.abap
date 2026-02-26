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

    DATA(page) = view->add( name = `Shell`
      )->add( name   = `Page`
              t_prop = VALUE #( ( n = `title`          v = `abap2UI5 - Generic XML View Builder` )
                                ( n = `navButtonPress` v = client->_event( `BACK` ) )
                                ( n = `showNavButton`  v = client->check_app_prev_stack( ) ) ) ).

    DATA(form) = page->add( name   = `SimpleForm`
                            ns     = `form`
                            t_prop = VALUE #( ( n = `title`    v = `Generic Builder Demo` )
                                              ( n = `editable` v = `true` ) ) ).

    DATA(content) = form->add( name = `content`
                               ns   = `form` ).

    content->add_leaf( name   = `Title`
                       ns     = `core`
                       t_prop = VALUE #( ( n = `text` v = `Input` ) ) ).

    content->add_leaf( name   = `Label`
                       t_prop = VALUE #( ( n = `text` v = `Name` ) ) ).

    content->add_leaf( name   = `Input`
                       t_prop = VALUE #( ( n = `value` v = client->_bind_edit( name ) ) ) ).

    content->add_leaf( name   = `Label`
                       t_prop = VALUE #( ( n = `text` v = `Quantity` ) ) ).

    content->add_leaf( name   = `Input`
                       t_prop = VALUE #( ( n = `value` v = client->_bind_edit( quantity ) ) ) ).

    content->add_leaf( name   = `Button`
                       t_prop = VALUE #( ( n = `text`  v = `Send` )
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
