*******************************************************************************;
* pull in source data ;
*******************************************************************************;
  data part_derv_lad1_in;
    length pid $8 vnum 8.;
    set part_derv_lad1;

    *set visit number to 1 for hchs/sol baseline visit;
    vnum = 1;

    *drop extraneous variables;
    drop
      /* drop 'permit' variables, overridden by HCHS-created 'any_permit' indicator */
      np_permit
      external_permit
      commercial_permit
      ;
  run;

  data slea_lad1_in;
    length pid $8;
    set slea_lad1;

    *rename form for this dataset;
    rename form = slea_form;

    *drop extraneous variables;
    drop fseqno linenumber vers visit slea1a slea1c ;
  run;

data sbpa_lad1_in;
length pid $8;
set sbpa_lad1;


*only keep average bp measures;
keep pid sbpa5 sbpa6;
run;

  *merge sub-datasets;
  data hchs_sol_dataset;
    merge
      part_derv_lad1_in
      slea_lad1_in
    sbpa_lad1_in
      ;
    by pid;

  run;

  proc print data=hchs_sol_dataset;
  run;
