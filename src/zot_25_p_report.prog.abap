*&---------------------------------------------------------------------*
*& Report zot_25_p_report
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_25_p_report.

INCLUDE zot_25_i_report_cls.

INITIALIZATION.
  go_main = lcl_main_controller=>get_instance(  ).

  TABLES: eban,ekpo.
  DATA(ls_layo) = VALUE slis_fieldcat_alv(  ) .

  DATA: gt_fieldcatalog TYPE slis_t_fieldcat_alv,
        gs_fieldcatalog TYPE slis_fieldcat_alv.
  DATA: gs_layout TYPE slis_layout_alv.

  TYPES : BEGIN OF gty_eban,
            banfn         TYPE eban-banfn,
            bnfpo         TYPE eban-bnfpo,
            bsart         TYPE eban-bsart,
            matnr         TYPE eban-matnr,
            menge         TYPE eban-menge,
            meins         TYPE eban-meins,
            line_color(4) TYPE c, "line-color
          END OF gty_eban.

  DATA : gt_sat_baz TYPE TABLE OF gty_eban.

  TYPES : BEGIN OF gty_ekpo,
            ebeln         TYPE ekpo-ebeln,
            matkl         TYPE ekpo-matkl,
            matnr         TYPE ekpo-matnr,
            menge         TYPE ekpo-menge,
            meins         TYPE ekpo-meins,
            line_color(4) TYPE c, "line-color
          END OF gty_ekpo.

  DATA : gt_sas_baz TYPE TABLE OF gty_ekpo.



  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
    SELECT-OPTIONS: p_satno  FOR eban-banfn,
                    p_satbel FOR eban-bnfpo.
  SELECTION-SCREEN END OF BLOCK b1.

  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
    SELECT-OPTIONS: p_sasno  FOR ekpo-ebeln,
                    p_sasmal FOR ekpo-matkl.
  SELECTION-SCREEN END OF BLOCK b2.


  PARAMETERS: rb_sat RADIOBUTTON GROUP gr1,
              rb_sas RADIOBUTTON GROUP gr1.
  "~

START-OF-SELECTION.

  IF ( rb_sat EQ 'X' ).





    SELECT eban~banfn,
           eban~bnfpo,
           eban~bsart,
           eban~matnr,
           eban~menge,
           eban~meins
           FROM eban INNER JOIN ekpo ON eban~banfn = ekpo~banfn
                                     AND eban~bnfpo = ekpo~bnfpo
                                     WHERE eban~banfn IN @p_satno
                                     AND eban~bnfpo IN @p_satbel
           INTO TABLE @gt_sat_baz.

    "cl_demo_output=>write( gt_sat_baz ).
    "go_main->display_grid( ).

    DATA(lt_fcat_eban) = VALUE slis_t_fieldcat_alv( (  fieldname = 'BANFN' seltext_m = 'SAT No'  )
                                                ( fieldname = 'BNFPO' seltext_m = 'SAT Kalem No' )
                                                ( fieldname = 'BSART' seltext_m = 'SAT Belge Türü' )
                                                ( fieldname = 'MATNR' seltext_m = 'Malzeme No' )
                                                ( fieldname = 'MENGE' seltext_m = 'SAT Miktarı'  )
                                                ( fieldname = 'MEINS' seltext_m = 'SAT Ölçü Miktarı'  ) ).

    LOOP AT gt_sat_baz INTO DATA(gs_sat_baz).
      IF gs_sat_baz-menge > 10.
        gs_sat_baz-line_color = 'C5'.
        MODIFY gt_sat_baz FROM gs_sat_baz.
      ENDIF.

    ENDLOOP.

    gs_layout-colwidth_optimize = abap_true.
    gs_layout-info_fieldname = 'LINE_COLOR'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program     = sy-repid
        it_fieldcat            = lt_fcat_eban
        i_callback_top_of_page = 'TOP-OF-PAGE'
        is_layout              = gs_layout
      TABLES
        t_outtab               = gt_sat_baz.


  ENDIF.




  IF ( rb_sas EQ 'X' ).
    SELECT ekpo~ebeln,
           ekpo~ebelp,
           ekpo~matnr,
           ekpo~ktmng,
           ekpo~meins
           FROM ekpo INNER JOIN eban ON eban~banfn = ekpo~banfn
                                       AND eban~bnfpo = ekpo~bnfpo
                                       WHERE ekpo~ebeln IN @p_sasno
                                       AND ekpo~matkl IN @p_sasmal
                                INTO TABLE @gt_sas_baz.

    DATA(lt_fcat_ekpo) = VALUE slis_t_fieldcat_alv( ( fieldname = 'EBELN' seltext_m = 'SAS No'  )
                                                    ( fieldname = 'EBELP'  seltext_m = 'SAS Kalem No' )
                                                    ( fieldname = 'MATNR'  seltext_m = 'SAS Malzeme' )
                                                    ( fieldname = 'KTMNG'  seltext_m = 'SAS Miktarı' )
                                                    ( fieldname = 'MEINS'  seltext_m = 'Ölçü Birimi'  ) ).

    LOOP AT gt_sas_baz INTO DATA(gs_sas_baz).
      IF gs_sas_baz-menge < 10.
        gs_sas_baz-line_color = 'C510'.
        MODIFY gt_sas_baz FROM gs_sas_baz.
      ENDIF.

    ENDLOOP.

    gs_layout-colwidth_optimize = abap_true.
    gs_layout-info_fieldname = 'LINE_COLOR'.



    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program     = sy-repid
        it_fieldcat            = lt_fcat_ekpo
        i_callback_top_of_page = 'TOP-OF-PAGE'
        is_layout              = gs_layout
      TABLES
        t_outtab               = gt_sas_baz.

    "cl_demo_output=>write( gt_sas_baz ).
  ENDIF.
*  "cl_demo_output=>display(  ).







FORM top-of-page.
  DATA: t_header  TYPE slis_t_listheader,
        wa_header TYPE slis_listheader.


*  Type S is used to display key and value pairs
  wa_header-typ = 'S'.
  wa_header-key = 'Tarih :' .
  CONCATENATE  sy-datum+6(2)
               sy-datum+4(2)
               sy-datum(4)
               INTO wa_header-info
               SEPARATED BY '/'.
  APPEND wa_header TO t_header.
  CLEAR wa_header.


  wa_header-typ = 'S'.
  wa_header-key = 'Saat :' .
  CONCATENATE sy-uzeit(2)
              sy-uzeit+2(2)
              sy-uzeit+4(2)
              into wa_header-info
              SEPARATED BY ':'.
  APPEND wa_header TO t_header.
  CLEAR wa_header.




  "Program ismi
  wa_header-typ  = 'H'.
  wa_header-info = sy-repid.
  APPEND wa_header TO t_header.
  CLEAR wa_header.

  " Kullanıcı
  wa_header-typ  = 'A'.
  wa_header-info = sy-uname.
  APPEND wa_header TO t_header.
  CLEAR wa_header.

*  " Tarih
*  wa_header-typ  = 'S'.
*  wa_header-key = sy-datum.
*  wa_header-info = sy-uzeit.
*  APPEND wa_header TO t_header.
*  CLEAR wa_header.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = t_header.
ENDFORM.
