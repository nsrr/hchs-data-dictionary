*******************************************************************************;
* autoexec for t005_merge_by_pid                                                ;
*                                                                               ;
* The upstream pipeline builds per-form input datasets from the external solb   ;
* libname, applies drops/renames, then MERGEs them BY pid into the combined     ;
* baseline dataset. Here the solb sources are replaced by small inline          ;
* stand-ins (participant-derived, SLEA form, SBPA blood-pressure) keyed on pid; ;
* the per-dataset drop/rename steps and the MERGE BY pid below are upstream.     ;
*******************************************************************************;
options obs=100 nofmterr;

data part_derv_lad1;
  length pid $8;
  input pid $ age gendernum bmi np_permit external_permit commercial_permit;
  datalines;
P0000001 54 1 28.4 1 0 1
P0000002 67 0 31.9 0 1 0
P0000003 90 1 24.1 1 1 1
;
run;

data slea_lad1;
  length pid $8;
  input pid $ form $ fseqno linenumber vers visit slea1a slea1c;
  datalines;
P0000001 SLEA 1 1 2 1 3 4
P0000002 SLEA 1 1 2 1 2 5
P0000003 SLEA 1 1 2 1 4 4
;
run;

data sbpa_lad1;
  length pid $8;
  input pid $ sbpa5 sbpa6 sbpa1 sbpa2;
  datalines;
P0000001 128 78 1 2
P0000002 142 88 3 4
P0000003 118 72 5 6
;
run;
