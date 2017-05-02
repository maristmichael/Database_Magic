truncate table  UserProfiles             restart identity cascade;
truncate table  Library                     restart identity cascade;
truncate table  Users                       restart identity cascade;
truncate table  Profiles 	             restart identity cascade;
truncate table  ZIPCodes                restart identity cascade;
truncate table  GameGenres          restart identity cascade;
truncate table  DevelopedGames   restart identity cascade;
truncate table  Games 		     restart identity cascade;
truncate table  Genres                    restart identity cascade;
truncate table  Platforms                restart identity cascade;
truncate table  Developers             restart identity cascade;
truncate table  Publishers              restart identity cascade;
drop view GameGenresNoRepeatsV;
drop view AllGameNoRepeatsV;
drop view AllUsersV;
drop view PopularGamesV;
drop view AllGamesV;


drop table if exists Library;
drop table if exists UserProfiles;
drop table if exists Users;
drop table if exists Profiles;
drop table if exists ZIPCodes;
drop table if exists GameGenres;
drop table if exists GamesDeveloped;
drop table if exists Games;
drop table if exists Genres;
drop table if exists Platforms;
drop table if exists Developers;
drop table if exists Publishers;

---------Create Statements for tables ---------

-- ZIPCodes --
create table ZIPCodes (
     zip       int not null check (zip <= 99999),
     city      text,
     state    char(2),
     unique(zip, state),
     primary key(zip)
);


-- Users --
create table Users (
     userID          serial not null,
     email            text not null,
     password     text not null,
     firstName     text not null,
     lastName     text not null,
     cardNum      bigint not null check (cardNum <= 9999999999999999),
     streetAddr    text not null,
     zip                int not null check (zip <= 99999),
     unique(userID, email, cardNum),
     primary key(userID),
     foreign key(zip) references ZIPCodes(zip)
); 


-- Profiles --
create table Profiles (
     profileID         serial not null,
     profileName   text not null,
     unique(profileID),
     primary key(profileID)
);


-- Genres --
create tableGenres (
     genreID   serial not null,
     genre       text not null,
     unique(genreID, genre),
     primary key(genreID)
);


-- Platforms --
create table Platforms (
     platformID   serial not null,
     platform       text not null,
     unique(platformID, platform),
     primary key(platformID)
);


-- Publishers --
create table Publishers (
     pubID          serial not null,
     pubName    text not null,
     unique(pubID, pubName),
     primary key(pubID)
);


-- Developers --
create table Developers (
     devID          serial not null,
     devName    text not null,
     devType      char(2) not null,
     unique(devID, devName),
     primary key(devID)
);


-- Games --
create table Games (
     gameID               serial not null,
     title                      text not null,
     esrb                     text not null,
     pubID	           int,
     platformID           int not null,
     dateReleased     date not null,
     gameType          char(5) not null,
     hasMultiplayer    boolean not null,
     unique(gameID, title),
     primary key(gameID),
     foreign key(pubID)        references Publishers(pubID),
     foreign key(platformID) references Platforms(platformID)
);


-- UserProfiles --
create table UserProfiles (
     userID     int not null,
     profileID  int not null,
     primary key(userID, profileID),
     foreign key (userID)    references Users(userID),
     foreign key (profileID) references Profiles(profileID)
);


-- Library --
create table Library (
     userID         int not null,
     profileID      int not null,
     gameID       int not null,
     dateAdded  date default current_date,
     primary key(userID, profileID, gameID),
     foreign key (userID, profileID) references UserProfiles(userID, profileID),
     foreign key (gameID)              references Games(gameID)
);


select * from gamegenres
-- GameGenres --
create table GameGenres (
     gameID    int not null,
     genreID    int not null,
     primary key (gameID, genreID),
     foreign key (gameID)  references Games(gameID),
     foreign key (genreID)  references Genres(genreID)
);


