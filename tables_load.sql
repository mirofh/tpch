\copy lineitem FROM 'dbgen/lineitem.tbl' CSV DELIMITER '|';
\copy orders FROM 'dbgen/orders.tbl' CSV DELIMITER '|';
\copy part FROM 'dbgen/part.tbl' CSV DELIMITER '|';
\copy customer FROM 'dbgen/customer.tbl' CSV DELIMITER '|';
\copy supplier FROM 'dbgen/supplier.tbl' CSV DELIMITER '|';
\copy partsupp FROM 'dbgen/partsupp.tbl' CSV DELIMITER '|';
\copy nation fROM 'dbgen/nation.tbl' CSV DELIMITER '|';
\copy region fROM 'dbgen/region.tbl' CSV DELIMITER '|';

-- DBGEN creates tables with extra | in the end. 
-- this is a workaround
alter table region drop column none;
alter table lineitem drop column none;  
alter table orders drop column none; 
alter table part drop column none; 
alter table customer drop column none;
alter table supplier drop column none;
alter table partsupp drop column none;
alter table nation drop column none;
