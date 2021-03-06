--
--  Copyright 2014 Applied Geographics, Inc.
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0

--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
--
--  GPV41_Oracle_Delete.sql
--
--  Deletes all GPV v4.1 configuration tables.  You can set the prefix for the table names by 
--  changing the value in the "prefix varchar2(10)" line below.
--

DECLARE 
  prefix varchar2(10):= 'GPV41';

BEGIN 

-- tables not referenced by a foreign key

  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'ApplicationMapTab CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'ApplicationMarkupCategory CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'ApplicationPrintTemplate CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'DataTab CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'ExternalMap CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'LayerFunction CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'LayerProximity CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'MailingLabel CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'MapTabLayer CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'Markup CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'MarkupGroup CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'MarkupSequence CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'PrintTemplateContent CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'Proximity CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'Query CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'SavedState CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'SearchInputField CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'Search CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'UsageTracking CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'User CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'ZoneLevelCombo CASCADE CONSTRAINTS';

-- tables referenced by a foreign key

  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'Application CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'Connection CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'Layer CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'Level CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'MapTab CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'MarkupCategory CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'PrintTemplate CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'Zone CASCADE CONSTRAINTS';
  EXECUTE IMMEDIATE 'DROP TABLE ' || prefix || 'ZoneLevel CASCADE CONSTRAINTS';

END;
/
