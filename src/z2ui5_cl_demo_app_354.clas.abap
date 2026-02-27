CLASS z2ui5_cl_demo_app_354 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA name     TYPE string.
    DATA quantity TYPE string.
    DATA is_admin TYPE abap_bool.

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

    DATA(view) = z2ui5_cl_xml_view_generic=>factory(
        t_ns = VALUE #( ( n = `xmlns:form` v = `sap.ui.layout.form` ) ) ).

    DATA(content) = view->_( `Shell`
      )->_( n = `Page`
            p = VALUE #( ( n = `title`          v = `abap2UI5 - Generic XML View Builder` )
                         ( n = `navButtonPress` v = client->_event( `BACK` ) )
                         ( n = `showNavButton`  v = client->check_app_prev_stack( ) ) )
      )->_( n  = `SimpleForm`
            ns = `form`
            p  = VALUE #( ( n = `title`    v = `Generic Builder Demo` )
                          ( n = `editable` v = `true` ) )
      )->_( n  = `content`
            ns = `form` ).

    content->__( n  = `Title`
                 ns = `core`
                 a  = `text`
                 v  = `Input` ).

    content->__( n = `Label` a = `text` v = `Name` ).

    content->__( n = `Input` a = `value` v = client->_bind_edit( name ) ).

    content->__( n = `Label` a = `text` v = `Quantity` ).

    content->__( n = `Input` a = `value` v = client->_bind_edit( quantity ) ).

    content->__if( when = is_admin
                   n    = `Input`
                   a    = `value`
                   v    = `Admin Secret` ).

    content->_( n = `Button` a = `text` v = `Send`
      )->p( n = `press` v = client->_event( `POST` )
      )->p( n = `icon`  v = `sap-icon://paper-plane`
      )->p( n = `type`  v = `Emphasized`
      )->n( `content` ).

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
