create database gamestop_db;

use gamestop_db;

create table gamestop_db.game (gameid bigint, gametitle string, gamerating double, gameprice double, gamediscount double)
partitioned by (publisher string)
row format delimited
fields terminated by '\t';

create index gamestop_db.game_price_idx on gamestop_db.game (gameid, gameprice);

create index gamestop_db.game_rating_idx on gamestop_db.game (gameid, gamerating);

create index gamestop_db.game_discount_idx on gamestop_db.game (gameid, gamediscount);

create index gamestop_db.game_rating_discount_idx on gamestop_db.game (gameid, gamerating, gamediscount);

load data local
inpath '\path'
into table gamestop_db.game
partition (publisher = 'pname');

create table gamestop_db.customer (custid bigint, custname struct<fname:string, lname:string>,
custcontact struct<email:string, mobile:bigint>,
custgames array<bigint>,
custsince date
row format delimited
collection items terminated by ','
map keys terminated by ':';