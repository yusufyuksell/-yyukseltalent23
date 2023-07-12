*&---------------------------------------------------------------------*
*& Report zot_25_personel_sorgu
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_25_personel_sorgu.

TABLES: zot_25_t_p_mast, zot_25_t_p_egtm, zot_25_t_p_iltsm,zot_25_t_p_aile .
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_master RADIOBUTTON GROUP gr1,
              p_iletsm RADIOBUTTON GROUP gr1,
              p_aile   RADIOBUTTON GROUP gr1,
              p_egitim RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  IF p_master EQ abap_true.

    cl_demo_output=>write( zot_25_t_p_mast ).

  ENDIF.


  IF p_iletsm EQ abap_true.

    cl_demo_output=>write( zot_25_t_p_iltsm ).

  ENDIF.

  IF p_aile EQ abap_true.

    cl_demo_output=>write( zot_25_t_p_aile ).

  ENDIF.

  IF p_egitim EQ abap_true.

    cl_demo_output=>write( zot_25_t_p_egtm ).

  ENDIF.



  cl_demo_output=>display( ).
