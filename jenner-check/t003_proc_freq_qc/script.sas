/* Checking categorical variables */

proc freq data=hchs_sol_harmonized;
table   nsrr_age_gt89
    nsrr_sex
    nsrr_race
    nsrr_ethnicity
    nsrr_hispanic_subgroup
    nsrr_current_smoker
    nsrr_ever_smoker;
run;
