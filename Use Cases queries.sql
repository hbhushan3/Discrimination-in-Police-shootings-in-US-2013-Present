use police_shootings; -- database

select * from victim; -- victims table

-- number of shootings during COVID-19 pandemic
select count(date) as total_death
from victim
where date like '%20' or 
date like '%/21';

-- shootings by race
select race, count(race) as total_death
from victim
where Cause_of_death like 'Gunshot'
group by race
order by total_death DESC;

-- how were the victims killed?
select cause_of_death, count(cause_of_death) as total
from victim
group by cause_of_death
order by total DESC;

-- ................................................
select * from location; -- locations table

-- shootings by state (top 5 states with highest number of killings)
select state, count(state) as total_death_state
from location
group by state
order by total_death_state DESC
limit 5;

-- shootings by state with breakdown of races (join race and location)
select state, race, count(race) as total_deaths
from victim
natural join location
group by state, race
having state like 'CA' or 
	state like 'TX' or 
    state like 'FL' or
    state like 'AZ' or 
    state like 'GA'
order by state, total_deaths DESC;

-- ................................................
select * from officer_encounter; -- officer encounter table

-- body cam?
select body_cam, count(body_cam) as total_killed
from officer_encounter
where body_cam IS NOT NULL
group by body_cam
order by total_killed DESC;

-- departments involved with encounter type
select ID, agency_responsible, encounter_type
from officer_encounter;

-- most common encounter reason
select encounter_type, count(encounter_type) as type
from officer_encounter
group by encounter_type
order by type DESC;



-- ................................................
-- future analysis (code may or may not run)
select * from alleged; -- alleged table

-- 

with total_killed as 
				(select count(*) 
				from officer_encounter)
                select encounter_type, count(encounter_type)/total_killed as rate
                from officer_encounter
                group by encounter_type;

-- extra analysis for the future
use policeshootings;
select *
from data;
-- rate of shootings by race and top 5 states
select *
from data
where state_abbreviation = 'CA' or 
state_abbreviation = 'FL' or 
state_abbreviation = 'TX' or 
state_abbreviation = 'AZ' or 
state_abbreviation = 'GA';