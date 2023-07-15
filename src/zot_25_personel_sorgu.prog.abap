*&---------------------------------------------------------------------*
*& Report zot_25_personel_sorgu
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_25_personel_sorgu.

TABLES: zot_25_t_p_mast,
        zot_25_t_p_egtm,
        zot_25_t_p_iltsm,
        zot_25_t_p_aile,
        zot_25_t_p_itur.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_master RADIOBUTTON GROUP gr1,
              p_iletsm RADIOBUTTON GROUP gr1,
              p_aile   RADIOBUTTON GROUP gr1,
              p_egitim RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK b1.




TYPES: BEGIN OF gty_master,
         personel_no  TYPE zot_25_e_personel_no,
         adi          TYPE zot_25_e_personel_adi,
         soyadi       TYPE zot_25_e_personel_soyadi,
         cinsiyeti    TYPE zot_25_e_personel_cinsiyet,
         d_yeri       TYPE zot_25_e_personel_dyeri,
         d_tarihi     TYPE zot_25_e_personel_dtarih,
         medeni_hal   TYPE zot_25_e_personel_medeni,
         cocuk_sayisi TYPE zot_25_e_personel_cocuk,
       END OF gty_master.


TYPES: BEGIN OF gty_egitim,
         personel_no TYPE zot_25_e_personel_no,
         egt_kod     TYPE zot_25_e_egitim,
         okul_adi    TYPE zot_25_e_okul_adi,
         il          TYPE zot_25_e_personel_il,
         ulke        TYPE land1,
       END OF gty_egitim.


TYPES: BEGIN OF gty_iletisim,
         personel_no         TYPE zot_25_e_personel_no,
         iletisim_tur        TYPE zot_25_e_iletisim_turu,
         iletisim_taniticisi TYPE zot_25_e_iletisim_tan,
       END OF gty_iletisim.









DATA: gt_master   TYPE TABLE OF gty_master,
      gs_master   TYPE gty_master,
      gt_egitim   TYPE TABLE OF gty_egitim,
      gs_egitim   TYPE gty_egitim,
      gt_iletisim TYPE TABLE OF gty_iletisim,
      gs_iletisim TYPE gty_iletisim.

START-OF-SELECTION.

  IF p_master EQ abap_true.

    SELECT
        personel_no
      adi
      soyadi
      cinsiyeti
      d_yeri
      d_tarihi
      medeni_hal
      cocuk_sayisi
    FROM zot_25_t_p_mast INTO TABLE gt_master.


    cl_demo_output=>write( gt_master ).
  ENDIF.


  IF p_iletsm EQ abap_true.

    SELECT
     zot_25_t_p_iltsm~personel_no
     zot_25_t_p_iltsm~iletisim_tur
     zot_25_t_p_iltsm~iletisim_taniticisi
    FROM zot_25_t_p_iltsm INNER JOIN zot_25_t_p_itur ON zot_25_t_p_iltsm~iletisim_tur EQ zot_25_t_p_itur~ILETISIM_TUR INTO TABLE gt_iletisim.

    cl_demo_output=>write( gt_iletisim ).

  ENDIF.

  IF p_aile EQ abap_true.

    cl_demo_output=>write( zot_25_t_p_aile ).

  ENDIF.

  IF p_egitim EQ abap_true.


    SELECT
    personel_no
    egt_kod
    okul_adi
    il
    ulke
    FROM zot_25_t_p_egtm INTO TABLE gt_egitim.

    cl_demo_output=>write( zot_25_t_p_egtm ).

  ENDIF.



  cl_demo_output=>display( ).
