*&---------------------------------------------------------------------*
*& Report zot_25_calculator
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_25_calculator.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME title text-001.
  PARAMETERS: p_num1 TYPE p DECIMALS 2 OBLIGATORY,
              p_num2 TYPE p DECIMALS 2 OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.


SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME title text-002.
  PARAMETERS: p_toplam RADIOBUTTON GROUP gr1,
              p_carpma RADIOBUTTON GROUP gr1,
              p_cikar  RADIOBUTTON GROUP gr1,
              p_bolme  RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.




  IF p_cikar EQ abap_true.
    cl_demo_output=>write( | İki sayının farkı:  { p_num1 - p_num2 } | ).
  ENDIF.


  IF p_toplam EQ abap_true.
    cl_demo_output=>write( | İki sayının toplamı:  { p_num1 + p_num2 } | ).
  ENDIF.


  IF p_carpma EQ abap_true.
    cl_demo_output=>write( | İki sayının çarpımı: { p_num1 * p_num2 } | ).
  ENDIF.



  IF p_bolme EQ abap_true.
    TRY.
        cl_demo_output=>write( | İki sayınıın bölümü: { p_num1 / p_num2 } | ).
      CATCH cx_sy_zerodivide.
        cl_demo_output=>write('0a bölemezsiniz.').
    ENDTRY.
  ENDIF.


  cl_demo_output=>display( ).
