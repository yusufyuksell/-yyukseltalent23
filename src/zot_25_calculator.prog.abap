*&---------------------------------------------------------------------*
*& Report zot_25_calculator
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_25_calculator.

SELECTION-SCREEN BEGIN OF BLOCK b1.
  PARAMETERS: p_num1 TYPE i OBLIGATORY,
              p_num2 TYPE i OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.


SELECTION-SCREEN BEGIN OF BLOCK b2.
  PARAMETERS: p_toplam RADIOBUTTON GROUP gr1,
              p_carpma RADIOBUTTON GROUP gr1,
              p_cikar  RADIOBUTTON GROUP gr1,
              p_bolme  RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.



  DATA: gv_sonuc  TYPE i,
        gv_choose TYPE c.



  IF p_cikar EQ abap_true.
      gv_sonuc = p_num1 - p_num2.
      cl_demo_output=>write( | İki sayının farkı:  { gv_sonuc } | ).
    ENDIF.




  IF p_toplam EQ abap_true.

        gv_sonuc = p_num1 + p_num2.
        cl_demo_output=>write( | İki sayının toplamı:  { gv_sonuc } | ).
      ENDIF.



    IF p_carpma EQ abap_true.

        gv_sonuc = p_num1 * p_num2.
        cl_demo_output=>write( | İki sayının çarpımı: { gv_sonuc } | ).
    ENDIF.




    IF p_bolme EQ abap_true.

        TRY.
            gv_sonuc = p_num1 / p_num2.
            cl_demo_output=>write( | İki sayınıın bölümü: { gv_sonuc } | ).

          CATCH cx_sy_zerodivide.
            cl_demo_output=>write('0a bölemezsiniz.').
        ENDTRY.


      ENDIF.



*cl_demo_output=>write( gv_sonuc ).
*
    cl_demo_output=>display( ).
