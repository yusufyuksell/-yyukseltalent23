CLASS zot_25_fibo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS next
      RETURNING
        VALUE(rv_result) TYPE int4 .
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA sv_current TYPE int4 VALUE 0 ##NO_TEXT.
    CLASS-DATA sv_next TYPE int4 VALUE 1 ##NO_TEXT.
ENDCLASS.



CLASS zot_25_fibo IMPLEMENTATION.
  METHOD next.
    rv_result = sv_next + sv_current.
    sv_current = sv_next.
    sv_next = rv_result.
  ENDMETHOD.

ENDCLASS.
