*&---------------------------------------------------------------------*
*& Report zot_25_odev1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_25_odev1.

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
*  PARAMETERS: p_maxnum TYPE i OBLIGATORY,
*              p_krlm   TYPE i  OBLIGATORY.
*SELECTION-SCREEN END OF BLOCK b1.
*
*
*
*DATA(gv_sayi) = 0.
*
*START-OF-SELECTION.
*
*  IF p_krlm < 10 .
*    DO p_maxnum TIMES.
*
*      gv_sayi += 1.
*
*      IF gv_sayi MOD p_krlm = 0.
*        WRITE gv_sayi.
*        WRITE /.
*
*      ELSE.
*        WRITE: gv_sayi.
*      ENDIF.
*
*    ENDDO.
*
*  ELSE.
*    WRITE: 'Kırılım 10dan küçük olmalıdır.'.
*  ENDIF.
*  cl_demo_output=>display(  ).

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*PARAMETERS: p_prmtr1 TYPE numc3 OBLIGATORY.
*PARAMETERS: p_prmtr2 TYPE numc1 OBLIGATORY.
*
*DATA: n1 TYPE int4,
*      n2 TYPE int4 VALUE 1,
*      n3 TYPE int4.
*
*DATA: lv_counter TYPE int1 VALUE 2.
*DATA: lv_counter2 TYPE int1 VALUE 1.
*
*START-OF-SELECTION.
*
*IF ( p_prmtr1 > 100 OR p_prmtr1 < 0 ) OR  ( p_prmtr2 > 10 OR p_prmtr1 < 0 ).
*    MESSAGE 'Lütfen geçerli bir sayı giriniz.' TYPE 'I'.
*else.
*
*  WHILE ( lv_counter LT p_prmtr1 ).
*
*    IF lv_counter2 MOD p_prmtr2 = 0.
*
*    n3 = n1 + n2.
*    if n3 ge p_prmtr1.
*    exit.
*    endif.
*    WRITE  n3.
*    n1 = n2.
*    n2 = n3.
*
*      NEW-LINE.
*    ELSE.
*
*    n3 = n1 + n2.
*       if n3 ge p_prmtr1.
*        exit.
*      endif.
*
*      WRITE  n3.
*    n1 = n2.
*    n2 = n3.
*
*      ENDIF.
*
*    lv_counter = lv_counter + 1.
*    lv_counter2 = lv_counter2 + 1.
*
*  ENDWHILE.
*
*
*  ENDIF.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_bir TYPE int4 OBLIGATORY,
              p_iki TYPE int4  OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

data(gv_count) = 2.

DO p_iki TIMES.
  WHILE gv_count <= p_iki / 2.
    IF ( p_iki MOD gv_count ) = 0.
      DATA(lv_non_prime) = abap_true.
      EXIT.
    ENDIF.
    gv_count = gv_count + 1.
  ENDWHILE.

  IF lv_non_prime = abap_false.
    WRITE ''.
  ENDIF.
  gv_count = 2.
  CLEAR lv_non_prime.
  gv_count = gv_count + 1.
ENDDO.
