*&---------------------------------------------------------------------*
*& Include zot_25_i_report_cls
*&---------------------------------------------------------------------*


CLASS lcl_main_controller DEFINITION CREATE PRIVATE FINAL.
  PUBLIC SECTION.

    CLASS-METHODS:
      "! Main controller get singleton object
      get_instance
        RETURNING
          VALUE(ro_instance) TYPE REF TO lcl_main_controller.

    METHODS:
      "! Selection screen output event
      "! Get report data
      "! Display report
      display_grid.

  PRIVATE SECTION.
    CLASS-DATA:
      "! Singleton object
      mo_instance              TYPE REF TO lcl_main_controller,
      mo_main_custom_container TYPE REF TO cl_gui_custom_container,
      mo_main_grid             TYPE REF TO cl_gui_alv_grid,
      mt_alv_list              TYPE TABLE OF zot_25_s_eban.

    METHODS:
      fill_main_fieldcat
        RETURNING
          VALUE(rt_fcat) TYPE lvc_t_fcat,
      fill_main_layout
        RETURNING
          VALUE(rs_layo) TYPE lvc_s_layo.

ENDCLASS.

CLASS lcl_main_controller IMPLEMENTATION.
  METHOD get_instance.
    IF mo_instance IS INITIAL.
      mo_instance = NEW #( ).
    ENDIF.
    ro_instance = mo_instance.
  ENDMETHOD.





  METHOD display_grid.



    DATA: lv_title TYPE lvc_title,
          lv_lines TYPE num10.

    FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE,
                   <ls_data> TYPE any.

    ASSIGN me->mt_alv_list TO <lt_data>.
    CHECK sy-subrc IS INITIAL.
*
    DATA(ls_layo) = VALUE lvc_s_layo( zebra      = abap_true
                                      cwidth_opt = abap_true
                                      sel_mode   = 'A'
                                      excp_fname = 'COLOR'
                                      excp_led   = abap_true ).
    DATA(ls_vari) = VALUE disvariant( report = sy-repid
                                      username = sy-uname ).

    DATA(lt_fcat_main) = me->fill_main_fieldcat( ).

    DESCRIBE TABLE <lt_data> LINES lv_lines.
    SHIFT lv_lines LEFT DELETING LEADING '0'.

    CONCATENATE 'Rapor' lv_lines 'Kayıt' INTO lv_title SEPARATED BY space.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        i_grid_title       = lv_title
        is_layout_lvc      = ls_layo
        it_fieldcat_lvc    = lt_fcat_main
        i_save             = 'A'
        is_variant         = ls_vari
      TABLES
        t_outtab           = <lt_data>
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.


  ENDMETHOD.

  METHOD fill_main_fieldcat.
    DATA: lv_fname  TYPE lvc_fname,
          lv_offset TYPE i.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZOT_25_S_EBAN'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = rt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.


    LOOP AT rt_fcat ASSIGNING FIELD-SYMBOL(<ls_fcat>).
      CASE <ls_fcat>-fieldname.

        WHEN 'MATNR'.
          <ls_fcat>-scrtext_l =
          <ls_fcat>-scrtext_M =
          <ls_fcat>-scrtext_S =
          <ls_fcat>-reptext = 'DENEMEEE'.

          <ls_fcat>-hotspot = abap_true.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

  METHOD fill_main_layout.
    rs_layo = VALUE lvc_s_layo( zebra = abap_true cwidth_opt = abap_true sel_mode = 'A' ).
  ENDMETHOD.


ENDCLASS.


DATA:
  "! Main controller global object
  go_main TYPE REF TO lcl_main_controller.
