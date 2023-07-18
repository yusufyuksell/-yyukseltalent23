*&---------------------------------------------------------------------*
*& Report zot_25_p_zmn
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_25_p_zmn.
TABLES: zot_25_t_zmn,
        zot_25_t_veriler.

DATA: gv_id TYPE zot_25_e_index.
DATA: gv_count.

DATA: it_return TYPE TABLE OF ddshretval,
      wa_return TYPE ddshretval.

DATA: lt_main TYPE TABLE OF zot_25_t_zmn.
DATA: ls_main TYPE zot_25_t_zmn.

DATA : gs_veriler TYPE zot_25_t_veriler,
       gt_veriler TYPE TABLE OF zot_25_t_veriler.

DATA: seconds TYPE i.
DATA: rest    TYPE i.

DATA: yil_farki TYPE pea_scryy,
      ay_farki  TYPE pea_scrmm,
      gun_farki TYPE pea_scrdd.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_id FOR gv_id." MATCHCODE OBJECT zot_25_sh_zmn .
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  "DATA lr_id TYPE RANGE OF zot_25_t_zmn-id.
  "APPEND VALUE #( sign = 'I' option = 'BT' low = lr_id-low
  "                                         high = lr_id-high ) TO lr_id.

  SELECT *
  FROM zot_25_t_zmn
  WHERE id IN @s_id
  INTO TABLE @lt_main.

  gv_count = 0.
  DATA(lv_loop) = 0.


  DESCRIBE TABLE lt_main LINES DATA(row_count).

  DO row_count TIMES.

    gv_count = gv_count + 1.
    DATA(bas_tarih) =  lt_main[ gv_count ]-bas_tarih .
    DATA(bit_tarih) =  lt_main[ gv_count ]-bit_tarih .
    DATA(bas_saat)  =  lt_main[ gv_count ]-bas_saat .
    DATA(bit_saat)  =  lt_main[ gv_count ]-bit_saat .


    IF sy-subrc = 0.

      CALL FUNCTION 'SALP_SM_CALC_TIME_DIFFERENCE'
        EXPORTING
          date_1  = bas_tarih
          time_1  = bas_saat
          date_2  = bit_tarih
          time_2  = bit_saat
        IMPORTING
          seconds = seconds.



      CALL FUNCTION 'HR_HK_DIFF_BT_2_DATES'
        EXPORTING
          date1         = bit_tarih
          date2         = bas_tarih
          output_format = '05'
        IMPORTING
          years         = yil_farki
          months        = ay_farki
          days          = gun_farki.

      "data(gun_fark)      = seconds DIV 86400.
      rest = seconds      MOD 86400.
      DATA(saat_fark)     = rest DIV 3600.
      rest = rest         MOD 3600.
      DATA(dakika_fark)   = rest DIV 60.
      DATA(saniye_fark)   = rest MOD 60.





      DATA: yil_fark TYPE i,
            ay_fark  TYPE i,
            gun_fark TYPE i.

      yil_fark  = yil_farki.
      ay_fark   = ay_farki.
      gun_fark  = gun_farki.


      TRY.
          APPEND VALUE #( id           = s_id-low + lv_loop
                          yil_fark     = yil_fark
                          ay_fark      = ay_fark
                          gun_fark     = gun_fark
                          saat_fark    = saat_fark
                          dakika_fark  = dakika_fark
                          saniye_fark  = gun_fark
                            ) TO gt_veriler .
          INSERT zot_25_t_veriler  FROM TABLE gt_veriler .
        CATCH cx_sy_open_sql_db.
      ENDTRY.


      DATA(current_id) = s_id-low + lv_loop.

      WRITE:/ current_id , '. indexe ait kayıtta;', yil_fark NO-ZERO, 'yil',  ay_fark NO-ZERO ,'ay',   gun_fark NO-ZERO,'gün',
              saat_fark NO-ZERO,'saat', dakika_fark NO-ZERO,'dakika', saniye_fark NO-ZERO, 'saniye', 'fark vardır.'.
      "WRITE / | { s_id-low + lv_loop  }. indexe ait kayıtta; { yil_fark } yıl, { ay_fark } ay, { gun_fark } gun, { saat_fark } saat, { dakika_fark } dakika, { saniye_fark } saniye fark vardır. | .
      ULINE.

      lv_loop = lv_loop + 1.
    ELSE.
      WRITE :/ 'Error'.
    ENDIF.

  ENDDO.




*    DATA(fark)        = ABS( bit_tarih - bas_tarih ).
*    DATA(gun_fark)    = ABS( bit_tarih+6(2) - bas_tarih+6(2) ).
*    DATA(yil_fark)    = ABS( bit_tarih(4) - bas_tarih(4) ).
*    DATA(ay_fark)     = ABS( bit_tarih+4(2) - bas_tarih+4(2) ).
*    DATA(saat_fark)   = ABS( bit_saat(2) - bas_saat(2) ).
*    DATA(dakika_fark) = ABS( bit_saat+2(2) - bas_saat+2(2) ).
*    data(saniye_fark) = ABS( bit_saat+4(2) - bas_saat+4(2) ).
*    cl_demo_output=>write( | { yil_fark } yıl { ay_fark } ay   | ).
*    cl_demo_output=>write( | { gun_fark } gün  { saat_fark } saat { dakika_fark } dakika { saniye_fark } saniye fark vardır.  | ).
*    cl_demo_output=>display(  ).
*
*  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
*    EXPORTING
*      retfield               = s_id
*     VALUE_ORG              = 'S'
*    tables
*      value_tab              = it_return
*      return_tab             = it_return
*   EXCEPTIONS
*     PARAMETER_ERROR        = 1
*     NO_VALUES_FOUND        = 2
*     OTHERS                 = 3.
