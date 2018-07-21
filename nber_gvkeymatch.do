*** before using the command, define the path to the folder that store your files
use pat76_06_assg.dta, clear

*** mapping patent assignee data to the GVKEY data in dynass.dta
merge m:1 pdpass using dynass.dta

*** only keeping patents of public companies
keep if _merge==3

*** checking duplicate patents and assignee information, zero
duplicates drop patent assgnum, force
egen id=group(patent assgnum)
reshape long pdpco  begyr  gvkey  endyr , i (id)j(seq)

***  deleting those that outside the effective rang of GVKEY
drop if appyear < begyr |appyear>endyr

*** file with only patents by public companies in the U.S. up to 2006
save pat76_06_assg_gvkeymatched.dta, replace
