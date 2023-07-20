*&---------------------------------------------------------------------*
*& Report zot_25_t_spor
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_25_p_spor.

DATA: gv_random TYPE i.

TYPES: BEGIN OF ty_sport,
         team_id      TYPE num2,
         team_name    TYPE char30,
         team_country TYPE char3,
         team_bag     TYPE num1,
       END OF ty_sport.


TYPES : BEGIN OF ty_bag,
          team_id      TYPE num2,
          team_name    TYPE char30,
          team_country TYPE char3,
          team_bag     TYPE num1,
        END OF ty_bag.

DATA : gt_bag1 TYPE TABLE OF ty_bag,
       gs_bag1 TYPE ty_bag,
       gt_bag2 TYPE TABLE OF ty_bag,
       gt_bag3 TYPE TABLE OF ty_bag,
       gt_bag4 TYPE TABLE OF ty_bag.

DATA : gt_sport TYPE TABLE OF ty_sport,
       gs_sport TYPE ty_sport.


gt_sport = VALUE #( ( team_id = 1  team_name = 'Liverpool'       team_country = 'EN'    team_bag = 1 )
                    ( team_id = 2  team_name = 'Bayern Munih'    team_country = 'DE'    team_bag = 1 )
                    ( team_id = 3  team_name = 'Inter'           team_country = 'IT'    team_bag = 1 )
                    ( team_id = 4  team_name = 'PSG'             team_country = 'FR'    team_bag = 1 )
                    ( team_id = 5  team_name = 'Manchester City' team_country = 'EN'    team_bag = 2 )
                    ( team_id = 6  team_name = 'PSV'             team_country = 'NE'    team_bag = 2 )
                    ( team_id = 7  team_name = 'Porto'           team_country = 'PO'    team_bag = 2 )
                    ( team_id = 8  team_name = 'Real Madrid'     team_country = 'ES'    team_bag = 2 )
                    ( team_id = 9  team_name = 'B.Dortmund'      team_country = 'DE'    team_bag = 3 )
                    ( team_id = 10 team_name = 'Galatasaray'     team_country = 'TR'    team_bag = 3 )
                    ( team_id = 11 team_name = 'Marsilya'        team_country = 'FR'    team_bag = 3 )
                    ( team_id = 12 team_name = 'AJAX'            team_country = 'NE'    team_bag = 3 )
                    ( team_id = 13 team_name = 'AEK'             team_country = 'GR'    team_bag = 4 )
                    ( team_id = 14 team_name = 'Roma'            team_country = 'IT'    team_bag = 4 )
                    ( team_id = 15 team_name = 'FSCB'            team_country = 'RO'    team_bag = 4 )
                    ( team_id = 16 team_name = 'Atletico Madrid' team_country = 'ES'    team_bag = 4 ) ).



DO 100 TIMES.

  CALL FUNCTION 'GENERAL_GET_RANDOM_INT'
    EXPORTING
      range  = 16
    IMPORTING
      random = gv_random.

  IF gv_random EQ 0.
    gv_random += 1.
  ENDIF.

  SELECT SINGLE team_id, team_name, team_country, team_bag
         FROM @gt_sport AS sport
         WHERE team_id = @gv_random
         INTO @gs_sport.

*DATA gt_sport_all TYPE TABLE OF ty_sport.


  IF gs_sport-team_id = 0.
    CONTINUE.
  ELSE.

*gt_sport_all = VALUE #( BASE gt_sport_all ( LINES OF gt_bag1 )
*                                                ( LINES OF gt_bag2 )
*                                                ( LINES OF gt_bag3 )
*                                                ( LINES OF gt_bag4 ) ).
*SORT gt_sport_all BY team_name.
*DELETE ADJACENT DUPLICATES FROM gt_sport_all COMPARING team_name.

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    IF lines( gt_bag1 ) LT 4 .

      APPEND gs_sport TO gt_bag1.
      "SORT gt_bag1 BY team_id.
      "DELETE ADJACENT DUPLICATES FROM gt_bag1 COMPARING team_id.
      SORT gt_bag1 BY team_country.
      DELETE ADJACENT DUPLICATES FROM gt_bag1 COMPARING team_country.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.
      SORT gt_bag1 BY team_bag.
      DELETE ADJACENT DUPLICATES FROM gt_bag1 COMPARING team_bag.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.

*    IF lines( gt_bag1 ) eq 4.
*      LOOP AT gt_bag1 into gs_bag1.
*        READ TABLE gt_sport into data(gs_spor) WITH TABLE KEY team_id = gs_bag1-team_id.
*        delete from gt_sport where team_bag = gs_bag1-team_bag.
*      ENDLOOP.

      "DELETE gt_sport INDEX gv_random.
      DELETE gt_sport where team_id = gv_random.
      "CLEAR gs_sport.





      """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    ELSEIF lines( gt_bag2 ) LT 4 .
      APPEND gs_sport TO gt_bag2.

      "SORT gt_bag2 BY team_id.
      "DELETE ADJACENT DUPLICATES FROM gt_bag2  COMPARING team_id.
      SORT gt_bag2 BY team_country.
      DELETE ADJACENT DUPLICATES FROM gt_bag2  COMPARING team_country.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.
      SORT gt_bag2 BY team_bag.
      DELETE ADJACENT DUPLICATES FROM gt_bag2 COMPARING team_bag.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.

      ""DELETE gt_sport INDEX gv_random.
      DELETE gt_sport where team_id = gv_random.
      "CLEAR gs_sport.

      """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    ELSEIF lines( gt_bag3 ) LT 4 .
      APPEND gs_sport TO gt_bag3.
      "SORT gt_bag3 BY team_id.
      "DELETE ADJACENT DUPLICATES FROM gt_bag3  COMPARING team_id .
      SORT gt_bag3 BY team_country.
      DELETE ADJACENT DUPLICATES FROM gt_bag3  COMPARING team_country.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.
      SORT gt_bag3 BY team_bag.
      DELETE ADJACENT DUPLICATES FROM gt_bag3 COMPARING team_bag.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.

      "DELETE gt_sport INDEX gv_random.
      DELETE gt_sport where team_id = gv_random.
      "CLEAR gs_sport.

      """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    ELSEIF lines( gt_bag4 ) LT 4 .
      APPEND gs_sport TO gt_bag4.
      "SORT gt_bag4 BY team_id.
      "DELETE ADJACENT DUPLICATES FROM gt_bag4 COMPARING team_id.
      SORT gt_bag4 BY team_country.
      DELETE ADJACENT DUPLICATES FROM gt_bag4 COMPARING team_country.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.
      SORT gt_bag4 BY team_bag.
      DELETE ADJACENT DUPLICATES FROM gt_bag4 COMPARING team_bag.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.

      "DELETE gt_sport INDEX gv_random.
      DELETE gt_sport where team_id = gv_random.
      "CLEAR gs_sport.

    ELSE.
      EXIT.
    ENDIF.
    CLEAR gs_sport.
  ENDIF.
ENDDO.

cl_demo_output=>write_data( gt_bag1 ).
cl_demo_output=>write_data( gt_bag2 ).
cl_demo_output=>write_data( gt_bag3 ).
cl_demo_output=>write_data( gt_bag4 ).

cl_demo_output=>display( ).
