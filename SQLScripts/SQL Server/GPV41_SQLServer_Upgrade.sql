/*
  Copyright 2014 Applied Geographics, Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

  GPV31_SQLServer_Upgrade.sql

  Creates the GPV v4.1 configuration tables from an existing set of GPV v3.1 tables.
  Set the prefixes for both sets of table names by changing the values in the "set @prefix31" 
  and "set @prefix41" lines below.  Make sure to run GPV41_SQLServer_AddConstraints.sql 
  using the v4.1 prefix to create the necessary constraints on the v4.1 tables.

*/

declare @prefix31 nvarchar(50)
declare @prefix41 nvarchar(50)

set @prefix31 = 'GPV31'
set @prefix41 = 'GPV41'

declare @sql nvarchar(2000)

/* remove AllowMapTabScroll and AllowDataTabScroll from GPVApplication */

set @sql = 'CREATE TABLE ' + @prefix41 + 'Application (
  ApplicationID nvarchar(50) NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  AuthorizedRoles nvarchar(200),
  FunctionTabs nvarchar(50),
  DefaultMapTab nvarchar(50),
  DefaultAction nvarchar(50),
  DefaultTargetLayer nvarchar(50),
  DefaultProximity nvarchar(50),
  DefaultSelectionLayer nvarchar(50),
  DefaultLevel nvarchar(50),
  FullExtent nvarchar(50),
  OverviewMapID nvarchar(50),
  CoordinateModes nvarchar(50),
  ZoneLevelID nvarchar(50),
  TrackUse smallint, 
  About ntext,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'INSERT INTO ' + @prefix41 + 'Application (ApplicationID, DisplayName, AuthorizedRoles, FunctionTabs, DefaultMapTab, DefaultAction, DefaultTargetLayer, DefaultProximity, DefaultSelectionLayer, DefaultLevel, FullExtent, OverviewMapID, CoordinateModes, ZoneLevelID, TrackUse, About, Active)
  SELECT ApplicationID, DisplayName, AuthorizedRoles, FunctionTabs, DefaultMapTab, DefaultAction, DefaultTargetLayer, DefaultProximity, DefaultSelectionLayer, DefaultLevel, FullExtent, OverviewMapID, CoordinateModes, ZoneLevelID, TrackUse, About, Active
  FROM ' + @prefix31 + 'Application'
exec(@sql)

/* copy tables */

set @sql = 'SELECT * INTO ' + @prefix41 + 'ApplicationMapTab FROM ' + @prefix31 + 'ApplicationMapTab'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'ApplicationMarkupCategory FROM ' + @prefix31 + 'ApplicationMarkupCategory'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'ApplicationPrintTemplate FROM ' + @prefix31 + 'ApplicationPrintTemplate'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'Connection FROM ' + @prefix31 + 'Connection'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'DataTab FROM ' + @prefix31 + 'DataTab'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'ExternalMap FROM ' + @prefix31 + 'ExternalMap'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'Layer FROM ' + @prefix31 + 'Layer'
exec(@sql)

/* rename Function to FunctionName in GPVLayerFunction */

set @sql = 'CREATE TABLE ' + @prefix41 + 'LayerFunction (
  LayerID nvarchar(50) NOT NULL,
  FunctionName nvarchar(20) NOT NULL,
  ConnectionID nvarchar(50),
  StoredProc nvarchar(100) NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

set @sql = 'INSERT INTO ' + @prefix41 + 'LayerFunction (LayerID, FunctionName, ConnectionID, StoredProc, Active)
  SELECT LayerID, [Function], ConnectionID, StoredProc, Active
  FROM ' + @prefix31 + 'LayerFunction'
exec(@sql)

/* copy tables */

