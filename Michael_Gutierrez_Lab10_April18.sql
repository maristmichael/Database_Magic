-- Gives you the prerequisites of a class you specify
create or replace function PreReqsFor(courseNumber int) 
returns refcursor as $$
declare
   courseNumber int := $1;
   resultset refcursor;
begin
   open resultset for 
      select prereqnum
      from   prerequisites
      where  coursenum = courseNumber;
   return resultset;
end;
$$ language plpgsql


-- Gives you the classes that the inputted class is a prerequisite for
create or replace function isPreReqFor(preReqNumber int) 
returns refcursor as $$
declare
   preReqNumber int := $1;
   resultset refcursor;
begin
   open resultset for 
      select coursenum
      from   prerequisites
      where  prereqnum = preReqNumber;
   return resultset;
end;
$$ language plpgsql

