DROP EXTENSION IF EXISTS www_fdw CASCADE;
CREATE EXTENSION www_fdw;
CREATE SERVER www_fdw_server_test FOREIGN DATA WRAPPER www_fdw OPTIONS (uri 'http://localhost:7777', request_serialize_callback 'test_request_serialize_callback', request_serialize_type 'json', request_serialize_human_readable '1');
CREATE USER MAPPING FOR current_user SERVER www_fdw_server_test;
CREATE FOREIGN TABLE www_fdw_test (
	title text,                                                        
	link text,
	snippet text
) SERVER www_fdw_server_test;
CREATE OR REPLACE FUNCTION test_request_serialize_callback(options WWWFdwOptions, quals text, INOUT url text, INOUT post WWWFdwPostParameters) AS $$
BEGIN
	RAISE DEBUG 'options parameter: %', options;
	RAISE INFO 'quals parameter: %', quals;
	RAISE DEBUG 'url parameter: %', url;
	RAISE DEBUG 'post parameter: %', post;
END; $$ LANGUAGE PLPGSQL;