-- GamesDeveloped --
create table GamesDeveloped (
     gameID   int not null,
     devID      int not null,
     primary key(gameID, devID),
     foreign key (gameID) references Games(gameID),
     foreign key (devID)    references Developers(devID)
);


---------SQL Insert Statements for example data ----------

-- ZIPCodes --
insert into ZIPCodes(zip, city, state)
   values(12601, 'Poughkeepsie', 'NY'),
              (12345, 'Schenectady', 'NY'),
              (06516, 'West Haven', 'CT');

--Users --
insert into Users (email, password, firstName, lastName, cardNum, streetAddr, zip)
   values('michael@marist.edu', 'dogs','Michael', 'Gutierrez', 1234123412341234, '3399 North Rd', 12601),
              ('alan@labouseur.com', 'alpaca','Alan', 'Labouseur', 1234432112344321, '3399 North Rd', 12601),
              ('bob@marist.edu', 'database','Bob', 'Smith', 1234123412341231, '93 Whitney Ave', 06516);

--Profiles--
insert into Profiles (profileName)
   values('Mike'),
             ('Minion'),
             ('Alpaca'),
             ('Mom'),
             ('Friend1'),
             ('Cousin'); 

-- Genre --
insert into Genres (genre)
   values('First Person'),
              ('Role Playing'),
              ('Massively Multiplayer Online'),
              ('Puzzle'),
              ('Adventure'),
              ('Action'),
              ('Shooter'),
              ('Survival'),
              ('Horror'),
              ('Fantasy'),
              ('Platformer');
   
-- Platforms --
insert into Platforms (platform)
   values('PC'),
             ('Playstation 4'),
             ('Xbox One'),
             ('Nintendo 3DS');
   
-- Publishers --
insert into Publishers (pubName)
   values('Sony Interactive Entertainment'),
              ('Square Enix'),
              ('Nintendo'),
              ('Activision'),
              ('Blizzard Entertainment'),
              ('Valve Corporation');
   
-- Developers --
insert into Developers (devName, devType)
   values('Square Enix', '3P'), 
	      ('Valve Corporation', '1P'),
	      ('Blizzard Entertainment', '3P'),
             ('Infinity Ward', '3P'),
	      ('Naughty Dog', '1P'),
	      ('Hello Games', 'ID'),
	      ('Game Freak', '2P'),
	      ('Sledgehammer Games', '3P');
	 
-- Games --
insert into Games (title, esrb, dateReleased, gameType, hasMultiPlayer, pubID, platformID)
   values('Final Fantasy XV','T', '11/29/2016','AAA', false, 2, 2),
             ('Pokemon X', 'E', '10/12/2013', 'AAA', true, 3, 4),
             ('Portal 2', 'E', '4/18/2011', 'AAA', true, 6, 1),
             ('World of Warcraft', 'T', '11/23/2004', 'AAA', true, 5, 1),
             ('Call of Duty: Modern Warfare 3', 'M', '11/8/2011', 'AAA', true, 4, 3),
             ('The Last of Us', 'M', '06/14/2013', 'AAA', true, 1, 2),
             ('No Man''s Sky', 'T', '08/12/2016', 'Indie', false, null, 1),
             ('Counter-Strike: Source', 'M', '11/04/2001', 'AAA', true, 2,1);
         
-- UserProfiles --
insert into UserProfiles (userID, profileID)
   values(1,1),
             (2,2),
             (2,3),
             (1,4),
             (2,5),
             (1,6);

-- Library --
insert into Library (userID, profileID, gameID)
   values(1,1,1), (1,1,2), (1,1,3), (1,1,4), (1,1,5), (1,1,6), (1,1,7),
	       (1,4,3),
	       (1,6,5), (1,6,6),
	       (2,2,2), (2,2,3), (2,2,4),
	       (2,3,3), (2,3,4),
	       (2,5,1), (2,5,6), (2,5,7);

