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

  GPV41_SQLServer_Delete.sql

  Deletes all GPV v4.1 configuration tables.  You can set the prefix for the table names by changing 
  the value in the "set @prefix" line below.

*/

declare @prefix nvarchar(50)
set @prefix = 'GPV41'

declare @sql nvarchar(2000)

/* tables not referenced by a foreign key */

set @sql = 'DROP TABLE ' + @prefix + 'ApplicationMapTab'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'ApplicationMarkupCategory'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'ApplicationPrintTemplate'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'DataTab'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'ExternalMap'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'LayerFunction'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'LayerProximity'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'MailingLabel'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'MapTabLayer'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'Markup'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'MarkupGroup'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'MarkupSequence'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'PrintTemplateContent'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'Proximity'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'Query'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'SavedState'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'SearchInputField'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'Search'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'UsageTracking'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'User'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'ZoneLevelCombo'; exec(@sql)

/* tables referenced by a foreign key */

set @sql = 'DROP TABLE ' + @prefix + 'Application'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'Connection'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'Layer'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'Level'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'MapTab'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'MarkupCategory'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'PrintTemplate'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'Zone'; exec(@sql)
set @sql = 'DROP TABLE ' + @prefix + 'ZoneLevel'; exec(@sql)
