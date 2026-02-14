CLASS z2ui5_cl_demo_app_010 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    METHODS display_view.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_010 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    me->client = client.
    display_view( ).

  ENDMETHOD.

  METHOD display_view.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    DATA(lo_page) = view->shell(
        )->page(
            title          = `abap2UI5 - Demo Layout`
            navbuttonpress = client->_event_nav_app_leave( )
            shownavbutton  = client->check_app_prev_stack( ) ).

    lo_page->header_content(
      )->button( text = `button` ).

    lo_page->sub_header(
        )->overflow_toolbar(
            )->button( text = `button`
            )->text( `text`
            )->link( text = `link`
                     href = `https://twitter.com/abap2UI5`
            )->toolbar_spacer(
            )->text( `subheader`
            )->toolbar_spacer(
            )->button( text = `button`
            )->text( `text`
            )->link( text = `link`
                     href = `https://twitter.com/abap2UI5` ).

    DATA(lo_grid) = lo_page->grid( `L4 M4 S4` )->content( `layout` ).

    lo_grid->simple_form( `Grid width 33%` )->content( `form`
       )->button( text = `button`
       )->text( `text`
       )->link( text = `link`
                href = `https://twitter.com/abap2UI5` ).

    lo_grid->simple_form( `Grid width 33%` )->content( `form`
      )->button( text = `button`
      )->text( `text`
      )->link( text = `link`
               href = `https://twitter.com/abap2UI5` ).

    lo_grid->simple_form( `Grid width 33%` )->content( `form`
      )->button( text = `button`
      )->text( `text`
      )->link( text = `link`
               href = `https://twitter.com/abap2UI5` ).

    lo_grid = lo_page->grid( `L12 M12 S12` )->content( `layout` ).

    lo_grid->simple_form( `grid width 100%` )->content( `form`
      )->button( text = `button`
      )->text( `text`
      )->link( text = `link`
               href = `https://twitter.com/abap2UI5` ).

    lo_page->footer(
        )->overflow_toolbar(
            )->button( text = `button`
            )->text( `text`
            )->link( text = `link`
                     href = `https://twitter.com/abap2UI5`
            )->toolbar_spacer(
            )->text( `footer`
            )->toolbar_spacer(
            )->text( `text`
            )->link( text = `link`
                     href = `https://twitter.com/abap2UI5`
            )->button( text  = `reject`
           type  = `Reject`
    )->button( text  = `accept`
           type  = `Success` ).

    client->view_display( view->stringify( ) ).
    
  ENDMETHOD.
ENDCLASS.
