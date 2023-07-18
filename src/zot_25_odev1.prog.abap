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
DATA:
  gv_ilk    TYPE i VALUE 0,
  gv_ikinci TYPE i VALUE 1,
  gv_toplam TYPE i,
  gv_sayici TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE t1 .
  PARAMETERS: gv_max  TYPE i,
              gv_krlm TYPE n.


  WHILE gv_toplam < gv_max.
    gv_toplam = gv_ilk + gv_ikinci.
    gv_ilk = gv_ikinci.
    gv_ikinci = gv_toplam.
    IF gv_toplam > gv_max.
      EXIT.
    ELSE.
      WRITE gv_toplam.
    ENDIF.
    gv_sayici += 1.
    IF gv_sayici MOD gv_krlm EQ 0.
      WRITE /.
    ENDIF.


  ENDWHILE.

SELECTION-SCREEN END OF BLOCK block1.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
