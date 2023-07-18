*&---------------------------------------------------------------------*
*& Report zot_25_p_internal_tables
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_25_p_internal_tables.

TABLES: zot_00_t_materia.

DATA: gt_materia TYPE TABLE OF zot_00_t_materia,
      gs_materia TYPE zot_00_t_materia,
      gt_malzeme TYPE HASHED TABLE OF zot_00_t_materia WITH UNIQUE KEY matnr,
      gs_malzeme TYPE zot_00_t_materia.

SELECT  *
   FROM zot_00_t_materia
   INTO TABLE gt_materia.




LOOP AT gt_materia INTO gs_materia.
  IF gs_materia-matnr LE 5.
    gt_malzeme =
        VALUE #( BASE gt_malzeme ( matnr = gs_materia-matnr + 10
                                   maktx = 'Masa'
                                   matkl = 'C'
                                   menge = 10
                                   meins = 'ST' ) ).
  ELSE.
    EXIT.
  ENDIF.
ENDLOOP.

LOOP AT gt_materia INTO gs_materia.

  READ TABLE gt_malzeme INTO gs_malzeme WITH KEY meins = gs_materia-meins.
  IF sy-subrc = 0.
    gs_materia-menge = gs_materia-menge  + 10.
    MODIFY gt_materia FROM gs_materia
    TRANSPORTING menge.

  ENDIF.

ENDLOOP.

DATA: gt_modify_table TYPE TABLE OF zot_00_t_materia,
      gs_modify_table TYPE zot_00_t_materia.

LOOP AT gt_materia INTO gs_materia.
  gt_modify_table =
        VALUE #( BASE gt_modify_table ( matnr = gs_materia-matnr
                           maktx = gs_materia-maktx
                           matkl = gs_materia-matkl
                           menge = gs_materia-menge
                           meins = gs_materia-meins ) ).
ENDLOOP.


LOOP AT gt_malzeme INTO gs_malzeme.
  gt_modify_table =
      VALUE #( BASE gt_modify_table ( matnr = gs_malzeme-matnr
                                      maktx = gs_malzeme-maktx
                                      matkl = gs_malzeme-matkl
                                      menge = gs_malzeme-menge
                                      meins = gs_malzeme-meins ) ).
ENDLOOP.


TYPES: BEGIN OF gty_collect,
         matkl TYPE matkl,
         menge TYPE menge_d,
       END OF gty_collect.

DATA: gt_collect TYPE TABLE OF gty_collect,
      gs_collect TYPE gty_collect.

LOOP AT gt_modify_table INTO gs_modify_table.
  gs_collect = VALUE #( matkl = gs_modify_table-matkl
                        menge = gs_modify_table-menge ).
  COLLECT gs_collect INTO gt_collect.
ENDLOOP.



DELETE gt_modify_table WHERE menge < 10.

SORT gt_modify_table ASCENDING  BY menge.

SORT gt_collect DESCENDING BY menge.



cl_demo_output=>display( gt_modify_table ).
cl_demo_output=>display( gt_collect ).
