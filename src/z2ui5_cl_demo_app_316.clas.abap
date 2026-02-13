CLASS z2ui5_cl_demo_app_316 DEFINITION PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_serializable_object.
    INTERFACES z2ui5_if_app.

    DATA mv_phone  TYPE string.
    DATA mv_mobile TYPE string.

    DATA: BEGIN OF email,
            email      TYPE string,
            subject    TYPE string,
            body       TYPE string,
            cc         TYPE string,
            bcc        TYPE string,
            new_window TYPE string,
          END OF email.

    DATA: BEGIN OF url,
            url        TYPE string,
            new_window TYPE string,
          END OF url.

    DATA mo_client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.
    METHODS display_view.

  PRIVATE SECTION.

ENDCLASS.

CLASS z2ui5_cl_demo_app_316 IMPLEMENTATION.
  METHOD display_view.

    url = VALUE #( url        = `http://www.sap.com`
                   new_window = `true` ).
    email = VALUE #( email      = `email@email.com`
                     subject    = `subject`
                     body       = `body`
                     new_window = `true` ).

    DATA(lo_view) = z2ui5_cl_xml_view=>factory( ).
    DATA(lo_page) = lo_view->_z2ui5( )->title( `URL Helper Sample`
        )->shell(
            )->page( title          = `abap2UI5 - Sample: URL Helper`
                     navbuttonpress = mo_client->_event_nav_app_leave( )
                     shownavbutton  = mo_client->check_app_prev_stack( ) ).

    DATA(lo_layout) = lo_page->vertical_layout( class = `sapUiContentPadding`
                                          width = `100%` ).

    DATA(lo_email_form) = lo_layout->simple_form( title = `Trigger E-Mail` ).

    lo_email_form->label( text     = `E-Mail`
                       labelfor = `inputEmail` ).
    lo_email_form->input( id          = `inputEmail`
                       value       = mo_client->_bind_edit( email-email )
                       type        = `Email`
                       placeholder = `Enter email`
                       class       = `sapUiSmallMarginBottom` ).

    lo_email_form->input( id          = `inputCcEmail`
                       value       = mo_client->_bind_edit( email-cc )
                       type        = `Email`
                       placeholder = `Enter cc email`
                       class       = `sapUiSmallMarginBottom` ).

    lo_email_form->input( id          = `inputBccEmail`
                       value       = mo_client->_bind_edit( email-bcc )
                       type        = `Email`
                       placeholder = `Enter bcc email`
                       class       = `sapUiSmallMarginBottom` ).

    lo_email_form->label( text     = `Subject`
                       labelfor = `inputText` ).
    lo_email_form->input( id          = `inputText`
                       value       = mo_client->_bind_edit( email-subject )
                       placeholder = `Enter text`
                       class       = `sapUiSmallMarginBottom` ).

    lo_email_form->label( `Mail Body`
         )->text_area( valueliveupdate = abap_true
                       value           = mo_client->_bind_edit( email-body )
                       growing         = abap_true
                       growingmaxlines = `7`
                       width           = `100%` ).

    lo_email_form->button( text  = `Trigger Email`
                        press = mo_client->_event_client( val   = mo_client->cs_event-urlhelper
                                                       t_arg = VALUE #( ( `TRIGGER_EMAIL` )
                                                                        ( |${ mo_client->_bind_edit( email ) }| ) ) ) ).

    DATA(lo_telephone_form) = lo_layout->simple_form( title = `Trigger Telephone` ).

    lo_telephone_form->label( text     = `Telephone`
                           labelfor = `inputTel` ).
    lo_telephone_form->input( id          = `inputTel`
                           value       = mo_client->_bind_edit( mv_phone )
                           type        = `Tel`
                           placeholder = `Enter telephone number`
                           class       = `sapUiSmallMarginBottom` ).
    lo_telephone_form->button(
        text  = `Trigger Telephone`
        press = mo_client->_event_client( val   = mo_client->cs_event-urlhelper
                                       t_arg = VALUE #( ( `TRIGGER_TEL` )
                                                        ( |${ mo_client->_bind_edit( mv_phone ) }| ) ) ) ).

    DATA(lo_mobile_form) = lo_layout->simple_form( title = `Trigger SMS` ).

    lo_mobile_form->label( text     = `Number`
                        labelfor = `inputNumber` ).
    lo_mobile_form->input( id          = `inputNumber`
                        value       = mo_client->_bind_edit( mv_mobile )
                        type        = `Number`
                        placeholder = `Enter a number`
                        class       = `sapUiSmallMarginBottom` ).
    lo_mobile_form->button( text  = `Trigger SMS`
                         press = mo_client->_event_client( val   = mo_client->cs_event-urlhelper
                                                        t_arg = VALUE #( ( `TRIGGER_SMS` )
                                                                         ( |${ mo_client->_bind_edit( mv_mobile ) }| ) ) ) ).

    DATA(lo_url_form) = lo_layout->simple_form( title = `Redirect` ).
    lo_url_form->label( text     = `URL`
                     labelfor = `inputUrl` ).
    lo_url_form->input( id          = `inputUrl`
                     value       = mo_client->_bind_edit( url-url )
                     type        = `Url`
                     placeholder = `Enter URL`
                     class       = `sapUiSmallMarginBottom` ).
    lo_url_form->button( text  = `Redirect`
                      press = mo_client->_event_client( val   = mo_client->cs_event-urlhelper
                                                     t_arg = VALUE #( ( `REDIRECT` )
                                                                      ( |${ mo_client->_bind_edit( url ) }| ) ) ) ).

    mo_client->view_display( lo_view->stringify( ) ).
  ENDMETHOD.

  METHOD z2ui5_if_app~main.

    me->mo_client = client.

    IF client->check_on_init( ).
      display_view( ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
