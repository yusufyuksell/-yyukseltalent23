*&---------------------------------------------------------------------*
*& Report zot_25_data_objects
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_25_data_objects.


TYPES: gty_tip TYPE c LENGTH 12.

TYPES: BEGIN OF gty_komplex,
         alan1 TYPE c LENGTH 10,
         alan2 TYPE c LENGTH 12,
         alan3 TYPE i,
       END OF gty_komplex.


TYPES: BEGIN OF gty_student,
         name  TYPE c LENGTH 10,
         age   TYPE i,
         id    TYPE c LENGTH 10,
         bolum TYPE c LENGTH 20,
       END OF gty_student.

DATA: gv_alan1   TYPE gty_tip,
      gv_alan2   TYPE gty_komplex-alan2,
      gs_komplex TYPE gty_komplex,
      gt_komplex TYPE TABLE OF gty_komplex.

gs_komplex-alan1 = 'One'.
gs_komplex-alan2 = 'Talent'.
gs_komplex-alan3 = 23.

gt_komplex = VALUE #( ( alan1 = 'Ahmet'
                        alan2 = 'Ezdeşir'
                        alan3 = 01 )

                      ( alan1 = 'Alper'
                        alan2 = 'Birinci'
                        alan3 = 02 )

                      ( alan1 = 'Atahan'
                        alan2 = 'Cesur'
                        alan3 = 03  ) ).

APPEND VALUE #( alan1 = 'Atalay'
                alan2 = 'Şendur'
                alan3 = 04 ) TO gt_komplex.

APPEND VALUE #( alan1 = 'Berkay'
                alan2 = 'Alışkan'
                alan3 = 05 ) TO gt_komplex.

APPEND gs_komplex TO gt_komplex.

CLEAR gs_komplex.

gs_komplex-alan1 = 'Eyyüp'.
gs_komplex-alan2 = 'Kaya'.
gs_komplex-alan3 = 06.
APPEND gs_komplex TO gt_komplex.

CLEAR gs_komplex.

gs_komplex = VALUE #( alan1 = 'Eren' alan2 = 'Ünal' alan3 = 07 ).
APPEND gs_komplex TO gt_komplex.

cl_demo_output=>write( gt_komplex ).

cl_demo_output=>display( ).
