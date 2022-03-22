capture cd "/Users/csy/Desktop/final Pre/new_charles_2.csv"

import delimited "/Users/csy/Desktop/final Pre/new_charles_2.csv", varnames(1) encoding(UTF-8)clear



//////////////////////数据处理
encode xrgender, generate(x_gender)
gen gender=.
replace gender=1 if x_gender==2  //1 male
replace gender=0 if x_gender==1  //0 female

encode be001, generate(x_marriage)
gen marriage=.
replace marriage=0 if x_marriage==2  //0 unmarried
replace marriage=1 if x_marriage==1


destring age, generate(age2) ignore(`"NA"')
destring hc005, generate(deposit) ignore(`"NA"')

destring days_quality_above_grade2, generate(air_quality) ignore(`"NA"')
destring waste_gas_emission, generate(waste_gas) ignore(`"NA"')
destring avg_concentration_on_pm25, generate(pm25) ignore(`"NA"')
destring avg_concentration_on_o3, generate(o3) ignore(`"NA"')
destring avg_concentration_on_co, generate(co) ignore(`"NA"')
destring avg_concentration_on_pm10, generate(pm10) ignore(`"NA"')
destring avg_concentration_on_no2, generate(no2) ignore(`"NA"')
destring avg_concentration_on_so2, generate(so2) ignore(`"NA"')
destring green_rate, generate(green_rate2) ignore(`"NA"')

destring rate_invest_in_antipollution_on_,generate(rate_in_antipollution) ignore(`"NA"')
destring enviro_invest_share,generate(enviro_invest_share2) ignore(`"NA"')
destring green_invest_share, generate(green_invest_share2) ignore(`"NA"')
destring shirong_invest_share, generate(shirong_invest_share2) ignore(`"NA"')

//percentage
gen green_invest_share3=green_invest_share2*100 
gen enviro_invest_share3=enviro_invest_share2*100 
gen shirong_invest_share3=shirong_invest_share2*100 


///rename
rename population_demsityshixia pop_density 
///shixiaqu
rename da005_all disable
rename da001 physical_health
rename shiqu_renjun_greensqkm green_per_capita

encode city_en, generate(city_en_nu)



//////////////////////
*park rate   

reg mental_health park_rate age2 deposit gender marriage literacy disable,cluster(city_en)
outreg2 using regression1.xls,replace
reg mental_health park_rate physical_health age2  gender marriage literacy disable,cluster(city_en)
outreg2 using regression1.xls,append
reg mental_health park_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression1.xls,append

**除去身体健康数据 n 4000
reg mental_health park_rate age2 deposit gender marriage literacy disable,cluster(city_en)
outreg2 using regression1.xls,append
reg mental_health park_rate  age2 deposit gender marriage literacy disable,cluster(city_en)
outreg2 using regression1.xls,append
reg mental_health park_rate  age2 deposit gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression1.xls,append


///reg on physical health insignificant
reg physical_health park_rate age2 deposit gender marriage literacy disable ,cluster(city_en)
outreg2 using regression1.xls,append
reg physical_health park_rate age2 deposit gender marriage literacy disable pop_density grp,cluster(city_en)
outreg2 using regression1.xls,append
reg physical_health park_rate age2 deposit gender marriage literacy disable pop_density grp green_per_capita ,cluster(city_en)
outreg2 using regression1.xls,append



*park rate gender  ==0 

reg mental_health park_rate age2 deposit  marriage literacy disable if gender==0,cluster(city_en)
outreg2 using regression2.xls,replace
reg mental_health park_rate physical_health age2   marriage literacy disable if gender==0,cluster(city_en)
outreg2 using regression2.xls,append
reg mental_health park_rate physical_health age2   marriage literacy disable pop_density grp green_per_capita  if gender==0,cluster(city_en)
outreg2 using regression2.xls,append

**除去身体健康数据 n 4000
reg mental_health park_rate age2 deposit  marriage literacy disable  if gender==0,cluster(city_en)
outreg2 using regression2.xls,append
reg mental_health park_rate  age2 deposit  marriage literacy disable if gender==0,cluster(city_en)
outreg2 using regression2.xls,append
reg mental_health park_rate  age2 deposit  marriage literacy disable pop_density grp green_per_capita if gender==0,cluster(city_en)
outreg2 using regression2.xls,append


///reg on physical health insignificant
reg physical_health park_rate age2 deposit  marriage literacy disable if gender==0 ,cluster(city_en)
outreg2 using regression2.xls,append
reg physical_health park_rate age2 deposit  marriage literacy disable pop_density grp if gender==0,cluster(city_en)
outreg2 using regression2.xls,append
reg physical_health park_rate age2 deposit  marriage literacy disable pop_density grp green_per_capita if gender==0 ,cluster(city_en)
outreg2 using regression2.xls,append



*park rate gender  ==1

reg mental_health park_rate age2 deposit  marriage literacy disable if gender==1,cluster(city_en)
outreg2 using regression3.xls,replace
reg mental_health park_rate physical_health age2   marriage literacy disable if gender==1,cluster(city_en)
outreg2 using regression3.xls,append
reg mental_health park_rate physical_health age2   marriage literacy disable pop_density grp green_per_capita  if gender==1,cluster(city_en)
outreg2 using regression3.xls,append

**除去身体健康数据 n 4000
reg mental_health park_rate age2 deposit  marriage literacy disable  if gender==1,cluster(city_en)
outreg2 using regression3.xls,append
reg mental_health park_rate  age2 deposit  marriage literacy disable if gender==1,cluster(city_en)
outreg2 using regression3.xls,append
reg mental_health park_rate  age2 deposit  marriage literacy disable pop_density grp green_per_capita if gender==1,cluster(city_en)
outreg2 using regression3.xls,append


///reg on physical health insignificant
reg physical_health park_rate age2 deposit  marriage literacy disable if gender==1 ,cluster(city_en)
outreg2 using regression3.xls,append
reg physical_health park_rate age2 deposit  marriage literacy disable pop_density grp if gender==1,cluster(city_en)
outreg2 using regression3.xls,append
reg physical_health park_rate age2 deposit  marriage literacy disable pop_density grp green_per_capita if gender==1 ,cluster(city_en)
outreg2 using regression3.xls,append





////park rate cluster 


///control air quality -insignicifant
reg mental_health park_rate air_quality age2 deposit gender marriage literacy disable  pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_air.xls,replace
reg mental_health park_rate pm25 age2 deposit gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_air.xls,append
reg mental_health park_rate pm10 age2 deposit gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_air.xls,append
reg mental_health park_rate so2 age2 deposit gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_air.xls,append



////green cover

reg mental_health green_cover_rate  age2  gender marriage literacy disable,cluster(city_en)
outreg2 using regression_green.xls,replace
reg mental_health green_cover_rate physical_health age2  gender marriage literacy disable,cluster(city_en)
outreg2 using regression_green.xls,append
reg mental_health green_cover_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_green.xls,append
reg physical_health green_cover_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_green.xls,append

///female only

reg mental_health green_cover_rate  age2   marriage literacy disable  if gender==0 ,cluster(city_en)
outreg2 using regression_green.xls,append
reg mental_health green_cover_rate physical_health age2   marriage literacy disable if gender==0 ,cluster(city_en)
outreg2 using regression_green.xls,append
reg mental_health green_cover_rate physical_health age2   marriage literacy disable pop_density grp green_per_capita if gender==0,cluster(city_en)
outreg2 using regression_green.xls,append
reg physical_health green_cover_rate  age2   marriage literacy disable pop_density grp green_per_capita if gender==0,cluster(city_en)
outreg2 using regression_green.xls,append
//male only

reg mental_health green_cover_rate  age2   marriage literacy disable  if gender==1 ,cluster(city_en)
outreg2 using regression_green.xls,append
reg mental_health green_cover_rate physical_health age2   marriage literacy disable if gender==1 ,cluster(city_en)
outreg2 using regression_green.xls,append
reg mental_health green_cover_rate physical_health age2   marriage literacy disable pop_density grp green_per_capita if gender==1,cluster(city_en)
outreg2 using regression_green.xls,append
reg physical_health green_cover_rate  age2   marriage literacy disable pop_density grp green_per_capita if gender==1,cluster(city_en)
outreg2 using regression_green.xls,append



/////
reg dc009 park_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_seperate.xls,replace
reg dc010 park_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_seperate.xls,append

reg dc011 park_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_seperate.xls,append
reg dc012 park_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_seperate.xls,append
reg dc013 park_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_seperate.xls,append
reg dc014 park_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_seperate.xls,append
reg dc015 park_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_seperate.xls,append
reg dc016 park_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_seperate.xls,append
reg dc017 park_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_seperate.xls,append
reg dc018 park_rate physical_health age2  gender marriage literacy disable pop_density grp green_per_capita,cluster(city_en)
outreg2 using regression_seperate.xls,append



////////////////////////////////////////////////////////////
///fixed effect
xtset city_en_nu
xtreg mental_health park_rate age2 deposit gender marriage literacy da005_all pop_demsity_shixia
outreg2 using fe_regression.xls,replace
xtreg mental_health park_rate age2 deposit marriage if gender==0
outreg2 using fe_regression.xls,append
xtreg mental_health park_rate age2 deposit  marriage if gender==1
outreg2 using fe_regression.xls,append
xtreg mental_health park_rate air_quality age2 deposit  marriage if gender==0
outreg2 using fe_regression.xls,append
xtreg mental_health park_rate air_quality age2 deposit gender marriage 
outreg2 using fe_regression.xls,append


////iv 
//replace  park_rate=. if green_invest_share3==.
//replace  enviro_invest_share3=. if green_invest_share3==.
//replace  pop_demsity_shixia=. if green_invest_share3==.
//replace  grp=. if green_invest_share3==.
//summarize park_rate green_invest_share3 pop_demsity_shixia enviro_invest_share3 grp




//ivreg2 mental_health (park_rate=green_invest_share3) age2 deposit gender marriage literacy da005_all, cluster(city_en_nu) first

//ivreg2 mental_health (park_rate=green_invest_share3) age2 deposit gender marriage literacy da005_all, first

//显著
ivreg2 mental_health (park_rate=enviro_invest_share3) age2 deposit gender marriage literacy disable, first
outreg2 using iv.xls,replace

ivreg2 mental_health (park_rate=green_invest_share3) age2 deposit gender marriage literacy disable pop_density_shixia, first
outreg2 using iv.xls,append
//cluster unsignificant

ivreg2 mental_health (park_rate=enviro_invest_share3) age2 deposit  marriage literacy disable pop_density_shixia if gender==0, first
outreg2 using iv.xls,append

ivreg2 mental_health (park_rate=enviro_invest_share3) age2 deposit  marriage literacy disable pop_density_shixia if gender==1, first
outreg2 using iv.xls,append

ivreg2 mental_health (park_rate=enviro_invest_share3) age2 deposit gender marriage literacy disable pop_density_shixia grp, first
outreg2 using iv.xls,append

ivreg2 mental_health (park_rate=enviro_invest_share3) age2 deposit gender marriage literacy disable pop_density_shixia grp, cluster(city_en) first
outreg2 using iv.xls,append


