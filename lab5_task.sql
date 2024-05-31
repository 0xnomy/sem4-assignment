create table vehicles (
    vehicle_id int primary key,
    make varchar(50),
    model varchar(50),
    year int
);

insert into vehicles (vehicle_id, make, model, year)
values 
    (1, 'toyota', 'camry', 2018),
    (2, 'ford', 'f-150', 2020),
    (3, 'honda', 'civic', 2019),
    (4, 'nissan', 'silverado', 2017),
    (5, 'toyota', 'corolla', 2016),
    (6, 'ford', 'escape', 2015),
    (7, 'honda', 'accord', 2018),
    (8, 'nissan', 'malibu', 2021),
    (9, 'toyota', 'rav4', 2019),
    (10, 'ford', 'explorer', 2022);

select * from vehicles

create table drivers (
    driver_id int primary key,
    name varchar,
    license_number varchar
);

insert into drivers (driver_id, name, license_number)
values 
    (1, 'nomy1', 'abc123'),
    (2, 'nomy2', 'def456'),
    (3, 'nomy3', 'ghi789'),
    (4, 'nomy4', 'jkl012'),
    (5, 'nomy5', 'mno345'),
	(6, 'nomy6', 'mno34w5'),
	(7, 'nomy7', 'mnwewqo345'),
	(8, 'nomy8', 'mnowqewq345'),
	(9, 'nomy9', 'mnoxzc345'),
	(10, 'nomy10', 'mnwqeqwo345');
	
	
select * from drivers

create table routes (
    route_id int primary key,
    origin varchar,
    destination varchar,
    distance float,
    vehicle_id int,
    driver_id int,
    foreign key (vehicle_id) references vehicles(vehicle_id),
    foreign key (driver_id) references drivers(driver_id)
);

insert into routes (route_id, origin, destination, distance, vehicle_id, driver_id)
values 
    (1, 'city 1', 'city 2', 200, 1, 1),
    (2, 'city 2', 'city 3', 150, 2, 2),
    (3, 'city 3', 'city 4', 300, 3, 3),
    (4, 'city 4', 'city 5', 250, 4, 4),
    (5, 'city 5', 'city 6', 180, 5, 5),
    (6, 'city 6', 'city 7', 220, 6, 1),
    (7, 'city 7', 'city 8', 190, 7, 2),
    (8, 'city 8', 'city 9', 280, 8, 3),
    (9, 'city 9', 'city 10', 320, 9, 4),
    (10, 'city 10', 'city 11', 210, 10, 5);
	
select * from routes
-- 1
SELECT COUNT(*) AS total_vehicles FROM Vehicles;
-- 2
select d.name, sum(r.distance) as total_distance_driven from drivers d join routes r on d.driver_id = r.driver_id group by d.name;
-- 3
select v.*, count(r.route_id) as num_routes_assigned from vehicles v join routes r on v.vehicle_id = r.vehicle_id group by v.vehicle_id;
-- 4
select r.route_id, r.origin, r.destination, string_agg(d.name, ', ') as assigned_drivers from routes r join drivers d on r.driver_id = d.driver_id group by r.route_id, r.origin, r.destination;
-- 5
select * from vehicles v where exists (select * from routes r where r.vehicle_id = v.vehicle_id);
-- 6 
select * from routes r where not exists (select * from vehicles v where v.vehicle_id = r.vehicle_id and v.make = 'toyota');
-- 7
select * from vehicles v where v.year > all (select year from vehicles);
--  checks if the year of the current vehicle (v.year) is greater than all the years in the vehicles table.
-- 8
select * from drivers d where d.driver_id = any (select driver_id from routes);
-- 9
select * from drivers d where d.driver_id in (select driver_id from routes where route_id in (1, 2, 3));
-- 10
select * from drivers d where d.license_number > any (select max(license_number) from drivers);