-- GameGenres --
insert into GameGenres (gameID, genreID)
   values(1,6), (1,2),
              (2,2),
              (3,1), (3,4), (3,11),
              (4,2), (4,3),
              (5,1), (5,7),
              (6,5), (6,6), (6,9), (6,10),
              (7,5), (7,6), (7,8),
              (8,1), (8,7);
              
-- GamesDeveloped --
insert into GamesDeveloped (gameID, devID)
   values(1,1),
              (2,7),
              (3,2),
              (4,3),
              (5,4), (5,8),
              (6,5),
              (7,6),
              (8,2);


-------------------Views-----------------------------

-- View that shows all users
--*Note that paswords and credit card numbers are not shown in the query for security purposes
create or replace view AllUsersV as
	select userid, 
		   firstname, 
		   lastname,
		   email, 
		   city,
		   state
	from Users inner join ZIPCodes on Users.zip = ZIPCodes.zip;
	
select * from AllUsersV ;


-- View of all the Games
-- Note that there are repeating entries because games can have multiple developers and genres
create or replace view AllGamesV as
	select distinct games.gameid,
				title,
				devname as "developer",
				pubname as "publisher",
				platform, 
				esrb, 
				gametype, 
				datereleased
	from Games left outer join Publishers on Games.pubid = Publishers.pubid
	                     inner join Platforms  on Games.platformid = Platforms.platformid
	                     inner join GamesDeveloped  on Games.gameid = GamesDeveloped.gameid
	                     inner join Developers  on GamesDeveloped.devid = Developers.devid
	order by gameid asc;
	
select * from AllGamesV;

-- View of Games in order of popularity
-- Note that counter strike was not added to anyone's library
create or replace view PopularGamesV as
	select Games.gameid, title,
		   (select count(library.gameid) 
		    from library 
		    where library.gameid = games.gameid) as "TimesAdded"
	from Games
	order by "TimesAdded" desc;
	
select * from PopularGamesV;



-------------------Stored Procedures-----------------------------

-- Procedure that finds games that are of a specified type
create or replace function SearchByGenre(desiredGenre text, resultset refcursor) 
returns refcursor as $$
declare
   desiredGenre    text := $1;
   resultset    refcursor := $2;
begin
   open resultset for 
	select  Games.gameid, title --,genre <--can include to see if correct genre
	from Games inner join GameGenres  on Games.gameid = GameGenres.gameid
		              inner join Genres  on GameGenres.genreid = Genres.genreid
	where genre = desiredGenre
	order by Games.gameid asc;
   return resultset;
end;
$$ language plpgsql


-- Test case for SearchByGenre
select SearchByGenre('Action','results');
fetch all in results;

-- Procedure that finds games created by  a specified game developer
create or replace function SearchByDev(desiredDev text, resultset refcursor) 
returns refcursor as $$
declare
   desiredDev       text := $1;
   resultset    refcursor := $2;
begin
   open resultset for 
	select  Games.gameid, title--, devName as "Developer" <-- can include to check if correct developer
	from Games inner join GamesDeveloped  on Games.gameid = GamesDeveloped.gameid
			      inner join Developers  on GamesDeveloped.devid = Developers.devid
	where devName = desiredDev
	order by Games.gameid asc;
   return resultset;
end;
$$ language plpgsql


-- Test case for SearchByDev()
select SearchByDev('Valve Corporation','results');
fetch all in results;


-- Procedure that finds games by specified platform
create or replace function SearchByPlatform(desiredPlatform text, resultset refcursor) 
returns refcursor as $$
declare
   desiredPlatform       text := $1;
   resultset          refcursor := $2;
begin
   open resultset for 
	select  Games.gameid, title--, platform <-- can include to check if correct developer
	from Games inner join Platforms  on Games.platformid = Platforms.platformid
	where platform = desiredPlatform
	order by Games.gameid asc;
   return resultset;
end;
$$ language plpgsql


-- Test case for SearchByPlatform()
select SearchByPlatform('PC','results');
fetch all in results;


