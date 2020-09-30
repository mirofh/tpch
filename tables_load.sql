truncate lineitem;
truncate orders;
truncate part;
truncate customer;
truncate supplier;
truncate partsupp;
truncate nation;
truncate region;

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
alter table region drop column r_none;
alter table lineitem drop column l_none;
alter table orders drop column o_none;
alter table part drop column p_none;
alter table customer drop column c_none;
alter table supplier drop column s_none;
alter table partsupp drop column ps_none;
alter table nation drop column n_none;
