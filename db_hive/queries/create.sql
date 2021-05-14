create external table lineitem (
 l_orderkey bigint,
 l_partkey bigint,
 l_suppkey bigint,
 l_linenumber int,
 l_quantity double,
 l_extendedprice double,
 l_discount double,
 l_tax double,
 l_returnflag string,
 l_linestatus string,
 l_shipdate string,
 l_commitdate string,
 l_receiptdate string,
 l_shipinstruct string,
 l_shipmode string,
 l_comment string)
row format delimited fields terminated by '|' stored as textfile 
location 'dbgen/lineitem';

create external table part (p_partkey bigint,
 p_name string,
 p_mfgr string,
 p_brand string,
 p_type string,
 p_size int,
 p_container string,
 p_retailprice double,
 p_comment string) 
row format delimited fields terminated by '|' stored as textfile 
location 'dbgen/part/';

create external table supplier (s_suppkey bigint,
 s_name string,
 s_address string,
 s_nationkey int,
 s_phone string,
 s_acctbal double,
 s_comment string) 
row format delimited fields terminated by '|' stored as textfile 
location 'dbgen/supplier/';

create external table partsupp (ps_partkey bigint,
 ps_suppkey bigint,
 ps_availqty int,
 ps_supplycost double,
 ps_comment string)
row format delimited fields terminated by '|' stored as textfile
location'dbgen/partsupp';

create external table nation (n_nationkey int,
 n_name string,
 n_regionkey int,
 n_comment string)
row format delimited fields terminated by '|' stored as textfile
location 'dbgen/nation';

create external table region (r_regionkey int,
 r_name string,
 r_comment string)
row format delimited fields terminated by '|' stored as textfile
location 'dbgen/region';

create external table customer (c_custkey bigint,
 c_name string,
 c_address string,
 c_nationkey int,
 c_phone string,
 c_acctbal double,
 c_mktsegment string,
 c_comment string)
row format delimited fields terminated by '|' stored as textfile
location 'dbgen/customer';

create external table orders (o_orderkey bigint,
 o_custkey bigint,
 o_orderstatus string,
 o_totalprice double,
 o_orderdate string,
 o_orderpriority string,
 o_clerk string,
 o_shippriority int,
 o_comment string)
row format delimited fields terminated by '|' stored as textfile
location 'dbgen/orders';
