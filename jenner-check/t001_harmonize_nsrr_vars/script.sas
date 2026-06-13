*******************************************************************************;
* create harmonized datasets ;
*******************************************************************************;
data hchs_sol_harmonized;
  set hchs_sol_dataset;
  *vnum exists;

*demographics
*age;
*use age;
  format nsrr_age 8.2;
  if age gt 89 then nsrr_age = 90;
  else if age le 89 then nsrr_age = age;

*age_gt89;
*use age;
  format nsrr_age_gt89;
  if age gt 89 then nsrr_age_gt89= 'yes';
  else if age le 89 then nsrr_age_gt89='no';

*sex;
*use gendernum;
  format nsrr_sex $100.;
  if gendernum = 01 then nsrr_sex = 'male';
  else if gendernum = 0 then nsrr_sex = 'female';
  else if gendernum = . then nsrr_sex = 'not reported';

*race;
*use race;
    format nsrr_race $100.;
    if race = 01 then nsrr_race = 'american indian or alaska native';
    else if race = 02 then nsrr_race = 'asian';
    else if race = 03 then nsrr_race = 'native hawaiian or other pacific islander';
    else if race = 04 then nsrr_race = 'black or african american';
    else if race = 05 then nsrr_race = 'white';
    else if race = 06 then nsrr_race = 'multiple';
  else if race = 07 then nsrr_race = 'unknown';
  else nsrr_race = 'not reported';

*ethnicity;
*set all value to 'hispanic or latino';
  format nsrr_ethnicity $100.;
    if pid ne '.' then nsrr_ethnicity = 'hispanic or latino';
  else if pid = '.' then nsrr_ethnicity = 'not reported';

*hispanic subgroup;
*use BKGRD1_C7;
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

*anthropometry
*bmi;
*use bmi;
  format nsrr_bmi 10.9;
  nsrr_bmi = bmi;

*clinical data/vital sign;
*bp_systolic;
*use sbpa5;
  format nsrr_bp_systolic 8.2;
  nsrr_bp_systolic = sbpa5;

*bp_diastolic;
*use sbpa6;
  format nsrr_bp_diastolic 8.2;
  nsrr_bp_diastolic = sbpa6;


*lifestyle and behavioral health
*current_smoker;
*use current_smoker;
  format nsrr_current_smoker $100.;
  if current_smoker = 0 then nsrr_current_smoker = 'no';
  else if current_smoker = 01 then nsrr_current_smoker = 'yes';
    else if current_smoker = . then nsrr_current_smoker = 'not reported';

*ever_smoker;
*use CIGARETTE_USE;
  format nsrr_ever_smoker $100.;
  if CIGARETTE_USE = 01 then nsrr_ever_smoker = 'no';
  else if CIGARETTE_USE = 02 then nsrr_ever_smoker = 'yes';
  else if CIGARETTE_USE = 03 then nsrr_ever_smoker = 'yes';
    else if CIGARETTE_USE = . then nsrr_ever_smoker = 'not reported';

*ever_smoker;
*not using;

*polysomnography;
*nsrr_rei_ap3n;
*use slpa54;
  format nsrr_rei_ap3n 8.2;
  nsrr_rei_ap3n = slpa54;

*nsrr_rei_ap4n;
*use slpa63;
  format nsrr_rei_ap4n 8.2;
  nsrr_rei_ap4n = slpa63;

*nsrr_ttlprdbd_f1;
*use slpa30;
  format nsrr_ttlprdbd_f1 8.2;
  nsrr_ttlprdbd_f1 = slpa30;


  keep
    pid
    vnum
    nsrr_age
    nsrr_age_gt89
    nsrr_sex
    nsrr_race
    nsrr_ethnicity
    nsrr_hispanic_subgroup
    nsrr_bmi
    nsrr_bp_systolic
    nsrr_bp_diastolic
    nsrr_current_smoker
    nsrr_ever_smoker
    nsrr_rei_ap3n
    nsrr_rei_ap4n
	nsrr_ttlprdbd_f1
  ;
run;

proc print data=hchs_sol_harmonized;
run;