set @sql = 'SELECT * INTO ' + @prefix41 + 'LayerProximity FROM ' + @prefix31 + 'LayerProximity'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'Level FROM ' + @prefix31 + 'Level'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'MailingLabel FROM ' + @prefix31 + 'MailingLabel'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'MapTab FROM ' + @prefix31 + 'MapTab'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'MapTabLayer FROM ' + @prefix31 + 'MapTabLayer'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'Markup FROM ' + @prefix31 + 'Markup'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'MarkupCategory FROM ' + @prefix31 + 'MarkupCategory'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'MarkupGroup FROM ' + @prefix31 + 'MarkupGroup'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'MarkupSequence FROM ' + @prefix31 + 'MarkupSequence'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'PrintTemplate FROM ' + @prefix31 + 'PrintTemplate'
exec(@sql)

/* rename TextFont to FontFamily, TextSize to FontSize and TextBold to FontBold in GPVPrintTemplateContent */

set @sql = 'CREATE TABLE ' + @prefix41 + 'PrintTemplateContent (
  TemplateID nvarchar(50) NOT NULL,
  SequenceNo smallint NOT NULL,
  ContentType nvarchar(20) NOT NULL,
  DisplayName nvarchar(50),
  OriginX float NOT NULL,
  OriginY float NOT NULL,
  Width float NOT NULL,
  Height float NOT NULL,
  FillColor nvarchar(25),
  OutlineColor nvarchar(25),
  OutlineWidth int,
  LegendColumnWidth float,
  Text ntext,
  TextAlign nvarchar(6),
  TextWrap int,
  FontFamily nvarchar(16),
  FontSize int,
  FontBold int,
  FileName nvarchar(25),
  Active smallint DEFAULT 1 
)'
exec(@sql)

set @sql = 'INSERT INTO ' + @prefix41 + 'PrintTemplateContent (TemplateID, SequenceNo, ContentType, DisplayName, OriginX, OriginY, Width, Height, FillColor, 
  OutlineColor, OutlineWidth, LegendColumnWidth, Text, TextAlign, TextWrap, FontFamily, FontSize, FontBold, FileName, Active)
  SELECT TemplateID, SequenceNo, ContentType, DisplayName, OriginX, OriginY, Width, Height, FillColor, OutlineColor, OutlineWidth, LegendColumnWidth, Text, 
  TextAlign, TextWrap, TextFont, [TextSize], TextBold, FileName, Active
  FROM ' + @prefix31 + 'PrintTemplateContent'
exec(@sql)

/* copy tables */

set @sql = 'SELECT * INTO ' + @prefix41 + 'Proximity FROM ' + @prefix31 + 'Proximity'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'Query FROM ' + @prefix31 + 'Query'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'SavedState FROM ' + @prefix31 + 'SavedState'
exec(@sql)

/* create GPVSearch */

set @sql = 'CREATE TABLE ' + @prefix41 + 'Search (
  SearchID nvarchar(50) NOT NULL,
  LayerID nvarchar(50) NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  ConnectionID nvarchar(50),
  StoredProc nvarchar(100) NOT NULL,
  SequenceNo smallint NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

/* create GPVSearchInputField */

set @sql = 'CREATE TABLE ' + @prefix41 + 'SearchInputField (
  FieldID nvarchar(50) NOT NULL,
  SearchID nvarchar(50) NOT NULL,
  DisplayName nvarchar(50) NOT NULL,
  ColumnName nvarchar(50) NOT NULL,
  FieldType nvarchar(50) NOT NULL,
  ConnectionID nvarchar(50),
  StoredProc nvarchar(100),
  SequenceNo smallint NOT NULL,
  Active smallint DEFAULT 1
)'
exec(@sql)

/* copy tables */

set @sql = 'SELECT * INTO ' + @prefix41 + 'UsageTracking FROM ' + @prefix31 + 'UsageTracking'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'User FROM ' + @prefix31 + 'User'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'Zone FROM ' + @prefix31 + 'Zone'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'ZoneLevel FROM ' + @prefix31 + 'ZoneLevel'
exec(@sql)

set @sql = 'SELECT * INTO ' + @prefix41 + 'ZoneLevelCombo FROM ' + @prefix31 + 'ZoneLevelCombo'
exec(@sql)
