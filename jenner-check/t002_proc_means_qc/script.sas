*******************************************************************************;
* checking harmonized datasets ;
*******************************************************************************;
/* Checking for extreme values for continuous variables */

proc means data=hchs_sol_harmonized;
VAR   nsrr_age
    nsrr_bmi
  nsrr_bp_systolic
  nsrr_bp_diastolic
  nsrr_rei_ap3n
  nsrr_rei_ap4n
  nsrr_ttlprdbd_f1
    ;
run;