-- Procedure that finds games by a specified publisher
create or replace function SearchByPublisher(desiredPublisher text, resultset refcursor) 
returns refcursor as $$
declare
   desiredPublisher     text := $1;
   resultset          refcursor := $2;
begin
   open resultset for 
	select  Games.gameid, title--, pubisher <-- can include to check if correct developer
	from Games inner join Publishers  on Games.pubID = Publishers.pubID
	where pubName = desiredPublisher
	order by Games.gameid asc;
   return resultset;
end;
$$ language plpgsql

-- Test case for SearchByPublisher()
select SearchByPublisher('Activision','results');
fetch all in results;


-------------------Reports-----------------------------

-- Count of total number of games
select count(*) as "TotalGames"
from games;

-- Count of users by state
select state, count(state) as "NumOfUsers"
from Users inner join ZIPCodes on users.zip = ZIPCodes.zip
group by state
order by count(state) desc;

-- State where most users are from
select state, count(state) as "NumOfUsers"
from Users inner join ZIPCodes on users.zip = ZIPCodes.zip
group by state
order by count(state) desc
limit 1;

-- Most Popular Title
select Games.gameid, title,
	   (select count(library.gameid) 
	    from library 
	   where library.gameid = games.gameid) as "TimesAddedToLib"
from Games
order by "TimesAddedToLib" desc
limit 1;


-------------------Triggers-----------------------------

-- Checks if inserted esrb is valid
create or replace function esrbCheck()
returns trigger as $$
declare esrbCheck varchar(1);
begin
    select esrb into esrbCheck
    from Games
    where games.gameid = NEW.gameid;

    if esrbCheck  != 'E'     and
	esrbCheck  != 'E10' and
	esrbCheck  != 'T'     and
	esrbCheck  != 'M'
       then raise exception 'Unexpected esrb';
    end if;
    return NEW;
end;
$$ language plpgsql;

-- Testing esrbCheck trigger
create trigger esrbCheck after update or insert on Games for each row execute procedure esrbCheck();

insert into Games (title, esrb, dateReleased, gameType, hasMultiPlayer, pubID, platformID)
   values('Final Fantasy','D', '11/29/2016','AAA', false, 2, 2);


-------------------Security-----------------------------

-- Administratior
create role admin;
grant all
on tables in schema public
to admin;

-- Advertisers
create role advertisers;
grant select
on tables AllUsersV
to advertisers;




--------- Leftovers----------

-- Games in order by year
select extract(year from datereleased), title
from games
order by dateReleased asc;

-- Games that released after 2010 & before 2016
select *
from games
where dateReleased >= '01/01/2010' 
	and dateReleased < '01/01/2016' 
order by datereleased asc;


-- This query stores games that have multi-developers into one entry in the developer column which breaks 1NF
-- This is here just to show off that you can do that
create or replace view AllGameNoRepeatsV as
	select distinct games.gameid, title, string_agg(devname::text, ', ') as "developer", pubname as "publisher", platform, esrb, gametype, datereleased
	from Games left outer join Publishers on Games.pubid = Publishers.pubid
			       inner join Platforms  on Games.platformid = Platforms.platformid
			       inner join GamesDeveloped  on Games.gameid = GamesDeveloped.gameid
			       inner join Developers  on GamesDeveloped.devid = Developers.devid
	group by games.gameid, title,pubname,platform, esrb, gametype, datereleased
	order by gameid asc;

select * from AllGameNoRepeatsV;


-- View that let's you see all genres of a game as on entry which breaks 1NF (Just for fun)
create or replace view GameGenresNoRepeatsV as
	select distinct games.gameid, title, string_agg(genre::text, ', ')
		from Games inner join GameGenres  on Games.gameid = GameGenres.gameid
				      inner join Genres  on Genres.genreid = GameGenres.genreid
	group by games.gameid, title
	order by gameid asc;
	
select * from GameGenresNoRepeatsV;


select devName
from Developers
where devID in (
	select devID
	from GamesDeveloped 
	where gameID = '5' 
);


