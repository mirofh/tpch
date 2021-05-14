truncate lineitem;
truncate orders;
truncate part;
truncate customer;
truncate supplier;
truncate partsupp;
truncate nation;
truncate region;

\set file 'lineitem.tbl' \set lineitem :datapath:file
\set file 'orders.tbl' \set orders :datapath:file
\set file 'part.tbl' \set part :datapath:file
\set file 'customer.tbl' \set customer :datapath:file
\set file 'supplier.tbl' \set supplier :datapath:file
\set file 'partsupp.tbl' \set partsupp :datapath:file
\set file 'nation.tbl' \set nation :datapath:file
\set file 'region.tbl' \set region :datapath:file

copy lineitem FROM :'lineitem' CSV DELIMITER '|';
copy orders FROM :'orders' CSV DELIMITER '|';
copy part FROM :'part' CSV DELIMITER '|';
copy customer FROM :'customer' CSV DELIMITER '|';
copy supplier FROM :'supplier' CSV DELIMITER '|';
copy partsupp FROM :'partsupp' CSV DELIMITER '|';
copy nation fROM :'nation' CSV DELIMITER '|';
copy region fROM :'region' CSV DELIMITER '|';

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
