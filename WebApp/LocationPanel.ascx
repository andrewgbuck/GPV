﻿<%-- 
  Copyright 2012 Applied Geographics, Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>

<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LocationPanel.ascx.cs" Inherits="LocationPanel" %>
<%@ Register TagPrefix="gpv" Assembly="App_Code" Namespace="GPV" %>

<div id="pnlLocationContent">
  <div id="pnlOverviewSizer">
    <div id="pnlOverview" class="MainPanel">
      <div id="mapOverview"></div>
    </div>
  </div>
  <div id="pnlZoneLevelSizer">
    <div id="pnlZoneLevelTabs" class="TabPanel">
      <div class="TabScroll">
        <gpv:Div id="optTabZone" runat="server" CssClass="Tab Normal" style="display: none" data-table="tblZone"></gpv:Div>
        <gpv:Div id="optTabLevel" runat="server" CssClass="Tab Normal" style="display: none" data-table="tblLevel"></gpv:Div>
        <gpv:Div id="optTabLevelByZone" runat="server" CssClass="Tab Normal" style="display: none" data-table="tblLevelByZone"></gpv:Div>
      </div>
    </div>
    <div id="pnlZoneLevel" class="MainPanel">
      <gpv:Div id="pnlZoneLevelControl" runat="server" style="display: none">
        <input type="radio" id="optZoneLevelAll" name="zls" class="ZoneLevelSelection" checked="checked" /> <label for="optZoneLevelAll">All</label>&nbsp;&nbsp;
        <input type="radio" id="optZoneLevelSelected" name="zls" class="ZoneLevelSelection" /> <label for="optZoneLevelAll">Containing selection only</label>
      </gpv:Div>
      <div id="pnlZoneLevelScroll">
        <gpv:Table id="tblZone" runat="server" CssClass="ZoneLevelTable" style="display: none">
          <thead>
            <tr>
              <th class="Value">Selected</th>
              <th>Name</th>
            </tr>
          </thead>
        </gpv:Table>
        <gpv:Table id="tblLevel" runat="server" CssClass="ZoneLevelTable" style="display: none">
          <thead>
            <tr>
              <th class="Value">Selected</th>
              <th>Name</th>
            </tr>
          </thead>
        </gpv:Table>
        <gpv:Table id="tblLevelByZone" runat="server" CssClass="ZoneLevelTable" style="display: none">
          <thead>
            <tr>
              <th class="Value">Selected</th>
              <th>Name</th>
            </tr>
          </thead>
        </gpv:Table>
      </div>
    </div>
  </div>
  <div id="locationDivider"></div>
</div>