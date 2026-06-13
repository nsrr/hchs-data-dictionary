*******************************************************************************;
* autoexec for t003_proc_freq_qc                                                ;
*                                                                               ;
* The upstream QC step runs PROC FREQ over the harmonized categorical nsrr_*    ;
* variables. The harmonized dataset is normally produced from the external      ;
* solb source datasets on the BWH share. Here the source merge is replaced by   ;
* a small inline stand-in, and the upstream harmonization recodes are applied   ;
* so PROC FREQ tabulates genuinely harmonized category labels.                  ;
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

  format nsrr_age_gt89;
  if age gt 89 then nsrr_age_gt89= 'yes';
  else if age le 89 then nsrr_age_gt89='no';

  format nsrr_sex $100.;
  if gendernum = 01 then nsrr_sex = 'male';
  else if gendernum = 0 then nsrr_sex = 'female';
  else if gendernum = . then nsrr_sex = 'not reported';

  format nsrr_race $100.;
  if race = 01 then nsrr_race = 'american indian or alaska native';
  else if race = 02 then nsrr_race = 'asian';
  else if race = 03 then nsrr_race = 'native hawaiian or other pacific islander';
  else if race = 04 then nsrr_race = 'black or african american';
  else if race = 05 then nsrr_race = 'white';
  else if race = 06 then nsrr_race = 'multiple';
  else if race = 07 then nsrr_race = 'unknown';
  else nsrr_race = 'not reported';

  format nsrr_ethnicity $100.;
  if pid ne '.' then nsrr_ethnicity = 'hispanic or latino';
  else if pid = '.' then nsrr_ethnicity = 'not reported';

  format nsrr_hispanic_subgroup $100.;
  if BKGRD1_C7= '0' then nsrr_hispanic_subgroup = 'dominican';
  else if BKGRD1_C7= '01' then nsrr_hispanic_subgroup = 'centralamerican';
  else if BKGRD1_C7= '02' then nsrr_hispanic_subgroup = 'cuban';
  else if BKGRD1_C7= '03' then nsrr_hispanic_subgroup = 'mexican';
  else if BKGRD1_C7= '04' then nsrr_hispanic_subgroup = 'puertorican';
  else if BKGRD1_C7= '05' then nsrr_hispanic_subgroup = 'southamerican';
  else if BKGRD1_C7= '06' then nsrr_hispanic_subgroup = 'multiple';
  else if BKGRD1_C7= 'Q' then nsrr_hispanic_subgroup = 'unknown';
  else nsrr_hispanic_subgroup = 'not reported';

  format nsrr_current_smoker $100.;
  if current_smoker = 0 then nsrr_current_smoker = 'no';
  else if current_smoker = 01 then nsrr_current_smoker = 'yes';
  else if current_smoker = . then nsrr_current_smoker = 'not reported';

  format nsrr_ever_smoker $100.;
  if CIGARETTE_USE = 01 then nsrr_ever_smoker = 'no';
  else if CIGARETTE_USE = 02 then nsrr_ever_smoker = 'yes';
  else if CIGARETTE_USE = 03 then nsrr_ever_smoker = 'yes';
  else if CIGARETTE_USE = . then nsrr_ever_smoker = 'not reported';

  keep pid vnum nsrr_age_gt89 nsrr_sex nsrr_race nsrr_ethnicity
       nsrr_hispanic_subgroup nsrr_current_smoker nsrr_ever_smoker;
run;
