
data wts;
*keep block Irrigation Variety rate weight;
nblock = 4;
do sim=1 to 1;
/*seedi =30;*/
/*seedv=300;*/
/*seedr=3;*/
/*seedbl=4;*/

seedi =4524;
seedv=44140;
seedr=3555;
seedbl=123;


blk_var = 10;
irrigation_var=10;  
variety_var=10;
residual_var=45;
do block = 1 to nblock;
call streaminit(seedbl);*where random comes in;
blk_l = rand("normal", 0, sqrt(blk_var));
do irrigation = 0 to 2;
call streaminit(seedi);
irrigation_il = rand("normal", 0, sqrt(irrigation_var));
do variety = 1 to 2;
call streaminit(seedv);
variety_ijl = rand("normal", 0, sqrt(variety_var));
do rate = 1 to 3;
call streaminit(seedr);
r_ijlk = rand("normal", 0, sqrt(residual_var));
/* set inputdatacb; */
weight = 
(irrigation=0)*(variety=1)*(rate=1)*(200)+
(irrigation=0)*(variety=1)*(rate=2)*(300)+
(irrigation=0)*(variety=1)*(rate=3)*(400)+

(irrigation=1)*(variety=1)*(rate=1)*(300)+
(irrigation=1)*(variety=1)*(rate=2)*(400)+
(irrigation=1)*(variety=1)*(rate=3)*(500)+

(irrigation=2)*(variety=1)*(rate=1)*(400)+
(irrigation=2)*(variety=1)*(rate=2)*(500)+
(irrigation=2)*(variety=1)*(rate=3)*(600)+

(irrigation=0)*(variety=2)*(rate=1)*(220)+
(irrigation=0)*(variety=2)*(rate=2)*(320)+
(irrigation=0)*(variety=2)*(rate=3)*(400)+

(irrigation=1)*(variety=2)*(rate=1)*(310)+
(irrigation=1)*(variety=2)*(rate=2)*(390)+
(irrigation=1)*(variety=2)*(rate=3)*(500)+

(irrigation=2)*(variety=2)*(rate=1)*(410)+
(irrigation=2)*(variety=2)*(rate=2)*(500)+
(irrigation=2)*(variety=2)*(rate=3)*(610)+
                                blk_l + irrigation_il + variety_ijl +r_ijlk;
                *minimum level of detection;
                               * if weight<=0 then weight=0.01;
output;
end;
end;
end;
end;
end;
proc print data = wts; run;
data wts (keep = block irrigation variety rate weight);
set work.wts;
run;
proc print data = wts;
run;



