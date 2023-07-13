*&---------------------------------------------------------------------*
*& Report zot_25_twitter
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_25_twitter.

TABLES zot_25_t_tid.

DATA : gs_twitter TYPE zot_25_t_tid,
       gt_twitter TYPE TABLE OF zot_25_t_tid.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_id    TYPE char5 OBLIGATORY,
              p_tweet TYPE char80 OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.


SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: p_t_at   RADIOBUTTON GROUP gr1,
              p_degis  RADIOBUTTON GROUP gr1,
              p_t_sil  RADIOBUTTON GROUP gr1,
              p_t_gstr RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK b2.




START-OF-SELECTION.

  IF p_t_at EQ abap_true.
    TRY.
        APPEND VALUE #( t_id = p_id
                        t_aciklama = p_tweet
                      ) TO gt_twitter .
        INSERT zot_25_t_tid  FROM TABLE gt_twitter .
        cl_demo_output=>display( | { p_id } ID'li tweet başarıyla atıldı | ).

      CATCH cx_sy_open_sql_db.
        cl_demo_output=>display( | { p_id } ID zaten mevcut. | ).
    ENDTRY.
  ENDIF.

  IF p_degis EQ abap_true.

    gs_twitter = VALUE #( t_id = p_id
                          t_aciklama = p_tweet ).
    MODIFY zot_25_t_tid FROM gs_twitter.
    COMMIT WORK AND WAIT.

    IF sy-subrc = 0.
      cl_demo_output=>display( | { p_id } ID'li tweet başarıyla güncellendi. | ).
    ENDIF.
  ENDIF.



  IF p_t_sil EQ abap_true.

    DELETE FROM zot_25_t_tid
                WHERE t_id = p_id.
    COMMIT WORK AND WAIT.

    IF sy-subrc = 0.
      cl_demo_output=>display( | { p_id } ID'li tweet başarıyla silindi. | ).
    ELSE.
      cl_demo_output=>display( | { p_id } ID'li tweet silinirken hata oluştu. | ).
    ENDIF.
  ENDIF.



  IF p_t_gstr EQ abap_true.

    SELECT  t_id, t_aciklama
    FROM zot_25_t_tid
    INTO TABLE @DATA(lt_twitter).

    SORT lt_twitter ASCENDING BY t_id.
    cl_demo_output=>display( lt_twitter ).
  ENDIF.
