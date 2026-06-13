*******************************************************************************;
* autoexec for t002_proc_means_qc                                               ;
*                                                                               ;
* The upstream QC step runs PROC MEANS over the harmonized continuous nsrr_*    ;
* variables. The harmonized dataset is normally produced from the external      ;
* solb source datasets on the BWH share. Here the source merge is replaced by   ;
* a small inline stand-in, and the upstream harmonization recodes are applied   ;
* so PROC MEANS runs against genuinely harmonized values.                       ;
*******************************************************************************;
options obs=100 nofmterr;

data hchs_sol_dataset;
  length pid $8;
  input pid $ vnum age gendernum race BKGRD1_C7 $ bmi
        sbpa5 sbpa6 current_smoker CIGARETTE_USE
        slpa54 slpa63 slpa30;
  datalines;
P0000001 1 54 1  5 03 28.4 128 78 0 02 12.3 10.1 412.0
P0000002 1 67 0  2 02 31.9 142 88 1 02  5.4  4.8 388.5
P0000003 1 92 1  5 01 24.1 118 72 0 01  2.1  1.9 405.0
P0000004 1 38 0  4 04 35.2 135 90 1 02 28.7 24.3 360.0
P0000005 1 71 1  2 00 22.8 122 70 0 01  8.9  7.2 421.5
P0000006 1 45 0  5 05 27.6 130 82 0 03 14.4 11.8 398.0
P0000007 1 60 1  6 06 33.0 148 95 1 02 41.2 36.0 350.0
P0000008 1 29 0  5 03 19.5 110 65 0 01  1.5  1.2 430.0
P0000009 1 83 1  4 02 26.7 138 85 0 02  6.8  5.5 401.0
P0000010 1 56 0  2 04 30.1 145 92 1 02 19.9 16.4 372.5
;
run;

data hchs_sol_harmonized;
  set hchs_sol_dataset;
  format nsrr_age 8.2;
  if age gt 89 then nsrr_age = 90;
  else if age le 89 then nsrr_age = age;
  format nsrr_bmi 10.9;
  nsrr_bmi = bmi;
  format nsrr_bp_systolic 8.2;
  nsrr_bp_systolic = sbpa5;
  format nsrr_bp_diastolic 8.2;
  nsrr_bp_diastolic = sbpa6;
  format nsrr_rei_ap3n 8.2;
  nsrr_rei_ap3n = slpa54;
  format nsrr_rei_ap4n 8.2;
  nsrr_rei_ap4n = slpa63;
  format nsrr_ttlprdbd_f1 8.2;
  nsrr_ttlprdbd_f1 = slpa30;
  keep pid vnum nsrr_age nsrr_bmi nsrr_bp_systolic nsrr_bp_diastolic
       nsrr_rei_ap3n nsrr_rei_ap4n nsrr_ttlprdbd_f1;
run;
